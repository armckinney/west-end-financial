uuid=$(uuidgen)
mkdir $uuid

cert_file=./$uuid/cert.pem
key_file=./$uuid/key.pem
azure_cert_file=./$uuid/azure_cert.pem

# create encrpyted key and cert
openssl req -x509 -newkey rsa:4096 -keyout $key_file -out $cert_file -sha256 -days 365

# merge key and cert, do not re-encrypt key
echo -e "\n\tPEM certificate successfully created.\n\tInitiating conversion to to Azure Format.\n"
openssl pkcs12 -inkey $key_file -in $cert_file -nodes -export -out $azure_cert_file
