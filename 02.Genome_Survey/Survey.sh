jellyfish count -g generators -C -G 2 -s 5G -m 17 -t 52 *.fq -o reads.jf
jellyfish histo -h 65535 -f -t 52  reads.jf > reads.histo
http://qb.cshl.edu/genomescope/ Kmer_length=17 Read_length=150 Max_kmer_coverage=10000