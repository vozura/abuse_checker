#!/bin/bash
rm checked_ip_list.txt
while IFS='' read -r line || [[ -n "$line" ]]; do
#    echo "$line `curl -s https://www.abuseipdb.com/check/$line |grep \"This IP was reported \"`"  | awk '{print $1","$6","$12}'| sed 's/[<b>|</b>|:]//g' >> checked_ip_list.txt
    curl -s https://www.abuseipdb.com/check/$line > check_ip_tmp.html
    IP_INFO=$(echo "$line `cat check_ip_tmp.html |grep \"This IP was reported \"`"  | awk '{print $1","$6","$12}'| sed 's/[<b>|</b>|:]//g')
    ISP=$(cat check_ip_tmp.html |grep -A 2 "<th>ISP</th>" |grep -v "<th>" |grep -v "<td>")
    COUNTRY=$(cat check_ip_tmp.html |grep -A 3 "<th>Country</th>" |grep -v "<th>" |grep -v "<td>"|grep -v "<img ")
    echo $IP_INFO,$ISP,$COUNTRY >> checked_ip_list.txt
done < "ip_list.txt"
rm check_ip_tmp.html
echo "All Done!"
