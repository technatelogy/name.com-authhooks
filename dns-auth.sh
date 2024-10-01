#!/bin/bash

#Testing Environment
#username="<test-api-username>"
#token="<test_auth_token>"
#api_url="https://api.dev.name.com/v4"

#Production Environment
username="<username>"
token="<auth_token>"
api_url="https://api.name.com/v4"

echo $CERTBOT_DOMAIN
# Get subdomain from string if any
DOMAIN=$(expr match "$CERTBOT_DOMAIN" '.*\.\(.*\..*\)')
if [ -z "$DOMAIN" ]; then
        DOMAIN=$CERTBOT_DOMAIN
        HOST="_acme-challenge"
else
        SUBDOMAIN="${CERTBOT_DOMAIN/".$DOMAIN"/}"
        HOST="_acme-challenge.$SUBDOMAIN"
fi

echo "Domain: $DOMAIN"
echo $SUBDOMAIN
echo $HOST

RECORD_ID=$(curl -u "$username:$token" "$api_url/domains/$DOMAIN/records" -X POST --data '{"host":"'"$HOST"'","type":"TXT","answer":"'"$CERTBOT_VALIDATION"'","ttl":300}' | jq '.id')

# Save info for cleanup
if [ ! -d /tmp/CERTBOT_$DOMAIN ];then
        mkdir -m 0700 /tmp/CERTBOT_$DOMAIN
fi
echo $RECORD_ID >> /tmp/CERTBOT_$DOMAIN/RECORD_ID

# Sleep to make sure the change has time to propagate over to DNS
sleep 25
