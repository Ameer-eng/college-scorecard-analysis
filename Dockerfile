FROM rocker/verse
RUN adduser rstudio sudo
RUN apt update && apt install -y tcl-dev
RUN R -e "install.packages('readr')";
RUN R -e "install.packages('summarytools')";
RUN R -e "install.packages(c("downloader", "readr"))";