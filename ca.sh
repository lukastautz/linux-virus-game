key=sudo cat /dev/urandom | sudo tr -dc '[:alpha:]' | sudo fold -w ${1:-20} | sudo head -n 1
sudo echo $key >> /var/ca/ca-private-password.txt
sudo openssl genrsa -des3 -out /var/ca/ca-private.key 2048
sudo openssl req -x509 -new -nodes -key /var/ca/ca-private.key -sha512 -days 36500 -out /var/ca/ca-private.pem -passout pass:"$key"