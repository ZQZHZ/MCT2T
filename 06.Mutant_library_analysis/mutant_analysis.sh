vcftools --vcf all.mutant.vcf.gz --min-alleles 2 --max-alleles 2 --max-missing 0.7 --minDP 5 --minGQ 20 --mac 6 --minQ 30 --remove-filtered-all --recode-INFO-all --recode --out all.mutant.vcf.filter

vcftools --vcf all.mutant.vcf.filter.recode.vcf --remove-indels --out all.mutant.vcf.filter.snps --recode --recode-INFO-all

vcftools --vcf all.mutant.vcf.filter.recode.vcf --keep-only-indels --out all.mutant.vcf.filter.indel --recode --recode-INFO-all

snpEff -c snpEff.config -csvStats ./all.mutant.vcf.filter.Stats.csv -htmlStats ./all.mutant.vcf.filter.Stats.html -o vcf  S  all.mutant.vcf.filter.recode.vcf > all.mutant.vcf.filter.recode.snpeff.vcf

