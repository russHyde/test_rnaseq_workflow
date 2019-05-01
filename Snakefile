# Snakefile for project `test_rnaseq_workflow`

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
