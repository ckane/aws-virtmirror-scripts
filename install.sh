#!/bin/bash
S3_DEST="$1"

if [ "$1" = "" ]; then
    echo Usage: ${0} your-bucket-name
    echo
    return 1
fi

# Add ec2-user to some groups, so we don't have to run as root
usermod -G tcpdump,adm,wheel,systemd-journal ec2-user

# Build stripe
if ! test -f ./stripe/stripe.c; then
    echo "You need to clone this with --recursive"
    return 1
fi

cd stripe
cc -o stripe stripe.c
cd ..

# Install the systemd scripts to manage the services
cp *.service /etc/systemd/system
systemctl enable do-listen-4789.service
systemctl enable do-prep-nvme1.service
systemctl enable do-capture.service
systemctl daemon-reload

# Install crontab
echo "*/10 * * * *    time aws s3 mv --only-show-errors --recursive /buffer/striped/ \"s3://${S3_DEST}/\"" > ./new-crontab
echo "*/15 * * * *    /home/ec2-user/aws-virtmirror-scripts/do_stripe.sh" >> ./new-crontab
crontab ./new-crontab

