VPN_SERVER="?????"
retires=0

while true; do
    if [ $retires -eq 2 ]; then
        echo "Failed to start 3 times"
        exit 1
    fi

    if [ $( ps aux | grep "sudo openvpn /etc/openvpn/ovpn_udp/$VPN_SERVER" | wc -l) -eq 1 ];
    then
        sudo openvpn /etc/openvpn/ovpn_udp/$VPN_SERVER.nordvpn.com.udp.ovpn
        retires=$((retires+1))
    else
        echo "VPN is running"
        while true; do
            if [ $( ps aux | grep "sudo openvpn /etc/openvpn/ovpn_udp/$VPN_SERVER" | wc -l) -eq 2 ]; then
                :
            fi
        done
    fi

    sleep 10;
done
