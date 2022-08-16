#!/bin/bash
if [ ! -d ${DATA_DIR}/configs ]; then
  mkdir -p ${DATA_DIR}/configs
fi
if [ ! -f ${DATA_DIR}/configs/znc.conf ]; then
  echo "+-----------------------------------------------------"
  echo "| No configuration found, copying default config file!"
  echo "|"
  echo "| The default credentials are:"
  echo "| Username: admin"
  echo "| Password: admin"
  echo "+-----------------------------------------------------"
  echo
  cp /opt/znc.conf ${DATA_DIR}/configs/znc.conf
fi

if [ ! -f ${DATA_DIR}/znc.pem ]; then
  /usr/bin/znc --datadir=${DATA_DIR} --makepem
fi

echo "---Prepare Server---"
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
cd ${DATA_DIR}
/usr/bin/znc --datadir=${DATA_DIR} --foreground