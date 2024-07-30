# Specify the base image -- here we're using one that bundles the OpenJDK version of Java 8 on top of a generic Debian Linux OS
FROM ubuntu:22.04
ARG DEBIAN_FRONTEND=noninteractive

#Set the working directory to be used when the docker gets run
WORKDIR /usr

RUN DEBIAN_FRONTEND=noninteractive apt-get update && \
        apt-get upgrade -y && \
        apt-get install -y  wget nano git-all cpanminus build-essential libbz2-dev liblzma-dev zlib1g-dev expat libexpat1-dev libmysqlclient-dev


RUN cpanm install Archive::Zip Archive::Extract DBI DBD::mysql DBI XML::Parser XML::DOM XML::LibXML XML::Twig BioPerl Config::Tiny Set::IntervalTree Test::Warnings Test::Exception Try::Tiny


RUN git clone https://github.com/Ensembl/ensembl-vep.git && cd ensembl-vep/ && git checkout release/110

ENV PERL5LIB=${PERL5LIB}:/usr/lib/x86_64-linux-gnu/perl5
ENV PERL5LIB=${PERL5LIB}:/etc/perl
ENV PERL5LIB=${PERL5LIB}:/usr/share/doc/perl
ENV PERL5LIB=${PERL5LIB}:/usr/share/perl
ENV PERL5LIB=${PERL5LIB}:/usr/.vep/Plugins/
ENV PERL5LIB=${PERL5LIB}:/usr/.vep/cache
ENV PERL5LIB=${PERL5LIB}:/usr/ensembl-vep

ENV PERL5LIB=${PERL5LIB}:/usr/local/share/perl/5.32.1
ENV PERL5LIB=${PERL5LIB}:/usr/local/lib/x86_64-linux-gnu/perl/5.32.1
ENV PERL5LIB=${PERL5LIB}:/usr/share/perl/5.32.1

ENV PERL5LIB=${PERL5LIB}:/usr/ensembl-vep
ENV PATH=${PATH}:/usr/vep/htslib

ENV PATH=${PATH}:/usr/ensembl-vep

RUN mkdir /usr/.vep
RUN mkdir /usr/data/
ENV HOME=/usr

RUN perl /usr/ensembl-vep/INSTALL.pl --AUTO ap \
    --DESTDIR /usr/ensembl-vep \
    --CACHEDIR /usr/.vep \
    --PLUGINS \
AlphaMissense,AncestralAllele,\
Blosum62,\
CADD,CAPICE,CCDSFilter,CSN,Carol,ClinPred,Condel,Conservation,\
DAS,DisGeNET,dbNSFP,dbscSNV,DisGeNET,Downstream,Draw,\
Enformer,EVE,\
FATHMM_MKL,FATHMM,FlagLRG,FunMotifs,\
G2P,GWAS,GXA,GeneSplicer,Geno2MP,gnomADc,GO,\
HGVSIntronOffset,HGVSReferenceBase,\
IntAct,\
LD,LOEUR,LocalID,LoFtool,LOVD,\
MTR,Mastermind,MaveDB,MaxEntScan,miRNA,MPC,MTR,NearestExonJB,\
NearestGene,neXtProt,NMD,\
Phenotypes,PolyPhen_SIFT,PON_P2,PostGAP,PrimateAI,ProteinSeqs,pLI\
ReferenceQuality,REVEL,RankFilter,\
SameCodon,satMutMPRA,SingleLetterAA,SpliceAI,SpliceRegion,StructuralVariantOverlap,SubsetVCF,\
TSSDistance

# loftee and utrannotator will be downloaded separately

## LOFTEE
RUN apt-get install -y libdbd-mysql-perl libmariadb-dev-compat samtools bcftools tabix libpng-dev libssl-dev build-essential

RUN wget https://github.com/ucscGenomeBrowser/kent/archive/v335_base.tar.gz
RUN tar xzf v335_base.tar.gz

RUN export KENT_SRC=/usr/kent-335_base/src
RUN export MACHTYPE=$(uname -m)
RUN export CFLAGS="-fPIC"
RUN export MYSQLINC=`mysql_config --include | sed -e 's/^-I//g'`
RUN export MYSQLLIBS=`mysql_config --libs`
WORKDIR /usr/kent-335_base/src/lib
RUN echo 'CFLAGS="-fPIC"' > ../inc/localEnvironment.mk

RUN make clean && make
WORKDIR ../jkOwnLib
RUN make clean && make

RUN ln -s /usr/kent-335_base/src/lib/x86_64/* /usr/kent-335_base/src/lib/
### SEEMS TO WORK UP TO HERE ON EXEUTING THE BUILD ###

# Set up directory and get files for LOFTEE
WORKDIR /usr/.vep/Plugins
RUN git clone --branch grch38 https://github.com/konradjk/loftee.git
WORKDIR /usr/.vep/Plugins/loftee
ENV PERL5LIB=${PERL5LIB}:/usr/.vep/Plugins/loftee

ENV KENT_SRC=/usr/kent-335_base/src
RUN cpanm install Bio::DB::BigBed


## UTRAnnotator
WORKDIR /usr/.vep/Plugins
RUN git clone https://github.com/ImperialCardioGenetics/UTRannotator.git
ENV PERL5LIB=${PERL5LIB}:/usr/.vep/Plugins/UTRannotator


# Finally move to directory containing VEP exectutable
WORKDIR /usr/ensembl-vep
