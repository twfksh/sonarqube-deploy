# SonarQube Installation Script

Automated installation script for SonarQube Community Edition with PostgreSQL on Linux systems.

## Features

- Installs PostgreSQL database
- Downloads and installs SonarQube binaries
- Configures PostgreSQL database and user
- Creates `sonarqube` system user and group
- Sets up systemd service for automatic startup
- Configures proper permissions
- Starts SonarQube service automatically

## Quick Install

Run the following command to install SonarQube with default settings:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-installer/master/setup.sh | sudo bash
```

Or with a specific SonarQube version:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-installer/master/setup.sh | sudo bash -s 26.2.0.119303
```

With custom PostgreSQL password:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-installer/master/setup.sh | sudo POSTGRES_PASSWORD=your_secure_password bash -s 26.2.0.119303
```

## Requirements

- **Operating System**: Linux with systemd
- **Privileges**: Root/sudo access
- **Java**: Installed at `/usr/lib/jvm/default` (Java 17 or later recommended)
- **Dependencies**: `wget`, `unzip`, `postgresql`, `postgresql-contrib`
- **Ports**: 9000 (SonarQube), 5432 (PostgreSQL)

> **Important**: Ensure that `/usr/lib/jvm/default` is a symlink pointing to your Java installation (Java 17 or later).

## Manual Installation

```bash
git clone https://github.com/twfksh/sonarqube-installer.git
cd sonarqube-installer
sudo ./setup.sh [version]
```

**Default version**: `26.2.0.119303`

### Environment Variables

You can customize the PostgreSQL password by setting the `POSTGRES_PASSWORD` environment variable:

```bash
sudo POSTGRES_PASSWORD=my_secure_password ./setup.sh
```

**Default PostgreSQL settings**:
- Database: `sonarqube`
- User: `sonar`
- Password: `root` (if not specified)

## Post-Installation

### Access SonarQube

Once installation is complete, access the SonarQube web interface at:

```
http://localhost:9000
```

Or if accessing remotely:

```
http://<your-server-ip>:9000
```

### Default Credentials

- **Username**: `admin`
- **Password**: `admin`

> ⚠️ **Security Warning**: Change the default admin password immediately after first login!

### Database Information

- **PostgreSQL Database**: `sonarqube`
- **PostgreSQL User**: `sonar`
- **Connection**: `jdbc:postgresql://127.0.0.1:5432/sonarqube`

## Service Management

Manage the SonarQube service using systemd:

```bash
# Check service status
sudo systemctl status sonarqube

# Start the service
sudo systemctl start sonarqube

# Stop the service
sudo systemctl stop sonarqube

# Restart the service
sudo systemctl restart sonarqube

# View service logs
sudo journalctl -u sonarqube -f

# Disable auto-start on boot
sudo systemctl disable sonarqube

# Enable auto-start on boot
sudo systemctl enable sonarqube
```

## File Locations

- **Installation Directory**: `/opt/sonarqube`
- **Configuration**: `/opt/sonarqube/conf/sonar.properties`
- **Logs**: `/opt/sonarqube/logs/`
- **Temp Files**: `/opt/sonarqube/temp/`
- **Binary**: `/opt/sonarqube/bin/sonar.sh`
- **Systemd Service**: `/etc/systemd/system/sonarqube.service`

## Troubleshooting

### Service won't start

Check the logs:
```bash
sudo journalctl -u sonarqube -n 100
sudo tail -f /opt/sonarqube/logs/sonar.log
```

### Java not found

Ensure Java is installed and symlinked correctly:
```bash
ls -la /usr/lib/jvm/default
java -version
```

### PostgreSQL connection issues

Verify PostgreSQL is running:
```bash
sudo systemctl status postgresql
sudo -u postgres psql -c "\l" | grep sonarqube
```

### Port already in use

Check if port 9000 is available:
```bash
sudo netstat -tlnp | grep 9000
```

## Uninstallation

To remove SonarQube:

```bash
# Stop and disable the service
sudo systemctl stop sonarqube
sudo systemctl disable sonarqube

# Remove service file
sudo rm /etc/systemd/system/sonarqube.service
sudo systemctl daemon-reload

# Remove installation directory
sudo rm -rf /opt/sonarqube

# Remove user and group
sudo userdel sonarqube
sudo groupdel sonarqube

# Optionally remove PostgreSQL database
sudo -u postgres psql -c "DROP DATABASE sonarqube;"
sudo -u postgres psql -c "DROP USER sonar;"
```
