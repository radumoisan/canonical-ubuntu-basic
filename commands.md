# Ubuntu Basic Command Record

## Chapter 1: What is Ubuntu

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
mkdir mydir1
```

```bash
cd mydir1
```

```bash
touch file1
```

```bash
cp file1 file2
```

```bash
ls -al > ~/all_files.txt
```

```bash
wc -l < /etc/passwd
```

```bash
echo sp{el,il,al}
```

```bash
echo $SHELL
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
cd ~
```

```bash
nano
```

```bash
nano fileone.txt
```

```bash
nano shells.txt
```

```bash
man ls
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
mkdir mynewdir
```

```bash
cp -a mydir1/* mynewdir
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
ls -al | less
```

```bash
ls > mylist
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
ping -c1 google.com && echo "That's good, able to ping google.com" || \
echo "That's bad unable to ping google.com"
```

```bash
touch file-{A..Z}{a..z}-{0..9}
```

```bash
touch {A..Z}{a..z}-{0..9}.txt
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
sudo apt install tree -y
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
