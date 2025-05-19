snpEff build -c ./snpEff.config -gtf22 -v Y52

snpEff -c snpEff.config -csvStats Y52.Stats.csv -htmlStats Y52.Stats.html -o vcf  Y52  significant.recode.vcf > significant.recode.snpeff.vcf

