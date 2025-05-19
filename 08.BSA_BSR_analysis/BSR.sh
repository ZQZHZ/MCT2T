STAR --genomeDir ${star_index} --runThreadN 20 --readFilesIn ../${sample2}_1_clean.fq.gz ../${sample2}_2_clean.fq.gz --readFilesCommand zcat --outFileNamePrefix ${sample2} --outSAMtype BAM SortedByCoordinate  --outSAMmapqUnique 60 --outBAMsortingThreadN 128 --outSAMstrandField intronMotif --outFilterIntronMotifs RemoveNoncanonical
samtools addreplacerg -r '@RG\tID:AN3\tSM:AN3\tPL:illumina' ${sample2}Aligned.sortedByCoord.out.bam|samtools view -@ 30 -q 30 - -b -o ${sample2}.sort.q30.bam
gatk MarkDuplicates -I ${sample2}.sort.q30.bam -O ${sample2}.sort.q30.markdup.bam -M ${sample2}.metrics.txt --REMOVE_SEQUENCING_DUPLICATES true   
gatk SplitNCigarReads -R "${genome}" -I "${sample2}.sort.q30.markdup.bam" -O "${sample2}.sort.q30.markdup.split.bam" 

gtx vc \
   -r $genome \
   -i ${sample1}.sort.q30.markdup.split.bam \
   -o ${sample1}.g.vcf.gz \
   -g

gtx vc \
   -r $genome \
   -i ${sample2}.sort.q30.markdup.split.bam \
   -o ${sample2}.g.vcf.gz \
   -g

gtx joint \
-r $genome \
   -v ${sample1}.g.vcf.gz\
   -v ${sample2}.g.vcf.gz \
   -o ${sample1}_${sample2}.vcf.gz

vcftools --gzvcf ${gzvcf} --max-missing 1 --min-alleles 2 --max-alleles 2 --minQ 30 --minDP 10 --maxDP 100 --remove-filtered-all --recode-INFO-all --recode --out filter.${vcf}

mv filter.${vcf}.recode.vcf filter.${vcf}

bcftools view --types snps \
--output-type v \
--output filter.snp.${vcf} \
filter.${vcf}


perl BSA_ED.pl -vcf filter.snp.${vcf} \
-bulk1 AN3 \
-bulk2 SEN4 \
-power 1 \
-minDP 10 \
-maxDP 250 \
-window 500 \
-step 50 \
-outpre filter.snp.BSR-ED

## sliding window绘图
Rscript BSA_ED_sliding.R \
BSR-ED.snp_EDpower1.tsv \
filter.snp.BSR-ED.sliding_EDpower1.tsv \
chr.len \
99 \
sliding-filter.snp.BSR-ED1
## loess拟合绘图
Rscript BSA_ED_loess.R \
BSR-ED.snp_EDpower1.tsv \
chr.len \
99 \
loess-filter.snp.BSR-ED1



