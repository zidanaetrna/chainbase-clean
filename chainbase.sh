#!/bin/bash

# Display ASCII Art and Telegram Channel First
echo -e '\e[94m'
echo -e '██████  ██    ██ ████████ ████████  ██████  ███    ██'
echo -e '██   ██ ██    ██    ██       ██    ██    ██ ████   ██'
echo -e '██████  ██    ██    ██       ██    ██    ██ ██ ██  ██'
echo -e '██   ██ ██    ██    ██       ██    ██    ██ ██  ██ ██'
echo -e '██████   ██████     ██       ██     ██████  ██   ████'
echo -e '                                                    '
echo -e '\e[0m'
echo -e "Join our Telegram channel: https://t.me/AirdropsButton"
echo -e "script by zidan"
echo -e "thanks to adolf tjep"
sleep 2

# Update & Upgrade
sudo apt update && sudo apt upgrade -y

# Install Dependencies
sudo apt install -y ca-certificates zlib1g-dev libncurses5-dev libgdbm-dev \
    libnss3-dev curl git wget make jq build-essential pkg-config lsb-release \
    libssl-dev libreadline-dev libffi-dev gcc screen unzip lz4

# Install Docker
curl -fsSL https://download.docker.com/linux/ubuntu/gpg | sudo gpg --dearmor -o /usr/share/keyrings/docker-archive-keyring.gpg

echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/docker-archive-keyring.gpg] https://download.docker.com/linux/ubuntu $(lsb_release -cs) stable" | sudo tee /etc/apt/sources.list.d/docker.list > /dev/null

sudo apt update
sudo apt install -y docker-ce docker-ce-cli containerd.io
docker version

# Install Docker-Compose
VER=$(curl -s https://api.github.com/repos/docker/compose/releases/latest | grep tag_name | cut -d '"' -f 4)
sudo curl -L "https://github.com/docker/compose/releases/download/$VER/docker-compose-$(uname -s)-$(uname -m)" -o /usr/local/bin/docker-compose
sudo chmod +x /usr/local/bin/docker-compose
docker-compose --version

# Add User to Docker Group
sudo groupadd docker
sudo usermod -aG docker $USER

# Install Go
sudo rm -rf /usr/local/go
curl -L https://go.dev/dl/go1.22.4.linux-amd64.tar.gz | sudo tar -xzf - -C /usr/local
echo 'export PATH=$PATH:/usr/local/go/bin:$HOME/go/bin' >> $HOME/.bash_profile
echo 'export PATH=$PATH:$(go env GOPATH)/bin' >> $HOME/.bash_profile
source $HOME/.bash_profile
go version

# Install EigenLayer CLI
curl -sSfL https://raw.githubusercontent.com/layr-labs/eigenlayer-cli/master/scripts/install.sh | sh -s

# Set PATH for EigenLayer CLI
export PATH=$PATH:~/bin

# Clone Chainbase Repository
git clone https://github.com/chainbase-labs/chainbase-avs-setup
cd chainbase-avs-setup/holesky

# Create Operator Keys & Configuration
eigenlayer operator keys create --key-type ecdsa opr
eigenlayer operator config create

echo "Installation and setup complete!"
