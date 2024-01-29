module load singularity

# cd to the directory which contain the docker tar.gz
# docker image was provided by Daniel Diaz

export SINGULARITY_BINDPATH="/data/$USER,/fdb,/lscratch"


singularity build  Parse_Pipeline_v1.1.2_docker.sif docker-archive://Parse_Pipeline_v1.1.2_docker.tar.gz 


singularity shell Parse_Pipeline_v1.1.2_docker.sif 


Singularity> split-pipe --explain
### create processed reference sequence index files.
## download genome files first
wget https://ftp.ensembl.org/pub/release-109/fasta/homo_sapiens/dna/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz;
wget https://ftp.ensembl.org/pub/release-109/gtf/homo_sapiens/Homo_sapiens.GRCh38.109.gtf.gz;

Singularity> split-pipe \
--mode mkref \
--genome_name hg38 \
--fasta /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/genomes/Homo_sapiens.GRCh38.dna.primary_assembly.fa.gz \
--genes /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/genomes/Homo_sapiens.GRCh38.109.gtf.gz \
--output_dir /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/genomes/hg38


split-pipe \
    --mode all \
    --chemistry v2 \
    --genome_dir /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/genomes/hg38/ \
    --fq1 /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/fastqs/SCAF3842_fPBMC_B1_S1_R1_001.fastq.gz \
    --fq2 /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/fastqs/SCAF3842_fPBMC_B1_S1_R2_001.fastq.gz \
    --output_dir /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/SCAF3842_fPBMC_B1_output \
    --sample SCAF3842_fPBMC_1 A1-A3 \
    --sample SCAF3842_fPBMC_2 A4-A6 \
    --sample SCAF3842_fPBMC_3 A7-A9 \
    --sample SCAF3842_fPBMC_4 A10-A12

split-pipe \
    --mode all \
    --chemistry v2 \
    --tcr_analysis \
    --parent_dir /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/SCAF3842_fPBMC_B1_output \
    --output_dir /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/SCAF3842t_fPBMC_B1_output \
    --fq1 /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/fastqs/SCAF3842t_fPBMC_B1_S1_R1_001.fastq.gz \
    --fq2 /data/dadkhahe/SingleCell_platforms/Docker_from_daniel/fastqs/SCAF3842t_fPBMC_B1_S1_R2_001.fastq.gz    



#+++++++++++++++++++++++++++++
#Docker version

load docker in docker image

docker load -i ./Parse_Pipeline_v1.1.2_docker.tar.gz 

we trasferred fastqs and genome to desktop


docker run -it \
--platform linux/amd64 \
-v /Users/dadkhahe/Documents/Parse_Bioscience_Docker_desktop:/Parse_Bioscience_Docker_desktop parse_biosciences_pipeline:1.1.2


docker run -it --platform linux/amd64 \
-v /Users/dadkhahe/Documents/Parse_Bioscience_Docker_desktop:/Parse_Bioscience_Docker_desktop parse_biosciences_pipeline:1.1.2 \
--mode all \
--chemistry v2 \
--tcr_analysis \
--parent_dir /Parse_Bioscience_Docker_desktop/SCAF3842_fPBMC_B1_output \
--output_dir /Parse_Bioscience_Docker_desktop/SCAF3842t_fPBMC_B1_output \
--fq1 /Parse_Bioscience_Docker_desktop/fastqs/SCAF3842t_fPBMC_B1_S1_R1_001.fastq.gz \
--fq2 /Parse_Bioscience_Docker_desktop/fastqs/SCAF3842t_fPBMC_B1_S1_R2_001.fastq.gz

split-pipe \
    --mode all \
    --chemistry v2 \
    --tcr_analysis \
    --parent_dir /Parse_Bioscience_Docker_desktop/SCAF3842_fPBMC_B1_output \
    --output_dir /Parse_Bioscience_Docker_desktop/SCAF3842t_fPBMC_B1_output \
    --fq1 /Parse_Bioscience_Docker_desktop/fastqs/SCAF3842t_fPBMC_B1_S1_R1_001.fastq.gz \
    --fq2 /Parse_Bioscience_Docker_desktop/fastqs/SCAF3842t_fPBMC_B1_S1_R2_001.fastq.gz    


