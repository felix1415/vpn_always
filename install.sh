# vpn server you want to connect to
vpn_server=vp1234
vpn_service_user=us3rname
vpn_service_password=passw0rd

# set vpn config var and credentials file var
vpn_config="/etc/openvpn/ovpn_udp/${vpn_server}.nordvpn.com.udp.ovpn"
vpn_always_creds="$(pwd)/vpn_always_creds"
vpn_always_service="$(pwd)/vpn_always.service"

# put credentials into credentials file
echo "$vpn_service_user" > $vpn_always_creds
echo "$vpn_service_password" >> $vpn_always_creds

# change the REPLACE_USER in service file to this user
sed -i "s|REPLACE_USER|$USER|g" $vpn_always_service

# change the auth-user-pass in config to point to the credentials file
sed -i "s|test|auth-user-pass $vpn_always_creds|g" $vpn_config

# move vpn_always service to service dir
sudo cp vpn_always.service /lib/systemd/system/

#enable and start the service
sudo systemctl enable vpn_always.service
sudo systemctl start vpn_always.service
