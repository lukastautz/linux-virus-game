key=sudo cat /dev/urandom | sudo tr -dc '[:alpha:]' | sudo fold -w ${1:-20} | sudo head -n 1
sudo echo $key | sudo dd of=/var/ca/ca-private-password.txt oflag=append conv=notrunc
sudo openssl genrsa -des3 -out /var/ca/ca-private.key 2048 -passout pass:"$key"
sudo openssl req -x509 -new -nodes -key /var/ca/ca-private.key -sha512 -days 36500 -out /var/ca/ca-private.pem -passout pass:"$key"