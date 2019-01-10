#!/bin/bash
rm checked_ip_list.txt
while IFS='' read -r line || [[ -n "$line" ]]; do
    echo "$line `curl -s https://www.abuseipdb.com/check/$line |grep \"This IP was reported \"`"  | awk '{print $1","$6","$12}'| sed 's/[<b>|</b>|:]//g' >> checked_ip_list.txt
done < "ip_list.txt"
echo "All Done!"
