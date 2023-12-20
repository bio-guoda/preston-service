Preston server configuration

assuming ubuntu 20.04 LTS minimal

updated some time around 2022-05-18

# add users

```
sudo adduser [username]

sudo usermod -aG sudo [username]

sudo -u [username] /bin/bash
cd /home/[username]/
mkdir .ssh
curl https://github.com/[username].keys > .ssh/authorized_keys
vi .ssh/authorized_keys
chmod  700 .ssh/
cd .ssh/
chmod 600 authorized_keys 
chown [username]:[username] -R /home/[username]/.ssh
```

# disable remote logins with passwords

Edit /etc/ssh/sshd_config:

```
ChallengeResponseAuthentication no
PasswordAuthentication no
PermitRootLogin no
```
# disable syslog

prevents filling up your system with logs - instead, just stick with using systemd's journal :

```
sudo systemctl disable syslog.socket
```

To apply sudo systemctl reload ssh

# create preston user

```
sudo useradd -r -s /bin/false preston
```

# install packages

```
sudo apt install openjdk-8-jdk-headless

sudo apt install nginx

sudo apt-get install build-essential git zip
```

# install certbot

follow certbot.eff.org instructions


# mount storage box

```
$ sudo mkdir /etc/preston/
$ sudo touch /etc/preston/storagebox-u302912-sub3-credentials.txt
$ sudo chmod 0600 /etc/preston/storagebox-u302912-sub3-credentials.txt 
$ ls -lha /etc/preston/
total 8.0K
drwxr-xr-x  2 root root 4.0K May 18 21:19 .
drwxr-xr-x 80 root root 4.0K May 18 21:18 ..
-rw-------  1 root root    0 May 18 21:19 storagebox-u302912-sub3-credentials.txt

$ sudo nano /etc/preston/storagebox-u302912-sub3-credentials.txt
username=[REPLACE ME]
password=[REPLACE_ME]

$ sudo mkdir /mnt/storagebox-u302912-sub3
```


add to /etc/fstab

```
# storage box u302912-sub3 (preston data)
# see https://askubuntu.com/questions/1210867/remount-cifs-on-network-reconnect
//u302912-sub3.your-storagebox.de/u302912-sub3 /mnt/storagebox-u302912-sub3 cifs iocharset=utf8,rw,credentials=/etc/preston/storagebox-u302912-sub3-credentials.txt,uid=preston,gid=preston,file_mode=0755,dir_mode=0755,vers=1.0,noauto,x-systemd.automount,x-systemd.idle-timeout=30 0 0

# install cifs mount helper
# https://docs.hetzner.com/robot/storage-box/access/access-samba-cifs/

$ sudo apt install cifs-utils
```

# apply changes

```
sudo mount -a
```

# install uncomplicated firewall (ufw)

```
sudo apt install ufw
```


## configure certbot to allow http for auto-renew

```
sudo mkdir -p /etc/letsencrypt
sudo cp etc/letsencrypt/cli.ini /etc/letsencrypt/cli.ini
```

where cli.ini contains something like:

```
# Manage Firewall
pre-hook = ufw allow http
post-hook = ufw deny http
```

# rsync examples from previous server

```
sudo -u preston rsync -avL -e "ssh -p 9934 -i /etc/preston/.ssh/id_rsa" preston@deeplinker.bio:/home/preston/preston-bhl .

sudo -u preston rsync -avL -e "ssh -p 9934 -i /etc/preston/.ssh/id_rsa" preston@deeplinker.bio:/home/preston/preston-obis .

sudo -u preston rsync -avL -e "ssh -p 9934 -i /etc/preston/.ssh/id_rsa" preston@deeplinker.bio:/var/www/html/preston-obis .

sudo -u preston rsync -avL -e "ssh -p 9934 -i /etc/preston/.ssh/id_rsa" preston@deeplinker.bio:/var/www/html/preston-ala .

sudo -u preston rsync -avL -e "ssh -p 9934 -i /etc/preston/.ssh/id_rsa" preston@deeplinker.bio:/home/preston/preston-dataone .
```

## Preston 

use https://github.com/bio-guoda/preston instructions to install preston cli. 



## systemd config

