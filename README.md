gridengine-environment-test
===========================

```
# 1xb001
cd gridengine-master
vagrant up
cd chef-repo
knife  solo cook vagrant@192.168.33.110 -i ~/.vagrant.d/insecure_private_key nodes/192.168.33.110.json
cd ../..
# 1xrm01
cd gridengine-exec
vagrant up
cd chef-repo
knife  solo cook vagrant@192.168.33.111 -i ~/.vagrant.d/insecure_private_key nodes/192.168.33.111.json

cd ../..
```

install check

```
cd gridengine-master
vagrant ssh
```

check hosts

```
qhost
```

result

```
vagrant@1xb001:~$ qhost
HOSTNAME                ARCH         NCPU  LOAD  MEMTOT  MEMUSE  SWAPTO  SWAPUS
-------------------------------------------------------------------------------
global                  -               -     -       -       -       -       -
1xb001.devops.test      -               -     -       -       -       -       -
1xrm01.devops.test      lx26-amd64      1  0.12  363.3M   53.6M  768.0M    2.4M
```

job test

[from install_manual](https://github.com/manabuishii/gengine-chef-cookbook/blob/master/documents/install_manual.md)

```
cat echo.sge
```

```
echo $USER@`hostname`:`pwd`
```

```
qsub -j y -o /tmp/job.log -wd /tmp echo.sge
```
result

```
vagrant@1xb001:~$ qsub -j y -o /tmp/job.log -wd /tmp echo.sge
Your job 1 ("echo.sge") has been submitted
```
check job status

```
qstat
qacct -j 1
```

```
vagrant@1xb001:~$ qacct -j 1
==============================================================
qname        default             
hostname     1xrm01.devops.test  
group        vagrant             
owner        vagrant             
project      NONE                
department   defaultdepartment   
jobname      echo.sge            
```
check job execute 1xrm01

1xb001 has no /tmp/job.log

```
vagrant@1xb001:~$ hostname
1xb001
vagrant@1xb001:~$ ls -l /tmp
total 52
-rw-r--r-- 1 root root   252 Jun  4 08:05 sge_messages
-rw-r--r-- 1 root root 47481 Jun  4 08:04 stderr
vagrant@1xb001:~$ 
```

exit 1xb001

```
exit
```

```
cd ..
cd gridengine-exec
```

```
vagrant ssh
```

```
hostname
ls -l /tmp
cat /tmp/job.log
```

```
vagrant@1xrm01:~$ hostname
1xrm01
vagrant@1xrm01:~$ ls -l /tmp
total 56
-rw-r--r-- 1 root    root      188 Jun  4 08:09 execd_messages.3268
-rw-r--r-- 1 vagrant vagrant    44 Jun  4 08:17 job.log
-rw-r--r-- 1 root    root    47814 Jun  4 08:07 stderr
vagrant@1xrm01:~$ cat /tmp/job.log
vagrant@1xrm01:/tmp
vagrant@1xrm01:~$ 
```