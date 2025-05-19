1. BUSCO
   busco -i genome.fasta  -l embryophyta_odb10 -o busco -m genome --cpu 2
   busco -i longest_isoform.fasta  -l embryophyta_odb10 -o busco -m prot --cpu 2

2. N50 length
   java -jar gnx.jar genome.fasta >genome.fasta.N50

3. QV
   meryl k=21 count output ${Sample}_1.meryl ${Sample}_1_clean.fq.gz threads=12
   meryl k=21 count output ${Sample}_2.meryl ${Sample}_2_clean.fq.gz threads=12
   meryl union-sum output ${Sample}.meryl ${Sample}_*.meryl threads=12
   merqury.sh ${Sample}.meryl genome.fasta QV_${Sample}
   
