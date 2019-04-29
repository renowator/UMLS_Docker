FROM mysql:5.7 
######################################## UMLS PART #################################
ARG MYSQL_DATABASE=umls
ARG MYSQL_USER=’root’@‘localhost’
ARG MYSQL_PASSWORD=“”
ARG MYSQL_ROOT_PASSWORD=“”

ENV MYSQL_DATABASE=${MYSQL_DATABASE}
ENV MYSQL_USER=${MYSQL_USER}
ENV MYSQL_PASSWORD=${MYSQL_PASSWORD}
ENV MYSQL_ROOT_PASSWORD=${MYSQL_ROOT_PASSWORD}



# Install dependencies
RUN apt-get update && apt-get upgrade -y && \   
    apt-get install build-essential -y && apt-get install perl -y && \
    apt-get install libdbd-mysql-perl -y
RUN echo “Install perl dependencies”&&\
    cpan App::cpanminus &&\
    cpanm Lingua::Stem &&\
    cpanm Text::NSP &&\
    cpanm Text::OverlapFinder &&\
    cpanm -i Digest::SHA1

ADD umls_init.sh /
ADD /NET /NET
ADD /META /META
ADD /UMLS-Similarity-1.47 /UMLS-Similarity-1.47
ADD /UMLS-Interface-1.51 /UMLS-Interface-1.51


# Create Databases
COPY CreateDatabase.sql /seed.sql


# Start mysq; run populate and copy contents in /var/lib/mysql to /data
RUN service mysql start && \
    mysql -u root --password=${MYSQL_ROOT_PASSWORD} < /seed.sql && \
    chmod +x umls_init.sh && ./umls_init.sh && \
    service mysql stop && mkdir /data && \
    mv /var/lib/mysql/* /data && chmod 777 -R /data
RUN rm -rf NET && rm -rf META
# Remove library folders and make symlinks to saved copies on entry
COPY db_init.sh /docker-entrypoint-initdb.d/
############################################################################

# Expose ports.
EXPOSE 3306
