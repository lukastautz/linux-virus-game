key=cat /dev/urandom | tr -dc '[:alpha:]' | fold -w ${1:-20} | head -n 1
sudo echo $key >> /etc/ca/ca-private-password.txt
sudo openssl genrsa -des3 -out ca-private.key 2048
sudo openssl req -x509 -new -nodes -key ca-private.key -sha512 -days 36500 -out ca-private.pem -passout pass:"$key"