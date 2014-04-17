#!/bin/ksh

find /malwee1/spool -mtime +7 -type f -exec rm -vf {} \;
find /malwee1/sistema/spool -mtime +7 -type f -exec rm -vf {} \;
find /malwee1/srt -mtime +7 -type f -exec rm -vf {} \;
find /bancos/srt -mtime +7 -type f -exec rm -vf {} \;
find /malwee1/programa/spool -mtime +7 -type f -exec rm -vf {} \;

[ $(date +%w) = 0 ] || exit 1

find /var/log/cups -mtime +15 -type f -exec rm -vf {} \;
find /usr/local/nfe/backup/ -mtime +7 -type f -exec rm -vf {} \;

exit 0

