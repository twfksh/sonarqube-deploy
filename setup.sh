#!/bin/bash
# Usage: sudo ./setup.sh or sudo ./setup.sh 9.9.8.100196

set -e

SONARQUBE_VARSION=${1:-9.9.8.100196}
SONARQUBE_SRC_DIR="/opt/sonarqube"
SONARQUBE_BINARY_DIR="sonarqube-bin"
SONARQUBE_BINARY="$SONARQUBE_SRC_DIR/bin/sonar.sh"
SONARQUBE_BINARY_DOWNLINK="https://binaries.sonarsource.com/Distribution/sonarqube/sonarqube-$SONARQUBE_VARSION.zip"

# Create /opt/sonarqube dir
mkdir -p $SONARQUBE_SRC_DIR

# Download sonarqube binaries
wget -O "$SONARQUBE_SRC_DIR/$SONARQUBE_BINARY_DIR.zip" $SONARQUBE_BINARY_DOWNLINK

# Extract binaries
TEMP_DIR=$(unzip -Z1 "$SONARQUBE_SRC_DIR/$SONARQUBE_BINARY_DIR.zip" | head -1 | cut -d/ -f1) && \
unzip "$SONARQUBE_SRC_DIR/$SONARQUBE_BINARY_DIR.zip" -d $SONARQUBE_SRC_DIR && \
ln -s "$SONARQUBE_SRC_DIR/$TEMP_DIR/bin/linux-x86-64" "$SONARQUBE_SRC_DIR/bin"

# Give exe permission
sudo chmod +x $SONARQUBE_BINARY

# Add permissions
getent group sonarqube || sudo groupadd --system sonarqube
id sonarqube >/dev/null 2>&1 || sudo useradd --system --gid sonarqube --home-dir $SONARQUBE_SRC_DIR --shell /bin/bash sonarqube
sudo chown -R sonarqube:sonarqube $SONARQUBE_SRC_DIR
sudo mkdir -p $SONARQUBE_SRC_DIR/temp $SONARQUBE_SRC_DIR/logs
sudo chown -R sonarqube:sonarqube $SONARQUBE_SRC_DIR/temp $SONARQUBE_SRC_DIR/logs

# Generate sonarqube.service unit file
cat <<EOF > /etc/systemd/system/sonarqube.service
[Unit] 
Description=SonarQube service 
After=network.service

[Service] 
Type=forking
User=sonarqube
Group=sonarqube
PIDFile=/opt/sonarqube/bin/SonarQube.pid

Environment=JAVA_HOME=/usr/local/java
WorkingDirectory=/opt/sonarqube 
ExecStart=/opt/sonarqube/bin/sonar.sh start 
ExecStop=/opt/sonarqube/bin/sonar.sh stop 

[Install] 
WantedBy=default.target 
EOF

# Start the service
systemctl enable sonarqube.service --now
