
source "./bin/input.sh"

## Let's Encrypt 证书安装工具：https://github.com/diafygi/acme-tiny
sudo curl -L "https://raw.githubusercontent.com/diafygi/acme-tiny/master/acme_tiny.py" -o /usr/local/bin/acme_tiny.py
sudo chmod +x /usr/local/bin/acme_tiny.py

## nginx 配置目录
HostPath="$nginx_conf_path/$host"

sudo mkdir -p "$nginx_conf_path/web/challenges/"
sudo mkdir -p "$nginx_conf_path/$host"
sudo chmod 777 "$nginx_conf_path/$host"

cp -i ./nginx-config/domain.conf.sample "$nginx_conf_path/$host.conf"
cp -i ./nginx-config/server.conf.sample "$nginx_conf_path/server.conf"
cp -i ./nginx-config/domain.https "$HostPath/domain.https"
cp -i ./nginx-config/https.cfg "$HostPath/https.cfg"
cp -i ./nginx-config/renew_cert.sh "$HostPath/renew_cert.sh"

## 替换配置文件
sed -i "s|Host|$host|g" "$nginx_conf_path/$host.conf"
sed -i "s|AcmeChallengePath|$acme_challenge_path|g" "$nginx_conf_path/$host.conf"
sed -i "s|HttpsConfigPath|$HostPath|g" "$nginx_conf_path/$host.conf"

sed -i "s|Host|$host|g" "$HostPath/domain.https"
sed -i "s|HttpsConfigPath|$HostPath|g" "$HostPath/domain.https"

sed -i "s|HttpsConfigPath|$HostPath|g" "$HostPath/https.cfg"
sed -i "s|NginxConfPath|$nginx_conf_path|g" "$HostPath/https.cfg"

sed -i "s|HttpsConfigPath|$HostPath|g" "$HostPath/renew_cert.sh"
sed -i "s|AcmeChallengePath|$acme_challenge_path|g" "$HostPath/renew_cert.sh"
sed -i "s|Nginx|$nginx|g" "$HostPath/renew_cert.sh"

## 重新加载nginx配置
sudo "$nginx" -s reload
