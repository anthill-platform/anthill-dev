mkdir -p /keys/private
mkdir -p /keys/public

if test -f /keys/private/anthill.pem; then
  exit 0
fi

openssl genrsa -des3 -out /keys/private/anthill.pem -passout pass:${ANTHILL_PEM_PASSPHRASE} 2048
openssl rsa -in /keys/private/anthill.pem -passin pass:${ANTHILL_PEM_PASSPHRASE} -outform PEM -pubout -out /keys/public/anthill.pub