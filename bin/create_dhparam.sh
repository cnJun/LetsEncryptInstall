
source "./bin/input.sh"

openssl dhparam -out $nginx_conf_path/dhparam.pem 4096
