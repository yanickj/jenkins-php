The purpose of this repository is to provide a demo of the PHP continuous integration server described on http://jenkins-php.org/.

#### Requirements
 * [Vagrant](http://www.vagrantup.com/)
 * [VirtualBox](https://www.virtualbox.org/ "Oracle")

#### Installation
 1. Install Vagrant and VirtualBox.
 2. Clone php-jenkins repository to a directory on your host machine. 
 3. Initialize and update git submodules (run git submodule init; git submodule update; in cloned repo directory).
 4. Invoke "vagrant up"

The included Vagrantfile will create a virtual machine, install Jenkins and the required PHP and Jenkins Plugins.  Once the Vagrant guest machine is running Jenkins can be accessed at http://192.168.50.10:8080
