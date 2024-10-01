# Name.com Authooks
Simple Certbot DNS manual auth hooks for name.com dns-01 challenge to allow for automatic renewal/creation of wildcard certificates. This was created/adapted from the example at https://eff-certbot.readthedocs.io/en/stable/using.html#hooks.

## How to use?
1. Clone the repo.
2. [Generate an API token](https://www.name.com/support/articles/360007597874-signing-up-for-api-access) to use on name.com
3. Fill credentials in both files and update domain to your domain name.


## Example:

```
 certbot certonly \
 --manual
 --preferred-challenges=dns \
 --manual-auth-hook /path/to/repo/dns-auth.sh \
 --manual-cleanup-hook /path/to/repo/dns-cleanup.sh \
 -d yourdomain.com \
 -d *.yourdomain.com
 ```