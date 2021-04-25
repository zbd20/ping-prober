#!/bin/bash
read -p "enter POD_NAME:" POD_NAME
read -p "enter POD_IP:" POD_IP
read -p "enter REGION:" REGION
read -p "enter VPC:" VPC
read -p "enter ACCOUNT:" ACCOUNT
export POD_NAME=${POD_NAME}
export POD_IP=${POD_IP}
export REGION=${REGION}
export VPC=${VPC}
export ACCOUNT=${ACCOUNT}
envsubst '\${POD_NAME} \${POD_IP} \${REGION} \${VPC} \${ACCOUNT}' < ./ping-probe-register.service.tmp > /usr/lib/systemd/system/ping-probe-register.service
mv ./ping-exporter.service.tmp /usr/lib/systemd/system/ping-exporter.service

mkdir -pv /App/ping-prober
mv ./ping-exporter /App/ping-prober/
mv ./ping-probe-register /App/ping-prober/
mv ./ping-probe-register-cfg.yaml /App/ping-prober/
chmod +x /App/ping-prober/ping-exporter
chmod +x /App/ping-prober/ping-probe-register

systemctl enable ping-probe-register
systemctl enable ping-exporter

systemctl start ping-exporter
systemctl start ping-probe-register

systemctl status ping-exporter
systemctl status ping-probe-register
