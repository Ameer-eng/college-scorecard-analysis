To build the docker container, run
```
docker build -t my-rockerverse-image .
```
Then to start the RStudio server run
```
docker run --rm -p 8787:8787 -v .:/home/rstudio -it my-rockerverse-image
```
To generate the figures, use the terminal interface in RStudio to run
```
make clean
```
then
```
make all
```