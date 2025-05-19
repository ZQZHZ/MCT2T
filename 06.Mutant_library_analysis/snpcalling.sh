fastp -i sample.R1.fastq.gz -I sample.R2.fastq.gz -o sample.R1.clean.fastq.gz -O sample.R2.clean.fastq.gz

bwa-mem2 mem -v 1 -t 52 -M -Y -R "@RG\tID:sample\tSM:sample\tPL:illumina\tLB:sample\tPU:sample" sample.R1.clean.fastq.gz sample.R2.clean.fastq.gz | samtools sort -@ 52 -o sample.sort.bam

samtools view -h -f 3 sample.sort.bam | egrep -v 'XA:Z|SA:Z' | samtools sort -@ 52 -o sample.truemap.sort.bam

gatk  --java-options "-Xmx32G" MarkDuplicates -I sample.truemap.sort.bam -O sample.final.bam -M sample.final.metrics --REMOVE_DUPLICATES true --USE_JDK_DEFLATER true --USE_JDK_INFLATER true --CREATE_INDEX false --VALIDATION_STRINGENCY SILENT

gatk HaplotypeCaller -I P1_L3_130A30.q30.final.bam --output P1_raw.g.vcf --reference /data/wangy/YRB-BSA/guaci/0.ref/Dali-11_chr.fasta

gatk CombineGVCFs -R Y52.genome.fasta --variant sample1.g.vcf --variantsample2.g.vcf --variant sample3.g.vcf -O all.mutant.vcf.gz