# osTicket for Docker!

This repository contains various automation scripts for managing [osTicket] in a [Docker] container.

[Docker]: https://www.docker.com/
[osTicket]: https://osticket.com/

## Environment Variables

See the [different ways][inject-env] to inject environment variables into the Docker build. Note that the [`docker-compose.yml`](./docker-compose.yml) file has been configured to accept a `mysql.env` file in the repository root.

[inject-env]: https://docs.docker.com/compose/environment-variables/set-environment-variables/

**Name** | **Description** | **Required** | **Default**
-------- | --------------- | :----------: | ----------:
`MYSQL_ROOT_PASSWORD` | Default password of the `root` user in the MySQL database. | &#x2714; |
`MYSQL_DATABASE` | Default name for the newly created database for [osTicket]. | &#x274c; | `osticket`
`MYSQL_USER` | Default username for the non-`root` MySQL user. | &#x274c; | `user`
`MYSQL_PASSWORD` | Default password for the non-`root` MySQL user. | &#x2714; |

Note that the Docker container for MySQL supports [more environment variables][docker-env]. Moreover, the MySQL database itself honors [additional environment variables][mysql-env].

[docker-env]: https://github.com/docker-library/docs/blob/a3195ede892a36b58a27f0056e8a24b31c00956f/mysql/README.md#environment-variables
[mysql-env]: https://dev.mysql.com/doc/refman/8.0/en/environment-variables.html

## Docker Compose

```bash
# Set up the PHP and MySQL containers.
docker compose up

# If this is the first setup, make sure to make the configuration file
# writable by the setup wizard at http://localhost/setup/install.php.
docker compose exec web chmod 0666 /var/www/html/include/ost-config.php

# Complete the setup wizard at http://localhost/setup/install.php...

# After finishing the setup wizard at http://localhost/setup/install.php,
# set the `ost-config.php` back to read-only for extra security.
docker compose exec web chmod 0644 /var/www/html/include/ost-config.php

# Also, don't forget to remove the setup folder when we're done!
docker compose exec web rm -rf /var/www/html/setup

# Tear down the web and database containers.
docker compose down
```
