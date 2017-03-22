
##########################################################
##   bak the newest gitlab rep to ftp server.
##########################################################

#!/bin/bash

cd /data/gitlab/data/backups/

newest_bak=`ls -al| tail -n 1 | awk '{print $9}'`
newest_bak_date=`ls -al| tail -n 1 | awk '{print $6$7,$9}'`

cp -ap $newest_bak /bak1/gitlab_rep/
rsync -ave ssh $newest_bak ftp.xxxxx.com:/backup/gitlab/

if [  $? -eq 0 ]
   then echo " Backup $newest_bak_date from gitlab Rep to Ftp is SUCCESSFUL" |mail -s "Backup from gitlab to Ftp Successful" abc@gmail.com

else

    echo " Backup from gitlab Rep to Ftp is Failed." | mail -s "Backup from gitlalb to ftp Failed."  abc@gmail.com
fi
