#!/bin/bash

until mariadb -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

cd /var/www/html

# Check if WordPress is already installed by looking for the wp-config.php file.
if [ ! -f "wp-config.php" ]; then
    echo "WordPress not found. Installing now..."

    wp core download --allow-root

    wp config create --dbname="$WORDPRESS_DB_NAME" \
                     --dbuser="$WORDPRESS_DB_USER" \
                     --dbpass="$WORDPRESS_DB_PASSWORD" \
                     --dbhost="$WORDPRESS_DB_HOST" \
                     --allow-root

    wp core install --url="$WP_URL" \
                    --title="Inception" \
                    --admin_user="$WP_ADMIN_USER" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --allow-root
fi

echo "WordPress is ready."

exec "$@"
