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
