#!/bin/bash

#
# This script will output the issuer for a given domain in this format:
#	domain,issuer
# If the port is ommited then 443 will be used
# Use check_cas.sh to check multiple domains in batch format
# 
# Please note that errors are always written to the output. These can be of the type:
# - cannot resolve
# - cannot connect
# Apart from that, connection information is also written to the output
# To suppress all information except (successful) results, please pipe the output through grep, like so:
# 	do_check_ca.sh www.domain.com 443 | grep ","
#

if [ -z $1 ]
then
        echo "usage: do_check.sh [domain] [port]"
        exit 1
else
        domain=$1
fi
if [ -z $2 ]
then
        port="443"
else
        port=$2
fi

echo "Going to check $domain on port $port"

# check if it resolved
if ! host $domain > /dev/null
then
        echo "ERROR-RESOLVE: $domain"
        exit 1
else
        # check if we can connect
	#if ! nc -z -w5 $domain $port > /dev/null
        #wget -q --spider $domain:$port
        onoff=`ping -q -w1 -c1 $domain &>/dev/null && echo online || echo offline`
        if [ $onoff == "online" ]; then
                echo "CONNECTED TO $domain:$port"
        else
                echo "ERROR-CONNECT: $domain:$port"
                exit 1
        fi
fi

issuer=`echo | timeout 5s openssl s_client -servername "$domain" -connect $domain:$port 2>/dev/null | openssl x509 -noout -issuer | cut -c9-`
echo "$domain,$issuer"
exit 0
