.PHONY: clean
clean:
	rm -rf figures
	rm -rf .created-dirs
	rm -rf report.html

.created-dirs:
	mkdir -p figures
	touch .created-dirs

source-data/Most-Recent-Cohorts-Institution.csv: get-source-data.R
	Rscript get-source-data.R

figures/admission-rate-vs-SAT.png figures/admission-rate-vs-ACT.png: source-data/Most-Recent-Cohorts-Institution.csv admission-rates-vs-test-scores.R
	Rscript admission-rates-vs-test-scores.R

figures/earnings_after_10_years.png figures/top_20_earnings_quartiles.png: source-data/Most-Recent-Cohorts-Institution.csv earnings.R
	Rscript earnings.R

report.html: figures/admission-rate-vs-SAT.png figures/admission-rate-vs-ACT.png figures/earnings_after_10_years.png figures/top_20_earnings_quartiles.png
	R -e "rmarkdown::render(\"report.Rmd\", output_format=\"html_document\")"