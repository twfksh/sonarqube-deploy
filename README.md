# SonarQube Deployment Script

Automated installation script for SonarQube on Linux systems.

## Quick Install

Run the following command to install SonarQube:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-installer/master/setup.sh | sudo bash
```

Or with a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-installer/master/setup.sh | sudo bash -s 9.9.8.100196
```

## What it does

- Downloads and installs SonarQube binaries
- Creates `sonarqube` system user and group
- Sets up systemd service
- Configures permissions
- Starts SonarQube service automatically

## Requirements

- Linux system with systemd
- Root/sudo access
- Java installed at `/usr/lib/jvm/default`
- `wget` and `unzip`

**Note**: Make sure that the `/usr/lib/jvm/default` points to the required `jvm` version.

## Manual Installation

```bash
git clone https://github.com/twfksh/sonarqube-installer.git
cd sonarqube-installer
sudo ./setup.sh [version]
```

Default version: `9.9.8.100196`

## Post-Installation

Access SonarQube at: `http://localhost:9000`

Default credentials:
- Username: `admin`
- Password: `admin`

## Service Management

```bash
sudo systemctl status sonarqube
sudo systemctl start sonarqube
sudo systemctl stop sonarqube
sudo systemctl restart sonarqube
```
