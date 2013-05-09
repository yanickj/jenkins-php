#/bin/bash

echo '# Install PHP';
yum install php -y -q
yum install php-xml -y -q

echo '# Update Pear and install packages - (this will take a while)';
yum install php-pear -y -q
pear upgrade PEAR
pear config-set auto_discover 1
pear install pear.phpqatools.org/phpqatools  

echo '# Installing Java - (this may take a while).'
yum install java-1.6.0-openjdk -y -q

echo '# Installing Ant - (please be patient)'
yum install ant -y -q

echo '# Installing Jenkins'
wget --quiet -O /etc/yum.repos.d/jenkins.repo http://pkg.jenkins-ci.org/redhat/jenkins.repo
rpm --import http://pkg.jenkins-ci.org/redhat/jenkins-ci.org.key
yum install jenkins -y -q

echo '# Configuring IPTables'
iptables -I INPUT 1 -i eth1 -p tcp --dport 8080 -j ACCEPT

echo '# Starting Jenkins'
service jenkins start

echo '# Installing Jenkins Plug-ins'
wget --quiet http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar
java -jar jenkins-cli.jar -s http://127.0.0.1:8080 install-plugin \
checkstyle cloverphp dry htmlpublisher jdepend plot pmd violations xunit git

echo '# Restarting Jenkins'
java -jar jenkins-cli.jar -s http://127.0.0.1:8080 safe-restart
