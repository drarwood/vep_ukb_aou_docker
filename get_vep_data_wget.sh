#!/bin/bash

# Create directory in which to place all required vep data
mkdir vep_data/
cd vep_data/

wget https://storage.googleapis.com/vep_dependencies/custom_annotations.tar.gz
tar -zxvf custom_annotations.tar.gz
rm custom_annotations.tar.gz

wget https://storage.googleapis.com/vep_dependencies/fasta.tar.gz
tar -zxvf fasta.tar.gz
rm fasta.tar.gz

wget https://storage.googleapis.com/vep_dependencies/plugin_data.tar.gz
tar -zxvf plugin_data.tar.gz
rm plugin_data.tar.gz

wget https://storage.googleapis.com/vep_dependencies/homo_sapiens_vep_115_GRCh38.tar.gz
tar -zxvf homo_sapiens_vep_115_GRCh38.tar.gz
rm homo_sapiens_vep_115_GRCh38.tar.gz



