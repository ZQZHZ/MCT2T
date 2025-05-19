perl EDTA.pl --genome Y52.genome.fasta --species others --sensitive 1 --anno 1 --threads 128  

exonerate --model protein2genome -q Cucumber.CLv4.pep.fa -t Y52.genome.fasta.mod.MAKER.masked --showtargetgff --showalignment no>Y52masked_Cucumber.CLv4_output.gff

liftoff -g Chr_genome_final_gene.gff3 -o Y52.gene.gff3 -p 46 -chroms chr.txt -u ./unmap.txt -t Y52.genome.fasta -r Lachesis_assembly_changed.fa
