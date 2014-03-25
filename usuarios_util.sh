#!/bin/bash

SERVERS='ti-erp01 ti-erp02 ti-dberp01 ti-dberp02 ti-apperp01 ti-apperp02 ti-pacapperp01'
cat_passwords(){
  for srv in $SERVERS
  do
    ssh root@$srv cat /etc/passwd
  done
}

add_user(){
  # Ex: add_user cc1 2521 /home/jacoletor 'Costura-JA,JA-Costura,,'
  USERNAME="$1"
  UID_USER="$2"
  HOMEDIR="$3"
  COMMENT="$4"
  [ "$1" ] && [ "$2" ] && [ "$3" ] || {
    echo usage: add_user '<username> <uid> <home> [comment]'
    return 2
  }
  cat_passwords | grep -q :"$UID_USER": && {
    echo "Aparentemente usuario com o UID selecionado ja existe em algum dos servidores"
    return 3
  }
  echo useradd -u \"$UID_USER\" -c \"$COMMENT\" -d \"$HOMEDIR\" \"$USERNAME\"
  echo useradd -u "$UID_USER" -c "$COMMENT" -d "$HOMEDIR" "$USERNAME" && {
    echo "Agora execute 'passwd $USERNAME' ou remova o ! em /etc/shadow"
  }
}

