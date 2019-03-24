
source "./bin/input.sh"

## 生成域名https证书
cd "$HostPath"

openssl genrsa 4096 > account.key
openssl genrsa 4096 > domain.key
openssl req -new -sha256 -key domain.key -subj "/CN=$host" > domain.csr
# python acme_tiny.py --account-key account.key --csr domain.csr --acme-dir $acme_challenge_path > signed.crt || exit
acme_tiny.py --account-key account.key --csr domain.csr --acme-dir $acme_challenge_path > signed.crt || exit
wget -O - https://letsencrypt.org/certs/lets-encrypt-x3-cross-signed.pem > intermediate.pem
cat signed.crt intermediate.pem > chained.pem
