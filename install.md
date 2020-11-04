Preston server configuration notes.



# add kafka user
```
sudo useradd -r -s /bin/false kafka
```

install kafka in /var/lib/kafka/kafka_[version]/
create symlink to /var/lib/kafka/kafka-current/



```
sudo mkdir -p /var/lib/kafka /var/cache/kafka
sudo chown kafka:kafka /var/lib/kafka /var/cache/kafka
```


## systemd config

```
sudo ln -s /var/lib/preston/nginx/sites-available/default /etc/nginx/sites-enabled/default
```

```
sudo ln -s /var/lib/preston/systemd/system/preston-web.service /lib/systemd/system/preston-web.service
sudo ln -s /var/lib/preston/systemd/system/kafka.service /lib/systemd/system/kafka.service
sudo ln -s /var/lib/preston/systemd/system/zookeeper.service /lib/systemd/system/zookeeper.service

sudo systemctl daemon-reload

sudo systemctl start preston-web.service
sudo systemctl enable preston-web.service

sudo systemctl start kafka.service
sudo systemctl enable kafka.service

sudo systemctl start zookeeper.service
sudo systemctl enable zookeeper.service
```

----
## creating kafka topics
```
sudo -u kafka /var/lib/kafka/kafka-current/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic email --config cleanup.policy=compact --config delete.retention.ms=100 --config segment.ms=100 --config min.cleanable.dirty.ratio=0.01

sudo -u kafka /var/lib/kafka/kafka-current/bin/kafka-topics.sh --create --zookeeper localhost:2181 --replication-factor 1 --partitions 1 --topic arctos --config cleanup.policy=compact --config delete.retention.ms=100 --config segment.ms=100 --config min.cleanable.dirty.ratio=0.01
```
## sending/ receiving messages

With neat commandline tools ```kafkacat```
see https://github.com/edenhill/kafkacat

install
```
sudo apt install kafkacat
```

### consuming messages
```
$ kafkacat -b localhost:9092 -t email
% Auto-selecting Consumer mode (use -P or -C to override)
email	hash://sha256/f55bcfe2fecb108d11246b00ce3ba1a207db2b21a2f143f93e75be45299a66c1
email	hash://sha256/f55bcfe2fecb108d11246b00ce3ba1a207db2b21a2f143f93e75be45299a66c1
% Reached end of topic email [0] at offset 2
```

### sending messages
```
$ echo -e "email\thash://sha256/f55bcfe2fecb108d11246b00ce3ba1a207db2b21a2f143f93e75be45299a66c1" | kafkacat -b localhost:9092 -t email
% Auto-selecting Producer mode (use -P or -C to override)
```
