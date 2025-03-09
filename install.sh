echo "n" | bash <(curl -Ls https://raw.githubusercontent.com/mhsanaei/3x-ui/master/install.sh)
sudo systemctl stop x-ui
sudo cp /path/to/your/x-ui.db /etc/x-ui/x-ui.db
sudo chown x-ui:x-ui /etc/x-ui/x-ui.db
sudo chmod 600 /etc/x-ui/x-ui.db
sudo systemctl start x-ui
