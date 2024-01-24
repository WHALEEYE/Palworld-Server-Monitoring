# Palworld Server Monitoring

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



## Mitigate the Memory Leaking Problem

`monitor.sh` will try to restart the service every time the server have taken up more memory than the threshold defined in the script.

Change the values inside `monitor.sh` to your own, and edit `crontab` of root user by running

```bash
sudo crontab -e
```

Then add the following job

```bash
# m h  dom mon dow   command
*/5 * * * * /home/steam/scripts/monitor.sh
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

