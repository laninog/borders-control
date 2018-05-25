https://www.adimian.com/blog/2014/10/how-to-enable-memberof-using-openldap/

sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f memberof_config.ldif

sudo ldapmodify -Q -Y EXTERNAL -H ldapi:/// -f /tmp/refint1.ldif
sudo ldapadd -Q -Y EXTERNAL -H ldapi:/// -f /tmp/refint2.ldif
