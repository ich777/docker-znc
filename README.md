# DEPRECATED

# ZNC in Docker optimized for Unraid
ZNC is an IRC network bouncer or BNC. It can detach the client from the actual IRC server, and also from selected channels. Multiple clients from different locations can connect to a single ZNC account simultaneously and therefore appear under the same nickname on IRC. It supports Transport Layer Security connections and IPv6. 

**DEFAULT CREDENTIALS:**

Username: admin

Password: admin

## Env params
| Name | Value | Example |
| --- | --- | --- |
| DATA_DIR | Folder for ZNC | /znc |
| UID | User Identifier | 99 |
| GID | Group Identifier | 100 |
| UMASK | Umask value | 0000 |
| DATA_PERM | Data permissions for /znc folder | 770 |

## Run example
```
docker run --name ZNC -d \
	-p 6698:6698 \
	--env 'UID=99' \
	--env 'GID=100' \
	--env 'UMASK=000' \
	--env 'DATA_PERM=770' \
	--volume /path/to/znc:/znc \
	--restart=unless-stopped \
	ich777/znc
```
### Webgui address: http://[IP]:[PORT:6698]

This Docker was mainly edited for better use with Unraid, if you don't use Unraid you should definitely try it!

#### Support Thread: https://forums.unraid.net/topic/83786-support-ich777-application-dockers/