```
sudo ln -s /var/lib/preston/nginx/preston.guoda.bio /etc/nginx/sites-enabled/preston.guoda.bio
```

```
sudo ln -s /var/lib/preston/systemd/system/preston-obis.service /lib/systemd/system/preston-obis.service
sudo ln -s /var/lib/preston/systemd/system/preston-obis.timer /lib/systemd/system/preston-obis.timer

sudo ln -s /var/lib/preston/systemd/system/preston-bhl.service /lib/systemd/system/preston-bhl.service
sudo ln -s /var/lib/preston/systemd/system/preston-bhl.timer /lib/systemd/system/preston-bhl.timer

sudo ln -s /var/lib/preston/systemd/system/preston-dataone.service /lib/systemd/system/preston-dataone.service
sudo ln -s /var/lib/preston/systemd/system/preston-dataone.timer /lib/systemd/system/preston-dataone.timer

sudo ln -s /var/lib/preston/systemd/system/preston-checklistbank.service /lib/systemd/system/preston-checklistbank.service
sudo ln -s /var/lib/preston/systemd/system/preston-checklistbank.timer /lib/systemd/system/preston-checklistbank.timer

sudo ln -s /var/lib/preston/systemd/system/preston-ala.service /lib/systemd/system/preston-ala.service
sudo ln -s /var/lib/preston/systemd/system/preston-ala.timer /lib/systemd/system/preston-ala.timer

sudo ln -s /var/lib/preston/systemd/system/preston-dbg.service /lib/systemd/system/preston-dbg.service

sudo ln -s /var/lib/preston/systemd/system/preston-brit.service /lib/systemd/system/preston-brit.service
sudo ln -s /var/lib/preston/systemd/system/preston-brit.timer /lib/systemd/system/preston-brit.timer

sudo ln -s /var/lib/preston/systemd/system/preston-bionomia.service /lib/systemd/system/preston-bionomia.service
sudo ln -s /var/lib/preston/systemd/system/preston-bionomia.timer /lib/systemd/system/preston-bionomia.timer

sudo ln -s /var/lib/preston/systemd/system/preston-wikidata.service /lib/systemd/system/preston-wikidata.service
sudo ln -s /var/lib/preston/systemd/system/preston-wikidata.timer /lib/systemd/system/preston-wikidata.timer

sudo ln -s /var/lib/preston/systemd/system/preston.service /lib/systemd/system/preston.service
sudo ln -s /var/lib/preston/systemd/system/preston.timer /lib/systemd/system/preston.timer

sudo systemctl daemon-reload

sudo systemctl enable preston.timer
sudo systemctl start preston.timer
sudo systemctl enable preston-ala.timer
sudo systemctl start preston-ala.timer
sudo systemctl enable preston-brit.timer
sudo systemctl start preston-brit.timer
sudo systemctl enable preston-bionomia.timer
sudo systemctl start preston-bionomia.timer
sudo systemctl enable preston-bhl.timer
sudo systemctl start preston-bhl.timer
sudo systemctl enable preston-dataone.timer
sudo systemctl start preston-dataone.timer
sudo systemctl enable preston-checklistbank.timer
sudo systemctl start preston-checklistbank.timer
sudo systemctl enable preston-obis.timer
sudo systemctl start preston-obis.timer


sudo ln -s /var/lib/preston/systemd/system/preston-server-md5.service /lib/systemd/system/preston-server-md5.service
sudo ln -s /var/lib/preston/systemd/system/preston-server-sha256.service /lib/systemd/system/preston-server-sha256.service
sudo ln -s /var/lib/preston/systemd/system/preston-server-sha1.service /lib/systemd/system/preston-server-sha1.service

sudo ln -s /var/lib/preston/systemd/system/preston-web.service /lib/systemd/system/preston-web.service

sudo systemctl daemon-reload

sudo systemctl start preston-server-md5.service
sudo systemctl enable preston-server-md5.service

sudo systemctl start preston-server-sha256.service
sudo systemctl enable preston-server-sha256.service

sudo systemctl start preston-server-sha1.service
sudo systemctl enable preston-server-sha1.service

sudo systemctl start preston-web.service
sudo systemctl enable preston-web.service
```

----

