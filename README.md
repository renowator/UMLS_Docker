# Creating Docker Image with UMLS db ver. up to 2018AB 


You can create a Docker Image with custom UMLS database installed using provided files. The Docker image can then be transferred to other machine for research and devlopment purposes. Deployment time of container with running database ~5mins.
# Prepare environment to create image

  - Run UMLS Java-based installer with required version and level of installation.
  - Copy contents of this folder to the installation folder containing /NET and /META folders.
  - Copy UMLS-Interface-1.51 (https://metacpan.org/release/UMLS-Interface) and UMLS-Similarity-1.47 (https://metacpan.org/release/UMLS-Similarity) into the installation folder containing /NET and /META folders.
  - In /NET/populate_net_mysql_db.sh file replace corresponding lines with following:
-- ` MYSQL_HOME=/usr `
-- ` user=root `
-- ` password= `
-- ` db_name=umls `
-- ` $MYSQL_HOME/bin/mysql -vvv --local-infile $db_name < mysql_net_tables.sql >> mysql_net.log 2>&1 `
  - In META/populate_mysql_db.sh replace lines as 1-4 above and:
  -- In each lne starting with ` $MYSQL_HOME/bin/mysql ` replace ` -u $user -p $password ` with ` -vvv --local-infile `

# Build Docker image and run containers with the image
 - With Docker Daemon running execute command  ` docker build -t umls-v-your_version . ` to buiuld an image. If all the instructions above were followed you will not have any errors. This might take a few hours.
 - Once the image is built you can run containers with ` docker run --name=container_name umls-v-your_version ` 
 - The UMLS database will not be available instantly. Once the container is running the database will load and MySQL will be restarted. To check if database is available you can use ` docker logs container_name | grep Shutdown `. If this command returns no result, the database is still loading.
 - You can run commands in the image using ` docker exec -it container_name command `






