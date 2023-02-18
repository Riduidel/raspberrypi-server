# raspberrypi-server

Mon script Ansible pour initialiser mon Raspberry avec tout ce qui va bien dedans.

## Prérequis

Le raspberry doit avoir

* Une version de Raspbian moderne
* Le mot de passe pi changé
* La connexion SSH au QNAP doit se faire sans mot de passe

## Lancer avec Windows

**Ne pas oublier de créer une clé SSH sur le Raspberry et de se connecter au QNAP avec les commandes suivantes**



Il faut d'abord installer Docker.
Dans le dossier `raspberrypi-server`, lancer la commande


    set QNAP_PASSWORD=TODO
    set RASBIAN_PASSWORD=TODO
    docker run --rm --name ansible -t -i -e QNAP_PASSWORD="%QNAP_PASSWORD%" -e RASPBIAN_PASSWORD="%RASPBIAN_PASSWORD%" -v %CD%/ansible:/ansible willhallonline/ansible:2.13-ubuntu-22.04 /bin/bash
    mkdir /root/.ssh && ssh-keyscan -t rsa nicolas-delsaux.hd.free.fr > /root/.ssh/known_hosts
    cd /ansible
    ansible-playbook -i hosts bootstrap.yml --extra-vars=ansible_password=$RASPBIAN_PASSWORD

## Qu'est-ce qui manque ?

### La configuration de mldonkey via telnet

    auth admin ""
    set allowed_ips "127.0.0.1 192.168.0.255"

## activer certbot

    certbot --apache

## Copier la config backupée pour l'activer

### Shaarli

    rsync -r admin@192.168.0.2:/share/Download/raspberry-server/to_backup/Shaarli/data/* /var/www/html/Shaarli/data

### rss-bridge

    rsync -r admin@192.168.0.2:/share/Download/raspberry-server/to_backup/rss-bridge/* /var/www/html/rss-bridge

### tweetledee

    rsync -r admin@192.168.0.2:/share/Download/raspberry-server/to_backup/tweetledee/tldlib/keys/* /var/www/tweetledee/tweetledee/tldlib/keys

## Tracabilité

`raspbian-bootstrap` est une simplification de https://github.com/rhietala/raspberry-ansible/

`raspbian_bootstrap`-role is heavily based on
[debian_boostrap](https://github.com/HanXHX/ansible-debian-bootstrap) by
[Emilien Mantel](https://twitter.com/hanxhx_) with minor modifications to
suit Raspbian.

## License

GPLv2
