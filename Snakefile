#sample definition
SAMPLES = ["S8",
          "S16",
          "S25",
          "S27",
          "S36"]


#top-level rule to get output of cpgtools step
rule all:
  input: expand('{sample}.ccs.combined.bed',  sample=SAMPLES)

#rules with commands to execute  
rule pbmm2:
  conda: "my.bio3.yml"
  input: expand('{sample}.5mc.hifi.bam',  sample=SAMPLES)
  output: expand('{sample}.5mc.aligned.hifi.bam',  sample=SAMPLES)
  shell: """
    pbmm2 align /home/asillers/Genome/farr1.mmi {input} {output} --sort
  """
    
rule cpgtools:
  conda: "my.bio3.yml"
  input: expand('{sample}.5mc.aligned.hifi.bam',  sample=SAMPLES)
  output: expand('{sample}.ccs.combined.bed',  sample=SAMPLES)
  shell: """
    pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/bin/aligned_bam_to_cpg_scores --bam {input} --output-prefix {sample}.cpg --model pb-CpG-tools-v2.3.1-x86_64-unknown-linux-gnu/models/pileup_calling_model.v1.tflite --threads 12
  """
