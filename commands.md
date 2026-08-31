# Ubuntu Basic Command Record

## Prerequisites

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
ssh <LABHOST_USER>@<LABHOST_PUBLIC_IP>
```

```bash
ssh ubuntu@192.168.100.4
```

```bash
lsb_release -d
```

```bash
lsblk
```

```bash
nproc
```

```bash
free -h
```

```bash
ping -c 3 ubuntu.com
```

## Chapter 1: What is Ubuntu

The following source commands were validated on the replacement LABVM on 2026-08-25.

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
ssh ubuntu@192.168.100.4
```

```bash
cat /etc/os-release
```

```bash
cat /etc/lsb-release
```

```bash
uname -a
```

```bash
cat /proc/version_signature
```

## Chapter 2: CLI Environment

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
man ls
```

```bash
mkdir mydir1
```

```bash
cd mydir1
```

```bash
mkdir mydir2
```

```bash
cd mydir2
```

```bash
cd ..
```

```bash
rmdir mydir2
```

```bash
touch file1
```

```bash
cp file1 file2
```

```bash
mkdir mynewdir
```

```bash
cp -a mydir1/* mynewdir
```

```bash
ls -al > ~/all_files.txt
```

```bash
ls -al /tmp >> ~/all_files.txt
```

```bash
wc -l < /etc/passwd
```

```bash
ls -al | less
```

```bash
ls > mylist
```

```bash
man man
```

```bash
man rsync
```

```bash
NAME=Marvin
```

```bash
NAMES="Marvin Ford Arthur Trillian"
```

```bash
unset NAME
```

```bash
NAME=
```

```bash
export NAME=Marvin
```

```bash
echo $NAME
```

```bash
NAMES="$NAMES Zaphod"
```

```bash
readonly NAMES
```

```bash
echo $PATH
```

```bash
env
```

```bash
MYNAME="john"
```

```bash
echo $MYNAME
```

```bash
PART1="My name is"
```

```bash
PART2="john"
```

```bash
echo $PART1
```

```bash
echo $PART2
```

```bash
STUDENTNAME=$PART1$PART2
```

```bash
echo $STUDENTNAME
```

```bash
unset PART1
```

```bash
unset PART2
```

```bash
unset STUDENTNAME
```

```bash
echo $PART1
```

```bash
echo $PART2
```

```bash
echo $STUDENTNAME
```

```bash
x=5
```

```bash
echo $x
```

```bash
bash
```

```bash
exit
```

```bash
export x=5
```

```bash
echo $x
```

```bash
ls /usr/bin | head -5 | tail -1
```

```bash
grep list mylist
```

```bash
ls -lt /usr/bin | head
```

```bash
du | sort -nr | head
```

```bash
cat >redirection.txt <<EOF
Hello world!
EOF
```

```bash
less --help | grep -i examine
```

```bash
ls; pwd; whoami
```

```bash
echo sp{el,il,al}
```

```bash
ping -c1 google.com && echo "That's good, able to ping google.com" || \
echo "That's bad unable to ping google.com"
```

```bash
mkdir {2014..2016}-0{0..9} {2014..2016}-{10..12}
```

```bash
cd ~
```

```bash
echo $SHELL
```

```bash
cd ~ubuntu
```

```bash
echo hello >~/hello.txt
```

```bash
D=`date`
```

```bash
echo $D
```

```bash
echo ${D}d vs echo $Dd
```

```bash
echo ${TODAY:=`date +%A`}
```

```bash
echo "The date and time is: $(date)"
```

```bash
echo "The date and time is `date`"
```

```bash
echo $(env | grep ^LC_)
```

```bash
printf "%s\n" $(env | grep ^LC_)
```

```bash
ls -ltr /etc | tail
```

```bash
history | grep ls
```

```bash
file=data.txt
```

```bash
echo ${file%.*}
```

```bash
echo ${file#*.}
```

```bash
X=5
```

```bash
echo $((X+1))
```

```bash
echo $(($X+1))
```

```bash
echo $((X>15))
```

```bash
cd /usr/bin
```

## Chapter 3: Linux Filesystem Hierarchy

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
pwd
```

```bash
cd /
```

```bash
ls
```

```bash
cd /usr
```

```bash
ls lib
```

```bash
ls games
```

```bash
ls local
```

```bash
cd /var
```

```bash
ls cache
```

```bash
cd cache
```

```bash
cd ../../
```

```bash
cd ~
```

```bash
sudo apt install tree -y
```

```bash
sudo apt clean
```

```bash
cd ~
```

```bash
tree
```

```bash
tree -L 1 /
```

```bash
tree -L 2 /
```

```bash
ls -l /etc/hosts
```

```bash
ls -ld /etc
```

```bash
ls -l /dev/tty
```

```bash
ls -l /dev/vda
```

```bash
ls -l /dev/
```

```bash
touch file1.txt
```

```bash
ls -l file1.txt
```

```bash
mkdir dirone
```

```bash
ls -l | grep dirone
```

```bash
rmdir dirone/
```

```bash
rm file1.txt
```

## Chapter 4: Identity and Ownership

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
sudo addgroup students
```

```bash
grep students /etc/group
```

```bash
sudo adduser --ingroup students --disabled-password labuser
```

```bash
grep labuser /etc/passwd
```

```bash
sudo grep labuser /etc/shadow
```

```bash
sudo passwd labuser
```

```bash
sudo grep labuser /etc/shadow
```

```bash
sudo adduser labuser sudo
```

```bash
grep labuser /etc/group
```

```bash
sudo su - labuser
```

```bash
echo $HOME
```

```bash
exit
```

```bash
sudo userdel -r labuser
```

```bash
sudo -i
```

```bash
exit
```

```bash
touch file01.txt
```

```bash
mkdir test01
```

```bash
ls -l
```

```bash
umask 077
```

```bash
touch file02.txt
```

```bash
mkdir test02
```

```bash
ls -l
```

```bash
chmod 664 file02.txt
```

```bash
chmod 775 test02
```

```bash
ls -l
```

## Chapter 4: Identity and Ownership Complete Retry

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
sudo addgroup students
```

```bash
grep students /etc/group
```

```bash
sudo adduser --ingroup students --disabled-password labuser
```

```bash
grep labuser /etc/passwd
```

```bash
sudo grep labuser /etc/shadow
```

```bash
sudo passwd labuser
```

```bash
sudo grep labuser /etc/shadow
```

```bash
sudo adduser labuser sudo
```

```bash
grep labuser /etc/group
```

```bash
sudo su - labuser
```

```bash
echo $HOME
```

```bash
exit
```

```bash
sudo userdel -r labuser
```

```bash
sudo -i
```

```bash
exit
```

```bash
touch file01.txt
```

```bash
mkdir test01
```

```bash
ls -l
```

```bash
umask 077
```

```bash
touch file02.txt
```

```bash
mkdir test02
```

```bash
ls -l
```

```bash
chmod 664 file02.txt
```

```bash
chmod 775 test02
```

```bash
ls -l
```

## Chapter 5: Logging and Initialization

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
grep -i "error" /var/log/syslog
```

```bash
ls /etc/logrotate.d/
```

```bash
sudo logrotate /etc/logrotate.conf
```

```bash
sudo logrotate -vf /etc/logrotate.conf
```

```bash
dmesg | less
```

```bash
head -n 10 /var/log/syslog
```

```bash
tail -n 10 /var/log/syslog
```

```bash
ls -l /var/log
```

```bash
ls -l /boot/
```

```bash
man systemctl
```

```bash
sudo systemctl stop cron
```

```bash
sudo systemctl start cron
```

```bash
sudo systemctl status cron
```

```bash
systemctl list-units -t service
```

```bash
systemctl list-units -t service | grep -i ssh
```

```bash
systemctl --failed
```

```bash
man journalctl
```

```bash
journalctl -u ssh.service
```

```bash
systemctl show ssh.service
```

```bash
sudo systemctl restart ssh
```

## Chapter 5: Logging and Initialization Replacement Validation

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
grep NetworkManager /var/log/syslog
```

```bash
grep -i "error" /var/log/syslog
```

```bash
ls /etc/logrotate.d/
```

```bash
sudo logrotate /etc/logrotate.conf
```

```bash
sudo cat /var/lib/logrotate/status
```

```bash
sudo logrotate -vf /etc/logrotate.conf
```

```bash
sudo dmesg
```

```bash
sudo dmesg | less
```

```bash
sudo dmesg | grep -i vda
```

```bash
sudo dmesg | grep vda > vda.txt
```

```bash
grep error /var/log/syslog
```

```bash
head -n 10 /var/log/syslog
```

```bash
tail -n 10 /var/log/syslog
```

```bash
ls -l /var/log
```

```bash
ls -l /boot/
```

```bash
man systemctl
```

```bash
sudo systemctl stop cron
```

```bash
sudo systemctl status cron
```

```bash
sudo systemctl start cron
```

```bash
sudo systemctl status cron
```

```bash
systemctl list-units -t service
```

```bash
systemctl list-units -t service | grep -i ssh
```

```bash
systemctl --failed
```

```bash
man journalctl
```

```bash
journalctl -u ssh.service
```

```bash
systemctl show ssh.service
```

```bash
sudo systemctl restart ssh
```

## Chapter 6: Storage

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
sudo lsblk
```

```bash
sudo fdisk -l
```

```bash
sudo parted /dev/vdb mklabel gpt
```

```bash
sudo fdisk -l /dev/vdb
```

```bash
sudo parted /dev/vdb mkpart primary 1 100%
```

```bash
sudo parted /dev/vdb print
```

```bash
sudo parted /dev/vdc mklabel msdos
```

```bash
sudo parted /dev/vdc mkpart primary 1 100%
```

```bash
sudo parted /dev/vdc print
```

```bash
sudo parted /dev/vdc rm 1
```

```bash
sudo mkfs.ext4 /dev/vdb1
```

```bash
sudo tune2fs -o acl /dev/vdb1
```

```bash
sudo mkdir /mnt/mymount
```

```bash
sudo mount /dev/vdb1 /mnt/mymount
```

```bash
sudo umount /dev/vdb1
```

```bash
sudo mkdir /mnt/myext4fs
```

```bash
sudo mount /dev/vdb1 /mnt/myext4fs
```

```bash
mount | grep vdb
```

```bash
df -h
```

```bash
sudo lsblk -a -p -o name,size | grep 10G
```

```bash
sudo parted /dev/vdc mklabel gpt
```

```bash
sudo pvcreate /dev/vdb1 /dev/vdc1
```

```bash
sudo pvs
```

```bash
sudo vgcreate ubuntu-vg /dev/vdb1 /dev/vdc1
```

```bash
sudo vgs
```

```bash
sudo lvcreate -l 100%VG -n lvmdata ubuntu-vg
```

```bash
sudo lvs
```

```bash
sudo lvdisplay
```

```bash
sudo mkfs.ext4 /dev/ubuntu-vg/lvmdata
```

```bash
sudo mkdir /lvmdata
```

```bash
sudo mount /dev/ubuntu-vg/lvmdata /lvmdata
```

```bash
df -h /lvmdata
```

## Chapter 6: Storage Replacement Validation

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
sudo lsblk
```

```bash
sudo fdisk -l
```

```bash
sudo parted /dev/vdb mklabel gpt
```

```bash
sudo fdisk -l /dev/vdb
```

```bash
sudo parted /dev/vdb mkpart primary 1 100%
```

```bash
sudo parted /dev/vdb print
```

```bash
sudo parted /dev/vdc mklabel msdos
```

```bash
sudo parted /dev/vdc mkpart primary 1 100%
```

```bash
sudo parted /dev/vdc print
```

```bash
sudo parted /dev/vdc rm 1
```

```bash
sudo mkfs.ext4 /dev/vdb1
```

```bash
sudo tune2fs -o acl /dev/vdb1
```

```bash
sudo mkdir /mnt/mymount
```

```bash
sudo mount /dev/vdb1 /mnt/mymount
```

```bash
sudo umount /dev/vdb1
```

```bash
sudo lsblk
```

```bash
sudo mkfs.ext4 /dev/vdb1
```

```bash
sudo mkdir /mnt/myext4fs
```

```bash
sudo mount /dev/vdb1 /mnt/myext4fs
```

```bash
mount | grep vdb
```

```bash
df -h
```

```bash
sudo umount /dev/vdb1
```

```bash
sudo lsblk -a -p -o name,size | grep 10G
```

```bash
sudo parted /dev/vdb mklabel gpt
```

```bash
sudo parted /dev/vdc mklabel gpt
```

```bash
sudo parted /dev/vdb mkpart primary 1 100%
```

```bash
sudo parted /dev/vdc mkpart primary 1 100%
```

```bash
sudo apt install -y lvm2
```

```bash
sudo vgscan
```

```bash
sudo pvcreate /dev/vdb1 /dev/vdc1
```

```bash
sudo pvs
```

```bash
sudo vgcreate ubuntu-vg /dev/vdb1 /dev/vdc1
```

```bash
sudo vgs
```

```bash
sudo lvcreate -l 100%VG -n lvmdata ubuntu-vg
```

```bash
sudo lvs
```

```bash
sudo lvdisplay
```

```bash
sudo mkfs.ext4 /dev/ubuntu-vg/lvmdata
```

```bash
sudo mkdir /lvmdata
```

```bash
sudo mount /dev/ubuntu-vg/lvmdata /lvmdata
```

```bash
df -h /lvmdata
```

## Chapter 7: Networking

Connection wrapper: [redacted; executed against the assigned lab VM]

Replacement-LABVM validation completed on 2026-08-29.

```bash
ip link show
```

```bash
ip -s -s link show ens2
```

```bash
ip route show
```

```bash
ip neigh show
```

```bash
ip route get 8.8.8.8
```

```bash
sudo ip link add labdummy0 type dummy
```

```bash
sudo ip link set labdummy0 up
```

```bash
sudo ip addr add 198.18.0.1/24 dev labdummy0
```

```bash
ip addr show dev labdummy0
```

```bash
sudo ip link add dev labdummy42 link labdummy0 type vlan id 42
```

```bash
ip -d link show dev labdummy42
```

```bash
sudo ip link delete labdummy42
```

```bash
sudo ip addr delete 198.18.0.1/24 dev labdummy0
```

```bash
sudo ip link delete labdummy0
```

```bash
ip addr show dev ens2
```

```bash
ip -s link show dev ens2
```

```bash
sudo apt install -y traceroute
```

```bash
ping -c 4 www.google.com
```

```bash
dig www.google.com
```

Replacement-LABVM commands 17-32 validated on 2026-08-29.

```bash
sudo apt install -y ethtool
```

```bash
ethtool ens2
```

```bash
ethtool -g ens2
```

```bash
ethtool -i ens2
```

```bash
ethtool -S ens2
```

```bash
ethtool -k ens2
```

```bash
ethtool -P ens2
```

```bash
ping -c 3 ubuntu.com
```

```bash
ping -c 3 -n ubuntu.com
```

```bash
ping -w 2 canonical.com
```

```bash
dig ubuntu.com
```

```bash
traceroute -n -m 3 -w 2 www.google.com
```

```bash
mtr -n -r -c 2 www.google.com
```

## Chapter 8: Process Management

Connection wrapper: [redacted; executed against the assigned lab VM]

### Replacement-LABVM retry 2026-08-30

```bash
ps -ef
```

```bash
ps -C sshd
```

```bash
ps -ef
```

```bash
ps -C sshd
```

```bash
top -s
```

```bash
top
```

```bash
ps -ef | grep ubuntu
```

```bash
jobs -l
```

```bash
htop
```

### Replacement-LABVM completion 2026-08-30

```bash
top -b -n1 -s
```

```bash
top -b -n1
```

```bash
printf '%s\n' '#!/bin/bash' '' 'while true' 'do' '    echo "hello world" >> hello.txt' '    sleep 1' 'done' > ~/chapter8-validation/loop.sh
```

```bash
chmod 750 ~/chapter8-validation/loop.sh
```

```bash
ps -ef | grep ubuntu
```

```bash
cd ~/chapter8-validation && ./loop.sh &
```

```bash
jobs -l
```

```bash
kill "$LOOP_SCRIPT_PID"
```

```bash
cd ~/chapter8-validation && nice -n 15 ./loop.sh &
```

```bash
sleep 600 &
```

```bash
sudo renice -5 -p "$SLEEP_PID"
```

```bash
ps -o pid=,ni=,comm= -p "$SLEEP_PID"
```

```bash
sudo kill -9 "$SLEEP_PID"
```

```bash
printf '%s\n' '* * * * * touch /home/ubuntu/chapter8-validation/cron-ran' | crontab -
```

```bash
sudo apt install at -y
```

```bash
printf '%s\n' 'touch /home/ubuntu/chapter8-validation/at-ran' | at now + 1 minute
```

```bash
atq
```

```bash
sudo apt install -y htop
```

```bash
htop --version
```

## Chapter 9: Backup and Recovery Replacement-LABVM 9.1-9.2 Validation (2026-08-30)

```bash
gzip myfile
```

```bash
gzip -d myfile.gz
```

```bash
gzip -l myfile.gz
```

```bash
bzip2 myfile
```

```bash
bzip2 -d myfile.bz2
```

```bash
bzip2 -1 myfile
```

```bash
xz myfile
```

```bash
xz -d myfile.xz
```

```bash
xz -e -9 myfile
```

```bash
xz -l myfile.xz
```

```bash
tar cvf myfiles.tar myfile1 myfile2
```

```bash
tar xvf myfiles.tar
```

```bash
tar tvf myfiles.tar
```

```bash
tar xvf isolated-path-source/mydir.tar -C isolated-path-destination
```

```bash
tar czvf myfile.tar.gz myfile
```

```bash
tar tzvf myfile.tar.gz
```

```bash
tar xzvf myfile.tar.gz
```

```bash
tar cjvf myfile.tar.bz2 myfile
```

```bash
tar tjvf myfile.tar.bz2
```

```bash
tar xjvf myfile.tar.bz2
```

```bash
tar cJvf myfile.tar.xz myfile
```

```bash
tar tJvf myfile.tar.xz
```

```bash
tar xJvf myfile.tar.xz
```

## Chapter 9: Backup and Recovery Replacement-LABVM 9.3 Local rsync Validation (2026-08-30)

```bash
rsync -avP ~/chapter9-validation/rsync-local-20260830/file-source/file.tar ~/chapter9-validation/rsync-local-20260830/file-backups/
```

```bash
rsync -avP ~/chapter9-validation/rsync-local-20260830/directory-source/ ~/chapter9-validation/rsync-local-20260830/directory-backups/
```

```bash
rsync -avP --delete ~/chapter9-validation/rsync-local-20260830/delete-source/ ~/chapter9-validation/rsync-local-20260830/delete-backups/
```

```bash
rsync -azvP --remove-source-files ~/chapter9-validation/rsync-local-20260830/remove-source/file.txt ~/chapter9-validation/rsync-local-20260830/remove-backups/
```

```bash
rsync -azvP --dry-run ~/chapter9-validation/rsync-local-20260830/dry-run-source/file.txt ~/chapter9-validation/rsync-local-20260830/dry-run-backups/
```

## Chapter 9: Backup and Recovery Replacement-LABVM 9.4 Fixture Validation (2026-08-30)

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
LC_ALL=C MANPAGER=cat man tar 2>/dev/null | col -b | grep -m 1 'TAR'
```

```bash
tar cf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/source etc
```

```bash
tar tf ~/chapter9-validation/myetc.tar
```

```bash
sudo tar uvf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/source root/.bashrc
```

```bash
tar tf ~/chapter9-validation/myetc.tar | grep root/.bashrc
```

```bash
sudo tar --delete -f ~/chapter9-validation/myetc.tar root/.bashrc
```

```bash
if tar tf ~/chapter9-validation/myetc.tar | grep -q root/.bashrc; then exit 1; else [ "${PIPESTATUS[1]}" -eq 1 ]; fi
```

```bash
cd ~/chapter9-validation
```

```bash
tar xvf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/selective etc/hostname
```

```bash
mkdir ~/chapter9-validation/full
```

```bash
tar xvf ~/chapter9-validation/myetc.tar -C ~/chapter9-validation/full
```

```bash
gzip ~/chapter9-validation/myetc.tar
```

```bash
tar czvf ~/chapter9-validation/myetc2.tgz -C ~/chapter9-validation/source etc
```

```bash
mkdir ~/chapter9-validation/tgz
```

```bash
tar xzvf ~/chapter9-validation/myetc2.tgz -C ~/chapter9-validation/tgz
```

```bash
sudo rm -rf ~/chapter9-validation
```

```bash
cd ~
```

## Chapter 1: What is Ubuntu Replacement-Machine Validation (2026-08-31)

The following source commands were validated on the user-approved replacement LABVM on 2026-08-31.

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
ssh ubuntu@192.168.100.4
```

```bash
cat /etc/os-release
```

```bash
cat /etc/lsb-release
```

```bash
uname -a
```

```bash
cat /proc/version_signature
```

## Prerequisites Current-Assignment Validation (2026-08-31)

The following source commands were validated on the user-approved replacement assignment on 2026-08-31.

Connection wrapper: [redacted; executed against the assigned lab VM]

```bash
ssh <LABHOST_USER>@<LABHOST_PUBLIC_IP>
```

```bash
ssh ubuntu@192.168.100.4
```

```bash
lsb_release -d
```

```bash
lsblk
```

```bash
lsb_release -d
```

```bash
nproc
```

```bash
free -h
```

```bash
lsblk
```

```bash
ping -c 3 ubuntu.com
```
