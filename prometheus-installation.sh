#!bin/bash/

#This Script installs prometheus on linux machine

#Providig access
sudo apt-get update
sudo su

#Downloading prometheus
sudo wget https://github.com/prometheus/prometheus/releases/download/v2.2.1/prometheus-2.2.1.linux-amd64.tar.gz
sudo tar xvf prometheus-2.2.1.linux-amd64.tar.gz

# Go to the newly created directory from file extractions.
cd prometheus-2.2.1.linux-amd64

# Create the System Group to allow access to Prometheus
sudo groupadd --system prometheus
sudo grep prometheus /etc/group

# Create Prometheus system user for access
sudo useradd -s /sbin/nologin -r -g prometheus prometheus
sudo id prometheus

#Create configuration and data directories for Prometheus

sudo mkdir -p /etc/prometheus/{rules,rules.d,files_sd}  /var/lib/prometheus

#Copying the Prometheus binary files to main prometheus directory in your defined path
sudo cp prometheus /usr/local/bin/
sudo cp promtool /usr/local/bin/

sudo ls /usr/local/bin/

#Copy consoles and console_libraries to configuration files directory
sudo cp -r consoles/ console_libraries/ /etc/prometheus/

#Create systemd unit file
cd /etc/systemd/system/
pwd
sudo wget "https://github.com/ayshaysha/clouformation-EC2-monitoring-machine-generator/blob/main/prometheus.service"

cd /etc/prometheus/
pwd
sudo wget "https://github.com/ayshaysha/clouformation-EC2-monitoring-machine-generator/blob/main/prometheus-config.yml"

# Change directory permissions to Prometheus user and group
sudo chown -R prometheus:prometheus /etc/prometheus/  /var/lib/prometheus/
sudo chmod -R 775 /etc/prometheus/ /var/lib/prometheus/

# Start and enable Prometheus service
sudo systemctl enable prometheus
sudo systemctl start prometheus
sudo systemctl enable prometheus
sudo systemctl start prometheus

sudo systemctl status prometheus
