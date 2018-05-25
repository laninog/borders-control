https://www.adimian.com/blog/2014/10/how-to-enable-memberof-using-openldap/

sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f memberof_config.ldif

sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f /tmp/refint1.ldif
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /tmp/refint2.ldif

ldapsearch -H ldap://35.227.55.69:389 -x -D "cn=admin,dc=example,dc=org" -W -b "uid=iberia,ou=airlines,dc=example,dc=org" "dn" "memberOf"

https://jira.hyperledger.org/browse/FAB-3416