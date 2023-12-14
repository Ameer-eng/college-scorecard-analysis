This project is an analysis of the College Scorecard dataset, which is available at https://collegescorecard.ed.gov/data/. To make the analysis reproducible, it is done inside a docker container.

Using This Repository
=====================
The analysis can be generated via the following steps. First start up Docker Desktop. 
To build the docker container, run
```
docker build -t my-rockerverse-image .
```
Then to start the docker container and the RStudio server run
```
docker run --rm -p 8787:8787 -v .:/home/rstudio -it my-rockerverse-image
```
Visit http://localhost:8787 in your browser and use the password given to you when starting the docker container to access the RStudio development environment.  To generate the report, use the terminal, accessible within the RStudio IDE, to run
```
make clean
```
```
make report.html
```
The report is now generated in the report.html file.