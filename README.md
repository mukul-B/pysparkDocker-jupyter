# pysparkDocker-jupyter
spark with jupyter insede docker


create folder for image 
copy docker file

docker build -t pyspark-image .
docker run --name pyspark-container -p 8888:8888 pyspark-image
