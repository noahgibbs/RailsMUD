# The site address is where your server can be found.  It might be
# something like freebeer.com or playbobomud.org.
export RM_SITE_ADDRESS=railsmud.mydomain.com
export RM_SITE_URL=http://$RM_SITE_ADDRESS

# Set up information for your outbound mail server.  You can probably
# find this information on your ISP's web site.  The username and password
# is usually the one for your ISP.  The domain is the one you want your
# outbound mail coming from.
export RM_SMTP_SERVER=smtp.myisp.com
export RM_SMTP_DOMAIN=$RM_SITE_ADDRESS
export RM_SMTP_USER=joesmith
export RM_SMTP_PASSWORD='j03_707411Y_r0xx0rz'
export RM_MAIL_PREFIX='[MyMUD]'

# The name for the original admin account
export RM_ADMIN_NAME=joe_the_admin

# The 'customer service' address your users are told to use
export RM_ADMIN_EMAIL=joesmith@myisp.com
