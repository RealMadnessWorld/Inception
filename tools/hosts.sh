###
# Script to setup host
###

# This script will add or delete the ip address and host name
# of the server in your hosts file


# this part will check if, when you run this script, you give it arguments
# if not it will print a message and exit

if [ $# -eq 0 ]
	then
		echo This is not to be run alone,
		echo Makefile already runs this.
	exit 1
fi

# if the first argument is "add" the script will setup the hosts

if [ $1 == "add" ]
	then

		# Gets the ip address of the nginx container and saves it in a variable
		SERVER_IP=$(echo -n `docker inspect -f '{{range .NetworkSettings.Networks}}{{.IPAddress}}{{end}}' ft_nginx`)

		echo "Server ip address: $SERVER_IP"
		# Deletes any line of the hosts file containing "42.fr"
		sudo sed -i '/42.fr/d' /etc/hosts

		# Adds to the first line of the hosts file what comes after "1i"
		sudo sed -i '1i'$SERVER_IP' '$USER_LOGIN'.42.fr' /etc/hosts
		sudo sed -i '1i'$SERVER_IP' www.'$USER_LOGIN'.42.fr' /etc/hosts
		sudo sed -i '1i'$SERVER_IP' https://www.'$USER_LOGIN'.42.fr' /etc/hosts
fi

if [ $1 == "delete" ]
	then
		sudo sed -i '/42.fr/d' /etc/hosts
fi