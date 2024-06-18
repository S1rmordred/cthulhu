#!/bin/bash

echo '                                                                                            ';
echo '                                                                                            ';
echo ' ░▒▓██████▓▒░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ';
echo '░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ';
echo '░▒▓█▓▒░        ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ';
echo '░▒▓█▓▒░        ░▒▓█▓▒░   ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░ ';
echo '░▒▓█▓▒░        ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ';
echo '░▒▓█▓▒░░▒▓█▓▒░ ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░      ░▒▓█▓▒░░▒▓█▓▒░▒▓█▓▒░░▒▓█▓▒░ ';
echo ' ░▒▓██████▓▒░  ░▒▓█▓▒░   ░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░░▒▓████████▓▒░▒▓█▓▒░░▒▓█▓▒░░▒▓██████▓▒░  ';
echo '                                                                                            ';
echo '                                                                                       v 0.1';
echo '                                                                                            ';




TARGET_URL=$1

if [ -z "$TARGET_URL" ]; then
    echo -e "Error: Target URL is empty. Please enter the target url."
    exit 1
fi

echo "[+] Calling hakrawler";
touch /tmp/cthulhu.txt;
echo $1 |hakrawler >> /tmp/cthulhu.txt

echo "[+] Calling katana";
katana -u $1 -silent -jc -jsl -kf all >> /tmp/cthulhu.txt;

echo "[+] Calling waybackurl";
waybackurls $1 >> /tmp/cthulhu.txt;

echo "[+] Calling gospider";
gospider -s $1 |grep -Eo "$TARGET_URL[^ ]*"  >> /tmp/cthulhu.txt;
#mv /tmp/test.txt .;
#echo "moved test.txt file to `pwd`";
cat /tmp/cthulhu.txt |grep -Eo "$TARGET_URL[^ ]*" |sort -u|grep -v ".js" |grep -v ".css" |httpx -silent -random-agent -o cthulhu.txt > /dev/null 2>&1;
echo "[+] result is stored in `pwd`/chulhu.txt";
echo "";
rm /tmp/cthulhu.txt;
