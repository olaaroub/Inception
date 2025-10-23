
# Inception

## 📋 Project Overview

Inception is a system administration and Docker orchestration project that creates a complete web infrastructure stack. The project demonstrates advanced containerization concepts, network isolation, persistent data management, and secure service communication.

### Architecture

The infrastructure consists of multiple interconnected Docker containers:

**Core Services:**

- **NGINX**: Reverse proxy and web server (TLSv1.2/1.3 only)
- **WordPress**: Content management system with PHP-FPM
- **MariaDB**: Relational database for WordPress
- **Redis**: In-memory cache for WordPress object caching

**Bonus Services:**

- **FTP Server (vsftpd)**: Secure access to WordPress files (Ports 21, 50000–50100).
- **Adminer**: Database management interface
- **Portainer**: Docker container management GUI
- **Static Website**: Simple HTML/CSS/JS page served by Nginx.

## 🔧 Technical Concepts

### Container Orchestration

Each service runs in an isolated container with its own filesystem, built from custom Dockerfiles (no pre-built images from DockerHub except for Debian base images). Services communicate through a dedicated Docker bridge network (`inception`).

### Volume Management

The project uses **bind mounts** rather than named Docker volumes for persistent data:

- Database files (`/var/lib/mysql`) → `~/data/mariadb`
- WordPress files (`/var/www/html`) → `~/data/wordpress`
- Portainer data → `~/data/portainer`

This approach provides:

- Direct filesystem access for debugging and backups
- Predictable data location on the host
- Easier permission management
- Better portability across different systems

**Why bind mounts?** Unlike Docker volumes which are managed by Docker in `/var/lib/docker/volumes/`, bind mounts give you explicit control over where data lives on your host filesystem, making backups, migrations, and debugging significantly easier.

### Process Management

Containers follow the **one process per container** principle. Each uses PID 1 to run a single service daemon (nginx, php-fpm, mariadb, etc.), ensuring proper signal handling and clean shutdowns.

**Why PID 1 matters:** In Unix systems, PID 1 has special responsibilities - it must handle signals (SIGTERM, SIGINT) properly and reap zombie processes. Running your service as PID 1 ensures Docker can gracefully stop containers and prevents orphaned processes.

### Security Features

- **TLS/SSL encryption**: NGINX configured with self-signed certificates
- **Network isolation**: Services communicate only through the internal Docker network
- **Secret management**: Sensitive data stored in dedicated secret files
- **Least privilege**: Services run as non-root users where possible

### Service Dependencies

WordPress container waits for MariaDB and Redis to be healthy before initializing. The startup script uses TCP health checks to ensure database availability before running WP-CLI commands.

**Dependency resolution:** Docker Compose's `depends_on` only waits for containers to start, not for services to be ready. The WordPress startup script implements custom health checks (testing TCP connections to MariaDB:3306 and Redis:6379) to ensure services are actually accepting connections before initialization.

## 🌐 Access Points

After successful deployment:

- **WordPress**: `https://olaaroub.42.fr`
- **Adminer**: `https://olaaroub.42.fr/adminer/`
- **Portainer**: `https://olaaroub.42.fr/portainer/`
- **Architecture Diagram**: `https://olaaroub.42.fr/architecture/`
- **FTP**: `ftp://olaaroub.42.fr:21`

**Note:** Your browser will warn about the self-signed certificate. This is expected in development environments.

---

## 🚀 Setup Instructions

### Prerequisites

- Linux VM (Debian/Ubuntu)
- Docker & Docker Compose v2
- `make` utility installed

### 1. Clone the Repository

```bash
git clone https://github.com/your-username/inception.git
cd inception
```

### 2. Configure Environment

Create your environment file:

```bash
cp srcs/.env.example srcs/.env
```

Then edit `srcs/.env` and set your passwords and 42 login username.

### 3. Create Secrets

Create the secrets directory and add your Portainer admin password:

```bash
mkdir -p secrets
echo "YourSecurePortainerPassword" > secrets/portainer_admin_password.txt
```

### 4. Update Host DNS

Add your domain to `/etc/hosts`:

```bash
sudo nano /etc/hosts
```

Then add:

```text
127.0.0.1 olaaroub.42.fr
```

### 5. Create Data Directories

Create directories for persistent data storage:

```bash
mkdir -p ~/data/mariadb ~/data/wordpress ~/data/portainer
```

### 6. Fix MariaDB Permissions

**Why this step?** MariaDB runs as the `mysql` user inside the container with a specific UID/GID. The host directory must have matching ownership for the database to write data properly.

First, build the images and start the containers:

```bash
make up
```

Get the MariaDB user IDs from the running container:

```bash
docker exec mariadb id mysql
```

This outputs something like: `uid=999(mysql) gid=999(mysql) groups=999(mysql)`

Now set the correct ownership on the host directory:

```bash
sudo chown -R 999:999 ~/data/mariadb
```

Replace `999:999` with the actual UID:GID from the previous command.

Restart the services to apply changes:

```bash
make down
make up
```

---

## 📝 Makefile Commands

| Command      | Description                                      |
| ------------ | ------------------------------------------------ |
| `make up`    | Build images and start all containers            |
| `make down`  | Stop and remove all containers                   |
| `make logs`  | Show real-time logs from all services            |
| `make clean` | Stop containers and remove all project resources |
| `make re`    | Full rebuild: clean + build + start              |

---

## 📄 License

This project is part of the 42 School curriculum.

For license information, see the [LICENSE](LICENSE) file.
