# Palworld Server Management

The scripts in this repository will help you mitigate the memory leaking problem of Palworld on Linux server and do auto backup for you.

## Encapsulate the Server into a Service

Modify the parameters inside `palw.service` to your own and put it under `/etc/systemd/system/`. Then run the following commands

```bash
sudo systemctl daemon-reload
sudo systemctl enable palw.service
```

After that the Palworld server will auto-start after system starts. We can control the server with the following commands

```bash
sudo systemctl start palw.service 		      	# start server
sudo systemctl stop palw.service				# stop server
sudo systemctl restart palw.service				# restart server	
sudo systemctl status palw.service				# check log and status
```

## Mitigate Memory Leaking Problem

### Modify the Service

Set the following entries under `[Service]` in the service file (it's already modified in repo):

```
RuntimeMaxSec=24h
MemoryMax=14G
Restart=always
```

Note that you may change the values according to your own configuration.

### Create a Swap Area

We can create a swap area using the following commands.

```bash
sudo fallocate -l 16G /swapfile
sudo chmod 600 /swapfile
sudo mkswap /swapfile
sudo swapon /swapfile
echo "/swapfile none swap sw 0 0" | sudo tee -a /etc/fstab
```

You can change the size and name of the swap file according to your own favor.

After executing the above commands, use the following command to view the newly created swap partition.

```bash
swapon --show
```

## Auto Backup

`backup.sh` will automatically backup server saving file.

Change the values inside `backup.sh` to your own, and edit `crontab` for steam user by running

```bash
crontab -e
```

Then add the following job

```bash
# m h  dom mon dow   command
0 */2 * * * /home/steam/scripts/backup.sh
```

