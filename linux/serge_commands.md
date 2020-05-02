# Commandes de Serge

- LIST PROCESS
    ```bash
    ps aux | less
    ps -ef | grep [programme]
    ```
- PORTS OUVERT
    ```bash
    lsof -i -P -n | grep LISTEN
    netstat -ntlp | grep LISTEN
    ```
- FIND FILE
    ```bash
    find / -name "*.xspf"
    ```
- LINK
    ```bash
    ln -s [file] [destination]
    ```
- USAGE DISK
    ```bash
    df -lh
    ```
- GENERATE SSH KEY
    ```bash
    ssh-keygen -t rsa -b 2048
    ```
- CREATE USER LINUX
    ```bash
    adduser [user]
    ```
- ADD USER TO GROUP
    ```bash
    usermod -aG [group] [user]
    ```
- DEVICES
    ```bash
    lsblk
    ```
- ISO TO USB
    ```bash
    dd bs=4M if=[file iso] of=/dev/sdb
    ```
- IMG TO PDF
    ```bash
    convert *.png outputfile.pdf
    ```
- CLEAN DOCKER
    ```bash
    docker system prune
    ```
- RANDOM STRING
    ```bash
    tr -dc A-Za-z0-9_ < /dev/urandom | head -c 16 | xargs
    ```
- SWAP 1G
    ```bash
    dd if=/dev/zero of=/swapfile bs=1024 count=2097152
    chown root:root /swapfile
    chmod 0600 /swapfile
    mkswap /swapfile
    swapon /swapfile
    sysctl vm.swappiness=100
    echo 'vm.swappiness=100' >> /etc/sysctl.conf
    echo '/swapfile none swap sw 0 0' >> /etc/fstab
    swapoff /swapfile
    ```
- GIT COMMANDS
    ```bash
    git clone --branch <branchname> <remote-repo>
    git add .
    git status
    git commit -m "Message"
    git push origin master
    ```
    - DELETE COMMIT
        ```bash
        git reset --hard [commit ID]
        git push origin HEAD --force
        ```
- ZIP FOLDER
    ```bash
    zip -r [zip file] [directory]
    tar -czvf [tar.gz file] [directory]
    tar -cjvf [tar.bz2 file] [directory]
    ```
- UNCOMPRESS
    ```bash
    tar xf [tar, tar.xz, tar.gz]
    unzip [zip file] -d [directory]
    ```
- TRUNCATE FILE
    ```bash
    truncate -s 0 [file]
    ```
- DUMP SUR TOUTES LES BASES
    ```bash
    mysqldump -u root -p --opt --all-databases --result_file=[sql file]
    pg_dumpall -Fc -O > [file].dump
    ```
- DUMP SUR BASE ENTIERE
    ```bash
    mysqldump -u root -p --result_file=[sql file] [dbname]
    pg_dump -Fc -O [dbname] > [file].dump
    ```
- DUMP SUR BASE SUR TABLE(S)
    ```bash
    mysqldump -u root -p --result_file=[sql file] [dbname] [table1] [table2] [table3]
    pg_dump -Fc -O [dbname] -t [table1] > [file].dump
    ```
- RESTORE BASE
    ```bash
    pg_restore -d [dbname] db.dump
    gunzip < [file].sql.gz | psql [dbname]
    ```
- CREATE USER DB
    - pgsql
        ```sql
        CREATE USER [user] WITH PASSWORD 'password';
        GRANT ALL PRIVILEGES ON DATABASE [dbname] to [user];
        ```
    - mysql
        ```sql
        CREATE USER 'jeffrey'@'localhost' IDENTIFIED BY 'password';
        GRANT ALL ON db1.* TO 'jeffrey'@'localhost';
        ```
- VIRTUALBOX montage du dossier partagé
    ```bash
    net use x: \\vboxsvr\www
    mount -t vboxsf [folder name] [virtual machine folder path]
    usermod -aG vboxsf [user]
    ```
- CONVERT TO MP3
    ```bash
    ffmpeg -i [file] -ab 320k -map_metadata 0 -id3v2_version 3 [output]
    ```
- FUSION DE MP3/FLAC
    ```bash
    ffmpeg -i "concat:input1.mp3|input2.mp3" -c copy output.mp3
    sox *.flac output.flac
    ```
- BACKGROUND COMMAND + OUTPUT TO LOG
    ```bash
    [command] > [log file] 2>&1 &
    nohup [command] > [log file] &
    ```
- PORT RELAYING ANDROID VM
    ```bash
    adb reverse tcp:5000 tcp:5000
    ```
- DOCKER STOP ALL
    ```bash
    docker stop $(docker ps -q)
    ```
- DOWNLOAD FILE
    ```bash
    curl -L -o [output] [url]
    ```
- POST WITH CURL
    ```bash
    curl -X POST http://localhost:8000/login -d _username=user1 -d _password=pass 
    ```
