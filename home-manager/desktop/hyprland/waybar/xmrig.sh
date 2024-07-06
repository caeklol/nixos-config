DISABLED="Not mining"
UPTIME=$(systemctl status xmrig | grep -Po ".*; \K(.*)(?= ago)")

if systemctl is-active --quiet xmrig
then
	echo -n "{\"text\":\"${UPTIME}\", \"alt\":\"enabled\"}"
else
	echo -n "{\"text\":\"${DISABLED}\", \"alt\":\"disabled\"}"
fi
