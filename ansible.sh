#!/bin/sh

defaultKeepass=$HOME/kDrive/personnel.kdbx
read -p  "Quelle base Keepass utiliser? [$defaultKeepass]" keepass
keepass="${keepass:-$defaultKeepass}"

stty -echo
read -p "Quel est le mot de passe de '$keepass'?: " password
stty echo
printf '\n'


DEFAULT_SYSTEM_USER="nicolas-delsaux"
read -p  "Quel est l'utilisateur Linux? [$DEFAULT_SYSTEM_USER]" systemUser
systemUser="${systemUser:-$defaultKeepass}"

# Now read values from keepassxc database
# keepassxc command-line is obviously slightly different

qnapPassword=$(echo "$password" | keepassxc-cli show $keepass "QNAP" --show-protected --quiet --attributes "password")
raspbianPassword=$(echo "$password" | keepassxc-cli show $keepass "Minidell" --show-protected --quiet --attributes "password")
dockPeekSecret=$(echo "$password" | keepassxc-cli show $keepass "DockPeek" --show-protected --quiet --attributes "SECRET")
dockPeekUsername=$(echo "$password" | keepassxc-cli show $keepass "DockPeek" --show-protected --quiet --attributes "username")
dockPeekUserpass=$(echo "$password" | keepassxc-cli show $keepass "DockPeek" --show-protected --quiet --attributes "password")

currentFolder=${PWD}
# Finally start the docker image!
# See https://stackoverflow.com/a/36648428 for the ssh socket madness
docker="sudo docker run --rm --name ansible -t -i --mount type=bind,source=$SSH_AUTH_SOCK,target=/ssh-agent --env SSH_AUTH_SOCK=/ssh-agent  -e  DOCKPEEK_SECRET=\"$dockPeekSecret\" -e  DOCKPEEK_ADMIN_MAIL=\"$dockPeekUsername\" -e  DOCKPEEK_ADMIN_PASS=\"$dockPeekUserpass\" -e QNAP_PASSWORD=\"$qnapPassword\" -e RASPBIAN_PASSWORD=\"$raspbianPassword\" -v $currentFolder/ansible:/ansible:ro willhallonline/ansible:2.16.4-bookworm-slim /bin/bash"

bash -c "$docker"
