#!/bin/bash
set -e

sshpass -e scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${SSHUSER}@192.168.1.230:/vmfs/volumes/${DATASTORE}/raspios-buster-arm64.vmdk build/
sshpass -e scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${SSHUSER}@192.168.1.230:/vmfs/volumes/${DATASTORE}/raspios-buster-arm64-flat.vmdk build/
sshpass -e scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${SSHUSER}@192.168.1.230:/vmfs/volumes/${DATASTORE}/raspios/raspios.vmdk build/

sshpass -e scp -o StrictHostKeyChecking=no -o UserKnownHostsFile=/dev/null ${SSHUSER}@192.168.1.230:/vmfs/volumes/${DATASTORE}/
