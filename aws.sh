sudo wget https://github.com/exirhub/exirvpn-balancer-config/raw/refs/heads/main/x-ui.db
echo "n" | bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
sudo systemctl stop x-ui
sudo chmod +x ./x-ui.db
sudo cp ./x-ui.db /etc/x-ui/x-ui.db
sudo systemctl start x-ui
sudo ufw disable
