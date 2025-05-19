qtlplot \
--vcf final.vcf.gz \
--out /analysis/result/ \
-F 2 \
--N-bulk1 30 \
--N-bulk2 30 \
--min-depth 4 \
--max-depth 100 \
--N-rep 10000 \
--min-SNPindex 0.3 --format png
