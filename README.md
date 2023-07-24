# Dockerized osTicket!

```bash
# Set up the PHP and MySQL containers.
docker compose up

# After finishing the setup wizard at http://localhost/setup/install.php,
# set the `ost-config.php` back to read-only for extra security.
docker compose web exec chmod 0644 /var/www/html/include/ost-config.php

# Also, don't forget to remove the setup folder when we're done!
docker compose web exec rm -rf /var/www/html/setup

# Tear down the web and database containers.
docker compose down
```
