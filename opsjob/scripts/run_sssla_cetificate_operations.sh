#!/usr/bin/env bash
echo -e "\n===== [$(readlink -f $0)] =====\n" 1>&2
set -euvx
shopt -s inherit_errexit
set +v

: $1 $2 $3 $4

url=$1
ChipID=$2
token=$3
dir=$4
csvfilname=$5

serial_number="vferuwefl3743y93192"
if [[ "$serial_number" == "null" ]]; then
echo "No Records Found related to $ChipID.Please provide valid ChipID!"
exit 1
else
certificate_pem="eftgfdaf356r4i2tdmgbgu35yl475934fbdsjhvfdfsdgsckafldjsgbbsd"
echo $certificate_pem > ./opsjob/"$dir"/"$ChipID"_SO_Output.pem
sudo chmod 777 ./opsjob/"$csvfilname"
echo "$ChipID,1" >> ./opsjob/"$csvfilname"
fi