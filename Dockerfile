FROM mysql:8.0

# COPY db/ /docker-entrypoint-initdb.d/ is not an entrypoint. It is simply a build-time file copy instruction.
# During docker build, the COPY instruction only places SQL or shell scripts from your local db/ folder into the 
# image directory /docker-entrypoint-initdb.d/. Nothing inside that folder is executed yet.
# the mysql entry point is in secret-reader.sh. go and check secret-reader.sh once 
COPY db/ /docker-entrypoint-initdb.d/

# copying secret-reader.sh into /usr/local/bin/secret-reader.sh
COPY secret-reader.sh /usr/local/bin/secret-reader.sh  

# chmod +x : This command grants execute permissions to the script
# chmod +x: Modifies the file permissions to add the executable (x) flag for all users.
RUN chmod +x /usr/local/bin/secret-reader.sh

# this is the entry point for secret-reader.sh
ENTRYPOINT ["/usr/local/bin/secret-reader.sh"]