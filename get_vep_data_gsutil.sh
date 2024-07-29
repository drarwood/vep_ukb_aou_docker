#!/bin/bash

# Create directory in which to place all required vep data
mkdir vep_data/
cd vep_data/

# Assumes gsutil configured
gsutil -m cp gs://vepdata/custom_annotations.tar.gz .
tar -zxvf custom_annotations.tar.gz
rm custom_annotations.tar.gz

gsutil -m cp gs://vepdata/fasta.tar.gz .
tar -zxvf fasta.tar.gz
rm fasta.tar.gz

gsutil -m cp gs://vepdata/plugin_data.tar.gz .
tar -zxvf plugin_data.tar.gz
rm plugin_data.tar.gz

gsutil -m cp gs://vepdata/homo_sapiens_vep_110_GRCh38.tar.gz .
tar -zxvf homo_sapiens_vep_110_GRCh38.tar.gz
rm homo_sapiens_vep_110_GRCh38.tar.gz



