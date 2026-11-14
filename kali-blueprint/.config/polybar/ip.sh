
#!/bin/sh

ROUTE=$(/usr/sbin/ip -4 route get 1.1.1.1 2>/dev/null | head -n 1)

if [ -z "$ROUTE" ]; then
    echo "󰈀 Offline"
    exit 0
fi

INTERFACE=$(echo "$ROUTE" | awk '{for(i=1;i<=NF;i++) if($i=="dev") print $(i+1)}')
LOCAL_IP=$(echo "$ROUTE" | awk '{for(i=1;i<=NF;i++) if($i=="src") print $(i+1)}')

case "$INTERFACE" in
    tun*|tap*|wg*|ppp*|tailscale*|proton*|nordlynx*)
        VPN_IP=$(curl -4 -fsS --max-time 5 https://api.ipify.org 2>/dev/null)
        if [ -n "$VPN_IP" ]; then
            echo "󰖂 $VPN_IP"
        else
            echo "󰖂 $LOCAL_IP"
        fi
        ;;
    *)
        if [ -d "/sys/class/net/$INTERFACE/wireless" ]; then
            echo "󰖩 $LOCAL_IP"
        else
            echo "󰈀 $LOCAL_IP"
        fi
        ;;
esac
