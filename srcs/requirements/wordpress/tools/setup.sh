#!/bin/bash

# Wait for the MariaDB container to be ready to accept connections.
until mariadb -h"$WORDPRESS_DB_HOST" -u"$WORDPRESS_DB_USER" -p"$WORDPRESS_DB_PASSWORD" -e "SELECT 1;" > /dev/null 2>&1; do
    echo "Waiting for MariaDB to be ready..."
    sleep 2
done

# Wait for Redis to be ready
until redis-cli -h redis ping > /dev/null 2>&1; do
    echo "Waiting for Redis to be ready..."
    sleep 2
done

if [ ! -f "wp-config.php" ]; then

    echo "--- First time setup: Installing WordPress and configuring Redis plugin ---"

    wp core download --allow-root

    wp config create --dbname="$WORDPRESS_DB_NAME" \
                     --dbuser="$WORDPRESS_DB_USER" \
                     --dbpass="$WORDPRESS_DB_PASSWORD" \
                     --dbhost="$WORDPRESS_DB_HOST" \
                     --allow-root

    wp core install --url="$WP_URL" \
                    --title="Inception42" \
                    --admin_user="$WP_ADMIN_USER" \
                    --admin_password="$WP_ADMIN_PASSWORD" \
                    --admin_email="$WP_ADMIN_EMAIL" \
                    --allow-root

    wp user create "$WP_USER" "$WP_USER_EMAIL" \
                   --role=subscriber \
                   --user_pass="$WP_USER_PASSWORD" \
                   --allow-root

    wp plugin install redis-cache --activate --allow-root

    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root

    chown -R www-data:www-data /var/www/html

fi

echo "Enabling Redis Cache..."

wp redis enable --allow-root 2>/dev/null || true

exec "$@"