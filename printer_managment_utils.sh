#!/bin/bash

# Helpers for managing a cluster of CUPS server
REMOTE_SERVER=ti-erp02 

printer_by_IP(){
  echo =================================================================
  hostname
  grep -B 10 "$1" /etc/cups/printers.conf | grep '<Printer'
  echo =================================================================
  echo $REMOTE_SERVER
  ssh $REMOTE_SERVER grep -B 10 "$1" /etc/cups/printers.conf | grep '<Printer'
}

chprinter_socket(){
  [ "$1" ] && [ "$2" ] || { echo "Error: missing argument" ; return 2 ; }
  exists_printer "$1" || { echo "Error: printer not found" ; return 3 ; }
  echo lpadmin -p $1 -v socket://$2:9100
  lpadmin -p $1 -v socket://$2:9100
  echo ssh $REMOTE_SERVER lpadmin -p $1 -v socket://$2:9100
  ssh $REMOTE_SERVER lpadmin -p $1 -v socket://$2:9100
}

exists_printer(){
  grep -q "<Printer $1>" /etc/cups/printers.conf
}

