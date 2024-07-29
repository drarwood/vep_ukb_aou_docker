```
# Example command for chr 22
sudo docker run -itv /home/dnanexus/vep_data:/usr/data drarwood/vep vep \
  -i /usr/data/ukb24310_c22_ALL_v1_var_list_indels_normalised.vcf \
  -o /usr/data/chr22.vep \
  --tab \
  --assembly GRCh38 \
  --offline \
  --cache \
  --dir_cache /usr/data/ \
  --fasta /usr/data/fasta/Homo_sapiens.GRCh38.dna.toplevel.fa.gz \
  --everything \
  --fork 32 \
  --no_stats \
  --custom /usr/data/custom_annotations/riboseq_mudge_et_al_st2_data_ARW.bed.gz,riboseq_orf,bed,overlap,0 \
  --custom /usr/data/custom_annotations/chen_constraint_z_Supplementary_Data_2_region_labels.bed.gz,constraint_z_region,bed,overlap,0 \
  --custom /usr/data/custom_annotations/phastConsElements30way_region_labels.bed.gz,phast_cons_30way_region,bed,overlap,0 \
  --custom /usr/data/custom_annotations/phastConsElements30way_lod.bed.gz,phast_cons_30way_lod,bed,overlap,0 \
  --custom /usr/data/custom_annotations/phastConsElements30way_score.bed.gz,phast_cons_30way_score,bed,overlap,0 \
  --custom /usr/data/custom_annotations/phastConsElements100way_region_labels.bed.gz,phast_cons_100way_region,bed,overlap,0 \
  --custom /usr/data/custom_annotations/phastConsElements100way_lod.bed.gz,phast_cons_100way_lod,bed,overlap,0 \
  --custom /usr/data/custom_annotations/phastConsElements100way_score.bed.gz,phast_cons_100way_score,bed,overlap,0 \
  --custom /usr/data/custom_annotations/jarvis_ranked_deduplicated.22.hg38.score.bed.gz,jarvis_score,bed,exact,0 \
  --custom /usr/data/custom_annotations/jarvis_ranked_deduplicated.22.hg38.percentile_score.bed.gz,jarvis_score_percentile,bed,exact,0 \
  --plugin CADD,/usr/data/plugin_data/whole_genome_SNVs.tsv.gz,/usr/data/plugin_data/gnomad.genomes.r3.0.indel.tsv.gz \
  --plugin Conservation,/usr/data/plugin_data/gerp_conservation_scores.homo_sapiens.GRCh38.bw \
  --plugin SpliceAI,snv=/usr/data/plugin_data/spliceai_scores.raw.snv.hg38.vcf.gz,indel=/usr/data/plugin_data/spliceai_scores.raw.indel.hg38.vcf.gz \
  --plugin REVEL,/usr/data/plugin_data/new_tabbed_revel_grch38.tsv.gz \
  --plugin LoF,loftee_path:/usr/.vep/Plugins/loftee,gerp_bigwig:/usr/data/gerp_conservation_scores.homo_sapiens.GRCh38.bw,human_ancestor_fa:/usr/data/human_ancestor.fa.gz,conservation_file:/usr/data/loftee.sql \
  --plugin UTRannotator,/usr/.vep/Plugins/UTRannotator/uORF_5UTR_GRCh38_PUBLIC.txt \
  --plugin AlphaMissense,file=/usr/data/plugin_data/AlphaMissense_hg38.tsv.gz \
  --plugin EVE,file=/usr/data/plugin_data/eve_merged.vcf.gz \
  --plugin PrimateAI,/usr/data/plugin_data/PrimateAI_scores_v0.2_GRCh38_sorted.tsv.bgz \
  --plugin SpliceRegion >& chr22.vep.csl &

```
