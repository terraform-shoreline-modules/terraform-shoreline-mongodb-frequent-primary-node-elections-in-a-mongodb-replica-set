

#!/bin/bash



# Set the parameters

ELECTION_TIMEOUT=${NEW_ELECTION_TIMEOUT}

CONFIG_FILE=${CONFIG_FILE_PATH}



# Update the election timeout value in the MongoDB configuration file

sed -i "s/electionTimeoutMillis:.*/electionTimeoutMillis: $ELECTION_TIMEOUT/" $CONFIG_FILE



# Restart the MongoDB service to apply the changes

systemctl restart mongodb.service