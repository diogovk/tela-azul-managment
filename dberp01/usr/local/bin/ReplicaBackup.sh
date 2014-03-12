#!/bin/bash

# $Id: ReplicaAmbienteERP.sh,v 1.13 2014/02/03 20:30:35 root Exp $

lockDir=/var/tmp/ReplicaBackup.lock

mkdir -p $lockDir 2>/dev/null || exit 3

export MTADM_TRAP0="rm -f $lockDir/lock.Ctrl;rmdir $lockDir;"
trap "$MTADM_TRAP0" 0

echo "Gerado pelo script $0

Para liberar o lock, remova o arquivo $lockDir/lock.Ctrl e o diretorio $lockDir.

# cd /tmp
# rm $lockDir/lock.Ctrl
# rmdir $lockDir

PID=$$
" > $lockDir/lock.Ctrl

ServidorRemoto=ti-dberp02

flag=
tty -s && flag=v
tty -s && set -x

ssh $ServidorRemoto echo OK | grep -q OK
if [ $? != 0 ] 
then
  echo "Servidor $ServidorRemoto nao responde"
  exit 1
fi

dir=/backup/aibanco
cd $dir && rsync -a$flag --delete . $ServidorRemoto:$dir

