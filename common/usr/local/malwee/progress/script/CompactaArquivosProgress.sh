#!/bin/ksh

# Remove os arquivos de ai com mais de 30 dias
# Compacta a cada hora os arquivos de ai

cd /backup/aibanco || exit 1

find /backup/aibanco -type f -name \*prd*.a\*gz -mtime +30 -exec rm -f {} \;

export lista=lista_ai.$$.txt
trap "rm -f $lista" 0

find /backup/aibanco -type f -name \*prd*.a\*[0-9] > $lista

[ -s $lista ] || exit 0

sleep 20
gzip $(<$lista)

/usr/local/bin/ReplicaBackup.sh 
exit 0

