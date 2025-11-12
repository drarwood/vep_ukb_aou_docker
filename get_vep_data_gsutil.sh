#!/bin/bash

# Create directory in which to place all required vep data
mkdir vep_data/
cd vep_data/

# Assumes gsutil configured
gsutil -m cp gs://vep_dependencies/v115/custom_annotations.tar.gz .
tar -zxvf custom_annotations.tar.gz
rm custom_annotations.tar.gz

gsutil -m cp gs://vep_dependencies/v115/fasta.tar.gz .
tar -zxvf fasta.tar.gz
rm fasta.tar.gz

gsutil -m cp gs://vep_dependencies/v115/plugin_data.tar.gz .
tar -zxvf plugin_data.tar.gz
rm plugin_data.tar.gz

gsutil -m cp gs://vep_dependencies/v115/homo_sapiens_vep_115_GRCh38.tar.gz .
tar -zxvf homo_sapiens_vep_115_GRCh38.tar.gz
rm homo_sapiens_vep_115_GRCh38.tar.gz



