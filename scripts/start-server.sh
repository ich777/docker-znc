#!/bin/bash

echo "---Container under construction"
sleep infinity

echo "---Prepare Server---"
chmod -R ${DATA_PERM} ${DATA_DIR}
echo "---Server ready---"

echo "---Start Server---"
cd ${DATA_DIR}
/usr/bin/znc