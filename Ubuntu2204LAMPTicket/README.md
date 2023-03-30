# <p align="center">Install osTicket on Ubuntu 22.04 with LAMP<p/>

<p align="center">
  <img src="https://osticket.com/wp-content/uploads/2021/03/osticket-supsys-new-1-e1616621912452.png" width="300" />
</p>

<p align="center">This tutorial outlines installing osTicket on an Ubuntu server leveraging LAMP as a platform to host the application. The
shell commands assume you have access to Terminal (in my case I SSH'ed into my VM that is hosted on my Proxmox VE home lab).<p/>

## Environments and Technologies I Used

- LAMP (Linux, Apache, MariaDB, PHP)
- Virtual Machine on Homelab using Proxmox VE (not required)
- SSH (not required)
- osTicket
- Shell scripts

## Operating Systems Used

- Ubuntu LTS 22.04

## Steps

### <p align="center">Step 1: Make Sure System Is Up to Date<p/>

```sh
$ sudo apt-get -y upgrade; [ -e /var/run/reboot-required ] && sudo reboot
```

```
- This command performs a system upgrade by updating all installed packages on the system using the apt-get package manager. The -y flag automatically 
answers yes to any prompts that may appear during the upgrade process. The second part of the command checks if a reboot is required after the upgrade. 
It does this by checking if a file named "reboot-required" exists in the /var/run directory. If the file exists, it means that a reboot is required to 
complete the upgrade. If a reboot is required, the command then uses the && operator to run the "sudo reboot" command, which will reboot the system. If 
a reboot is not required, this section of the command will not run.
```

### <p align="center">Step 2: Set a Server Hostname<p/>

```sh
$ sudo hostnamectl set-hostname osticket.gdomain.com
```

```
- Edit the "osticket.gdomain.com" to create your own alias.
```

```sh
$ sudo nano /etc/hosts
192.168.0.222 osticket.gdomain.com
```

```
- Edit /etc/hosts text file with nano (vim works too, and you can do this by replacing "nano" with "vim" and map the newly created hostname to the correct IP.
```
### <p align="center">Step 3: Install and Configure MariaDB (leveraging MySQL) Database<p/>

<p align="center">The goal here is to create one MySQL database with a valid user, password and hostname (you will want to save these 3 as they are required
for installation of osTicket. The user will have to be given FULL priveleges.<p/>

```sh
$ sudo apt update
$ sudo apt install mariadb-server -y
```

```
- The following commands can be executed to install MariaDB from the repositories of OS APT (Ubuntu *and other Linux distro's package manager system).
```

```sh
$ sudo mysql_secure_installation
```

```
- Secure installation works by setting up a root password, removing anonymous users, disabling remote root login, and removing test databases. 
  By default, MySQL may have a blank root password and anonymous users with full privileges. This can pose a security risk to the system as anyone 
  with access to the MySQL server can access and modify the databases on the system.
```

```sh
$ sudo mysql -u root -p
```

```sql
CREATE DATABASE osticket_db;
GRANT ALL PRIVILEGES ON osticket_db.* TO osticket_user@localhost IDENTIFIED BY "Str0ngDBP@ssw0rd";
FLUSH PRIVILEGES;
QUIT;
```

```
- These MySQL commands create a new database named 'osticket_db' and a new MySQL user named 'osticket_user' with full privileges on the 
database. The user is assigned a password and can only connect to MySQL from the local machine.
```
### <p align="center">Step 4: Install PHP and its Required Extensions<p/>


```sh
$ sudo apt update
$ sudo apt install lsb-release ca-certificates apt-transport-https software-properties-common -y
$ sudo add-apt-repository ppa:ondrej/php
```

```
- These commands install the necessary packages and repository to set up the latest version of PHP on a Linux system. The first command updates the package 
list, the second installs required packages, and the third adds a repository containing the latest version of PHP.
```

```sh
$ sudo apt update
$ sudo apt install php8.0 php8.0-common -y
$ sudo apt install php8.0-imap php8.0-apcu php8.0-intl php8.0-cgi php8.0-mbstring php8.0-gd php8.0-mysql php8.0-bcmath php8.0-xml -y
```

```
- These commands install PHP 8.0 and the necessary extensions required for web applications on a Linux system. The first command updates the package list, 
the second installs the PHP core packages and common modules. The third installs the commonly required extensions such as IMAP, APCu, Intl, CGI, Mbstring, 
GD, MySQL, Bcmath, and XML.
```

### <p align="center">Step 5: Download and install osTicket<p/>

```sh
$ sudo apt install curl wget unzip -y
```

```
- Install the curl, wget, and unzip packages and use the -y flag to automatically confirm the installation.
```

```sh
$ curl -s https://api.github.com/repos/osTicket/osTicket/releases/latest|grep browser_download_url| cut -d '"' -f 4 | wget -i -
```

```
- This command allows you to easily download the latest osTicket release from GitHub using the terminal. It works by utilizing the curl and wget commands 
to fetch the necessary information from the GitHub API and download the file to the current directory. Here's how it works:

Here's how it works:
- `curl` fetches the latest release information from GitHub API and pipes it to `grep`.
- `grep` searches for the line containing "browser_download_url".
- `cut` extracts the fourth field of that line, which is the URL of the download.
- `wget` uses the `-i` option to read the URLs from standard input, which is provided by the output of `cut` and downloads the file to the current directory. 
```

```sh
$ unzip osTicket-v*.zip -d osTicket
```

```
- Unzip the osTicket-v*.zip and then use the -d flag to create a new destination directory "osTicket".
```

```sh
$ ls osTicket
```

```
- List the contents to see two different directories "scripts" and "upload".
```

```sh
$ sudo mv osTicket /var/www/
```

```
- Moves the osTicket directory to the document root directory of the web server, which is typically `/var/www/html` or `/var/www/`. Moving the osTicket 
directory to this location makes the osTicket application accessible to the web server and to users who access it via a web browser.
```

```sh
$ cd /var/www/osTicket/upload/include
$ sudo cp ost-sampleconfig.php ost-config.php
```

```
- This command takes the ost-sampleconfig.php that comes with the downloaded "include" directory, and renames it to "ost-config.php" the setup script is 
looking for. The "ost-config.php" file is used by osTicket to read these settings and configure the application accordingly. 
```

```sh
$ sudo chown -R www-data:www-data /var/www/
```

```
- This command changes the ownership of the "/var/www/" directory and its contents to "www-data:www-data", which allows the Apache web server to read 
and write files in that directory. 

What is "www-data:www-data"?
`www-data:www-data` is a user and group combination that is commonly used by web servers such as Apache and Nginx on Ubuntu-based systems. 

The `www-data` user is a system account that is created during the installation of Apache or Nginx web servers. It is used by the web server to run 
its processes and access web files on the system.
```

```sh
$ sudo a2dissite 000-default.conf
$ sudo rm /var/www/html/index.html
$ sudo systemctl restart apache2
```

```
- These commands disable the default Apache virtual host (allowing osTicket to be enabled and used instead), remove the 
default index file, and restart the Apache web server (to make sure these changes take effect).
```

### <p align="center">Step 6: Configure Apache Web Server<p/>

```sh
$ sudo nano /etc/apache2/sites-available/osticket.conf
```

```
- This command opens the "osticket.conf" file for editing using the nano text editor.
```

```sh
<VirtualHost *:80>
     ServerAdmin admin@example.com
     DocumentRoot /var/www/osTicket/upload
     ServerName osticket.gdomain.com
     ServerAlias www.osticket.gdomain.com
     <Directory /var/www/osTicket/>
          Options FollowSymlinks
          AllowOverride All
          Require all granted
     </Directory>

     ErrorLog ${APACHE_LOG_DIR}/osticket_error.log
     CustomLog ${APACHE_LOG_DIR}/osticket_access.log combined
</VirtualHost>
```

```
- Copy and paste this text into the "osticket.conf" file and save and exit. This configuration will serve the osTicket application.
*Be sure to change the ServerName and ServerAlias to be the same as the "hostname" you set in the beginning
*Be sure to edit the DocumentRoot to the path you've set for your osTicket files
```

```sh
$ sudo a2ensite osticket.conf
$ sudo systemctl restart apache2
```

```
- These commands enable the Apache virtual host configuration file `osticket.conf` and restart the Apache web server.
```

```sh
$ sudo apachectl -t
Syntax OK
```

```
- This command checks that syntax is correct. We're looking for "OK"
```

```sh
$ sudo systemctl restart apache2
```

```
- Restart!
```

### <p align="center">Step 7: Install and Configure osTicket<p/>

<p align="center">LAMP is setup, so we can now finish installation by setting up osTicket from GUI.
Open either using the ServerName or IP address of the server in a web browser.
</p>

<p align="center">
  <img src="https://i.imgur.com/qnY4Y3q.png" width="800" />
</p>

<p align="center">The page should look like this above.
</p>

<p align="center">
  <img src="https://i.imgur.com/8zuWA2Y.png" width="800" />
</p>

<p align="center"> Once all requirements are met, click "Continue".
</p>

<p align="center">
  <img src="https://i.imgur.com/h71SXzm.png" width="800" />
</p>

<p align="center">Fill all the information (you can use my example or create your own) and then click "Install Now".
</p>

<p align="center">
  <img src="https://i.imgur.com/5sSuVhD.pngg" width="800" />
</p>

<p align="center">Above appears if you have a successful installation.
</p>

```sh
$ sudo chmod 0644 /var/www/osTicket/upload/include/ost-config.php
```

```
- This command changes the permission of ost-config.php to remove write access.
```

```sh
$ sudo rm -rf /var/www/osTicket/upload/setup/
```

```
- This command removes the setup directory.
```

<p align="center">
  <img src="https://i.imgur.com/qmnUJoi.png" width="800" />
</p>

<p align="center">To now login with a user account, the staff control panel is found at (in my case) osticket.gdomain.com/scp.
</p>

<p align="center">
  <img src="https://i.imgur.com/UG755V0.png" width="800" />
</p>

<p align="center">If you can access the control panel, you've completed installation, configuration and basic configuration! 
</p>

<p align="center">I hope this tutorial helped in installing osTicket on an Ubuntu hosted LAMP stack. This is great practice
to prepare you for an IT support position.</p>
