
sleep 5
chmod +x NET/populate_net_mysql_db.sh
# chmod +x META/populate_mysql_db.sh


cd NET && perl -pi -e 's/\t/ /g' mysql_net_tables.sql && sh populate_net_mysql_db.sh && \
cat mysql_net.log && cd ..

sleep 5

cd META
perl -pi -e 's/\t/ /g' mysql_tables.sql && sh populate_mysql_db.sh && \
cat mysql_net.log 

sleep 1
echo "Installing UMLS-Interface"
cd ../UMLS-Interface-1.51 

echo “Running perl Makefile.PL”
perl Makefile.PL 
echo “Running make”
make 
echo “Running make test”
make test
echo “Running sudo make install”
make install

echo "Installing UMLS-Similarity"
cd ../UMLS-Similarity-1.47 

echo “Running perl Makefile.PL”
perl Makefile.PL 
echo “Running make”
make 
echo “Running make test”
make test
echo “Running sudo make install”
make install


