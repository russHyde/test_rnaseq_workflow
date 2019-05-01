# Project `test_rnaseq_workflow`

## Overview

Initialised this test project using `data_buddy` cookiecutter

- Uses conda env `bfx_vanguard`; which is a conda env that contains a range of
  bioinformatics packages

Initialised a git repo within the created project

```
cd test_rnaseq_workflow
git init
```

Test data obtained from one of my research projects `tki_rg_rnaseq`

```
# in data/int/
cat ~/int_data/tki_rg_rnaseq_201812/fastq/ID002-03/002-3_S3_L001_R1_001.fastq.gz | \
  gunzip - | head -n1000 | gzip - > sample1_R1.fastq.gz

cat ~/int_data/tki_rg_rnaseq_201812/fastq/ID002-03/002-3_S3_L001_R2_001.fastq.gz | \
  gunzip - | head -n1000 | gzip - > sample1_R2.fastq.gz

cat ~/int_data/tki_rg_rnaseq_201812/fastq/ID002-03/002-3_S3_L002_R1_001.fastq.gz | \
  gunzip - | head -n1000 | gzip - > sample2/run1_R1.fastq.gz

cat ~/int_data/tki_rg_rnaseq_201812/fastq/ID002-03/002-3_S3_L002_R2_001.fastq.gz | \
  gunzip - | head -n1000 | gzip - > sample2/run1_R2.fastq.gz
```

Made a link to a human genome reference (GRCh38 / ensembl 84):

```
# In ./data/ext_data/genomes
ln -s ../../../../ext_data/genomes/GRCh38 .
```

The datafiles and the link were added to the git repo (though I normally
exclude any data/ directories from git)

Added `rnaseq_workflow` as a git subtree

```
# Allow us to refer to the git repo using shorthand `rnaseq_workflow`
git remote add -f rnaseq_workflow git@github.com:russHyde/rnaseq_workflow

# Ensure that the working tree is committed or stashed before this call:
git subtree add \
    --prefix subjobs/rnaseq_workflow \
    rnaseq_workflow master --squash
```

```
# you can do this to update the rnaseq_workflow subtree:
# git pull --prefix subjobs/rnaseq_workflow rnaseq_workflow master --squash
```

Set up the config info for `rnaseq_workflow`:

- Added directories `conf/` and `conf/rnaseq_workflow`

- Added conf/snake_config.yaml with contents

```
rnaseq_samples: "conf/rnaseq_samples.tsv"
rnaseq_program_params: "conf/rnaseq_program_params.yaml"
rnaseq_reference_params: "conf/rnaseq_reference_params.yaml"
```

- Added `conf/rnaseq_workflow/rnaseq_program_params.yaml` with the following
  contents (note that there should really be some adapter / poly-[ACGTN]
  trimming in a call to cutadapt):

```
cutadapt-pe: >-
    --trim-n --max-n=0.3 --nextseq-trim=20 --minimum-length=20

featureCounts: "-s0 -T2 -t exon -g gene_id"

hisat2: "--new-summary --omit-sec-seq"
```

- Added `conf/rnaseq_workflow/rnaseq_reference_params.yaml` with the following
  contents:

```
index: data/ext/genomes/GRCh38/hisat2/genome_tran
annotation: data/ext/genomes/GRCh38/ensembl.v84/Homo_sapiens.GRCh38.84.gtf.gz
```

- Added `conf/rnaseq_workflow/rnaseq_samples.tsv` with the following contents:

```
study_id	sample_id	run_id	lane_id	fq1	fq2
test_rnaseq_workflow	sample1	sample1_run1	L0	data/int/test_fastqs/sample1_R1.fastq.gz	data/int/test_fastqs/sample1_R2.fastq.gz
test_rnaseq_workflow	sample2	sammple2_run1	L0	data/int/test_fastqs/sample2/run1_R1.fastq.gz	data/int/test_fastqs/sample2/run1_R2.fastq.gz
```

Added code to the main "Snakefile" for the test project

```
subworkflow rnaseq_workflow:
    workdir:
        "subjobs/rnaseq_workflow"
    snakefile:
        "subjobs/rnaseq_workflow/Snakefile"
    configfile:
        "subjobs/rnaseq_workflow/conf/snake_config.yaml"

rule all:
    input:
        rnaseq_workflow("doc/prefilter/fake_report.pdf"),
        rnaseq_workflow("doc/align/fake_report.pdf")
```

Added "rnaseq_workflow" as a named subjob in `.sidekick/setup/subjob_names.txt`

Added `data/job/rnaseq_workflow` and `logs/rnaseq_workflow` to directories
constructed during `./sidekick setup`

Moved fastq files to be in subdirectory of `./data/int/fastq rather` than
`./data/int/test_fastqs`

Run using command

```
snakemake -p --configfile conf/snake_config.yaml --use-conda
```

## Dataset details

<!-- User to fill in the details -->

## To run the project

Change in to the project directory.

If necessary, create the conda environment for the main project:

`conda create --name test_rnaseq_workflow --file envs/requirements.txt`

Activate the project's environment

`conda activate test_rnaseq_workflow`

Set up the filepaths and project-specific packages:

`./sidekick setup`

[Optional] If you have set up a set of validation tests for the input data:

`./sidekick validate --yaml <input_validation_tests>.yaml`

Run the snakemake file:

`snakemake --use-conda <flags>`

The flags recommended for the current project are as follows:

<!-- User to update the flags, based on project requirements -->

- No flags recommended

[Optional] If you have set up a set of validation tests for the results file
(recommended within iterative projects):

`./sidekick validate --yaml <results_validation_tests>.yaml`
