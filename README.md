# raspberrypi-server

Mon script Ansible pour initialiser mon Raspberry avec tout ce qui va bien dedans.

## Prérequis

Le raspberry doit avoir

* Une version de Raspbian moderne
* Le mot de passe pi changé
* La connexion SSH au QNAP doit se faire sans mot de passe

## Lancer avec Windows

Il faut d'abord installer Docker.
Dans le dossier `raspberrypi-server`, lancer la commande **dans PowerShell**

    ansible.ps1

Entrer le mot de passe maître de Keepass

    mkdir /root/.ssh && ssh-keyscan -t rsa nicolas-delsaux.hd.free.fr > /root/.ssh/known_hosts
    cd /ansible
    ansible-galaxy install -r requirements.yml
    ansible-playbook -i hosts bootstrap.yml --extra-vars="ansible_password=\"$RASPBIAN_PASSWORD\" ansible_sudo_password=\"$RASPBIAN_PASSWORD\" qnap_password=\"$QNAP_PASSWORD\""  --ask-vault-pass

## Lancer avec Linux

Il faut d'abord installer Docker.
Dans le dossier `raspberrypi-server`, lancer la commande **dans PowerShell**

    ansible.sh

Entrer le mot de passe maître de Keepass

    mkdir /root/.ssh && ssh-keyscan -t rsa nicolas-delsaux.hd.free.fr > /root/.ssh/known_hosts
    cd /ansible
    ansible-playbook -i hosts bootstrap.yml --extra-vars="ansible_password=\"$RASPBIAN_PASSWORD\" qnap_password=\"$QNAP_PASSWORD\"" --ask-vault-pass

## activer certbot

    certbot --apache

## Tracabilité

`raspbian-bootstrap` est une simplification de https://github.com/rhietala/raspberry-ansible/

`raspbian_bootstrap`-role is heavily based on
[debian_boostrap](https://github.com/HanXHX/ansible-debian-bootstrap) by
[Emilien Mantel](https://twitter.com/hanxhx_) with minor modifications to
suit Raspbian.

## License

GPLv2
