# TEGrapher
An R package to help easily graph output files from the transposon annotation sofware [PoPoolationTE2](https://sourceforge.net/p/popoolation-te2/wiki/Home/) 
by authors Robert Kofler and Christian Schlötterer. However, there isn't any reason the package can't be used in other applications for data such as
SNP or gene frequencies as long as the input file format is consistent.

## PoPoolationTE2
Briefly PoPoolationTE2 is a software program run on a Bash command line for detecting and annotating transposable element (TE) frequencies 
in a population generally with pool-seq data. The final output file consists of TE names, locations, and frequencies in the population, and further
analysis is left up to the user. For this I've developed a package in R to make analysis a bit less cumbersome. 

## Installation  
> devtools::install_github("DambrosiCode/TEGrapher")  
> library(TEGrapher)  

## Input File Format
The final file should be in a joint output as seen [here](https://sourceforge.net/p/popoolation-te2/wiki/signature%20file%20format/#differences-between-joint-and-separate-analysis). Therefore all files used within this package should be formatted like the following:

| Pop | Group | Loc | . | Name | Family | F/R | - | Pop 1 | Pop n |
|-----|------------|--------------------------|---|------|--------|-----------------|---|----------|----------|
| Pop | Chromosome | Physical Location on Chr | . | Name | Family | Forward/Reverse | - | Frequency in Pop n | Frequency in Pop n |
| Pop | Chromosome | Physical Location on Chr | . | Name | Family | Forward/Reverse | - | Frequency in Pop n | Frequency in Pop n |
| Pop | Chromosome | Physical Location on Chr | . | Name | Family | Forward/Reverse | - | Frequency in Pop n | Frequency in Pop n |
| Pop | Chromosome | Physical Location on Chr | . | Name | Family | Forward/Reverse | - | Frequency in Pop n | Frequency in Pop n |
| Pop | Chromosome | Physical Location on Chr | . | Name | Family | Forward/Reverse | - | Frequency in Pop n | Frequency in Pop n |
| Pop | Chromosome | Physical Location on Chr | . | Name | Family | Forward/Reverse | - | Frequency in Pop n | Frequency in Pop n |

