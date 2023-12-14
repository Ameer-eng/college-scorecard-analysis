.PHONY: all
all: .created-dirs generate-figures

.PHONY: clean
clean:
	rm -rf figures
	rm -rf .created-dirs

.created-dirs:
	mkdir -p figures
	touch .created-dirs

source-data/Most-Recent-Cohorts-Institution.csv: get-source-data.R
	Rscript get-source-data.R

generate-figures: figures/admission-rate-vs-SAT.png figures/admission-rate-vs-ACT.png

figures/admission-rate-vs-SAT.png figures/admission-rate-vs-ACT.png: source-data/Most-Recent-Cohorts-Institution.csv admission-rates-vs-test-scores.R
	Rscript admission-rates-vs-test-scores.R