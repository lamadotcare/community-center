#!/usr/bin/env bash
shopt -s extglob
shopt -s xpg_echo
set -o pipefail

###
# Things to do:
# generate unique passwords for each credential in passwords.yml
# reencrypt passwords.yml with a unique key
# remind user to store it in a password manager (because their install is hosed without it)
# run the community-center ansible playbook with --ask-vault-password (no creds in files)
