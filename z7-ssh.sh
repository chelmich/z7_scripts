#!/usr/bin/env bash

# Simple script to interact with the ZYBO Z7 SoC over ssh
# Note: This script is written for IPv6.

# edit this to match the ip assigned to the ZYBO board
ip="fe80::218:3eff:fe02:be8f"

# edit this to match the network interface the board is connected to
link="enp0s20u2u3"

# these flags prevent warnings about changing RSA key
keycheckflags="-oUserKnownHostsFile=/dev/null -oStrictHostKeyChecking=no"

print_usage (){
    echo -e "Usage: \tz7-ssh { login | ping }"
    echo -e "\tz7-ssh { copy-to | copy-from } SOURCE DESTINATION"
    echo "where SOURCE and DESTINATION are file paths enclosed in qoutes"
}

num_args="$#"

# checks for the correct number of arguments
check_args (){
    if [ $num_args -ne $1 ]; then
        echo "Error: invalid number of arguments"
        print_usage
        exit 1
    fi
}

case "$1" in
    login)
        check_args 1
        echo "Logging in to $ip on interface $link"
        ssh -6 $keycheckflags root@$ip%$link
        ;;
    copy-to)
        check_args 3
        echo "Copying $2 to $3 at $ip on interface $link"
        scp -6 $keycheckflags $2 root@\[$ip%$link\]:$3
        ;;
    copy-from)
        check_args 3
        echo "Copying $2 from $3 at $ip on interface $link"
        scp -6 $keycheckflags root@\[$ip%$link\]:$2 $3
        ;;
    ping)
        check_args 1
        ping -6 $ip%$link
        ;;
    *)
        print_usage
esac
