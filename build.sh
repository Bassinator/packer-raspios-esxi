#!/bin/bash
set -e
set -x


curl http://downloads.raspberrypi.org/raspios_lite_arm64/images/raspios_lite_arm64-2020-08-24/2020-08-20-raspios-buster-arm64-lite.zip -o 2020-08-20-raspios-buster-arm64-lite.zip
unzip -o 2020-08-20-raspios-buster-arm64-lite.zip

qemu-img convert -f raw 2020-08-20-raspios-buster-arm64-lite.img -O vmdk 2020-08-20-raspios-buster-arm64-lite.vmdk

sshpass -e scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null 2020-08-20-raspios-buster-arm64-lite.vmdk  ${SSHUSER}@192.168.1.230:/vmfs/volumes/${DATASTORE}/

sshpass -e ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -t ${SSHUSER}@192.168.1.230 "rm -f /vmfs/volumes/${DATASTORE}/raspios-buster-arm64-flat.vmdk; rm -f /vmfs/volumes/${DATASTORE}/raspios-buster-arm64.vmdk; vmkfstools -i /vmfs/volumes/${DATASTORE}/2020-08-20-raspios-buster-arm64-lite.vmdk -d thin /vmfs/volumes/${DATASTORE}/raspios-buster-arm64.vmdk; vmkfstools -X 20G /vmfs/volumes/${DATASTORE}/raspios-buster-arm64.vmdk"


export datastore_hash=$(sshpass -e ssh -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null  -t ${SSHUSER}@192.168.1.230 "readlink /vmfs/volumes/${DATASTORE}" | tr -d '[:space:]')

packer build -var "datastore=${datastore_hash}" template.json
