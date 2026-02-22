# SonarQube Deployment Script

Automated installation script for SonarQube on Linux systems.

## Quick Install

Run the following command to install SonarQube:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-deploy/master/setup.sh | sudo bash
```

Or with a specific version:

```bash
curl -fsSL https://raw.githubusercontent.com/twfksh/sonarqube-deploy/master/setup.sh | sudo bash -s 9.9.8.100196
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
- Java installed at `/usr/local/java`
- wget and unzip

## Manual Installation

```bash
git clone https://github.com/USERNAME/REPO.git
cd REPO
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
