#! bin/bash

log_file="Linux.log"

script_name="linux.sh"

echo "[$(date)] Running Updates for $USER" >>$log_file

echo apt update -y

echo "Updating the following packages.." >>$log_file
apt list --upgradable >>$log_file

echo apt upgrade -y
echo "Updates Installed Successfully.." >>$log_file

# make this script executeable by himself
this_script_path=$(ls $script_name | xargs readlink -f)
echo $this_script_path
chmod u+x $this_script_path
chown root $this_script_path

#  new cron into cron file if its not already there
if (crontab -l | grep $this_script_path); then
    echo "crontab his already this job" >>$log_file
else
    crontab -l | {
        cat
        echo "* * * * * bash $this_script_path"
    } | crontab -
    echo "[$(date)] added this script to cron job" >>$log_file
fi
