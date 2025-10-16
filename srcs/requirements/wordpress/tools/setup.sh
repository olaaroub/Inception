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

# Check if WordPress is already configured. If wp-config.php exists, skip installation.
if [ ! -f "wp-config.php" ]; then

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
fi

if ! wp user get "$WP_USER" --allow-root > /dev/null 2>&1; then
    echo "Creating regular user: $WP_USER"
    wp user create "$WP_USER" "$WP_USER_EMAIL" \
                   --role=subscriber \
                   --user_pass="$WP_USER_PASSWORD" \
                   --allow-root
fi

# Configure Redis (runs every time, not just on first install)
if ! wp plugin is-installed redis-cache --allow-root 2>/dev/null; then
    echo "Installing Redis Object Cache plugin..."
    wp plugin install redis-cache --activate --allow-root
fi

if ! wp config has WP_REDIS_HOST --allow-root 2>/dev/null; then
    echo "Configuring Redis settings..."
    wp config set WP_REDIS_HOST redis --allow-root
    wp config set WP_REDIS_PORT 6379 --allow-root
fi

wp redis enable --allow-root 2>/dev/null || true

exec "$@"

