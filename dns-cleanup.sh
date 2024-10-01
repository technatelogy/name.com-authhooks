#!/bin/bash

#Testing Environment
#username="<test-env-username>"
#token="<test_auth_token>"
#api_url="https://api.dev.name.com/v4"


#Production Environment
username="<username>"
token="<auth_token>"
api_url="https://api.name.com/v4"

# Get root domain from string
DOMAIN=$(expr match "$CERTBOT_DOMAIN" '.*\.\(.*\..*\)')
if [ -z "$DOMAIN" ]; then
  DOMAIN=$CERTBOT_DOMAIN
fi

echo $DOMAIN
if [ -f /tmp/CERTBOT_$DOMAIN/RECORD_ID ]; then
  while read RECORD_ID; do
    # Remove the challenge TXT record from the zone
    if [ -n "${RECORD_ID}" ]; then
      curl -u "$username:$token" "$api_url/domains/$DOMAIN/records/$RECORD_ID" -X DELETE
    fi
  done < /tmp/CERTBOT_$DOMAIN/RECORD_ID
  rm -f /tmp/CERTBOT_$DOMAIN/RECORD_ID
fi
