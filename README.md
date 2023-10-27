
### About Shoreline
The Shoreline platform provides real-time monitoring, alerting, and incident automation for cloud operations. Use Shoreline to detect, debug, and automate repairs across your entire fleet in seconds with just a few lines of code.

Shoreline Agents are efficient and non-intrusive processes running in the background of all your monitored hosts. Agents act as the secure link between Shoreline and your environment's Resources, providing real-time monitoring and metric collection across your fleet. Agents can execute actions on your behalf -- everything from simple Linux commands to full remediation playbooks -- running simultaneously across all the targeted Resources.

Since Agents are distributed throughout your fleet and monitor your Resources in real time, when an issue occurs Shoreline automatically alerts your team before your operators notice something is wrong. Plus, when you're ready for it, Shoreline can automatically resolve these issues using Alarms, Actions, Bots, and other Shoreline tools that you configure. These objects work in tandem to monitor your fleet and dispatch the appropriate response if something goes wrong -- you can even receive notifications via the fully-customizable Slack integration.

Shoreline Notebooks let you convert your static runbooks into interactive, annotated, sharable web-based documents. Through a combination of Markdown-based notes and Shoreline's expressive Op language, you have one-click access to real-time, per-second debug data and powerful, fleetwide repair commands.

### What are Shoreline Op Packs?
Shoreline Op Packs are open-source collections of Terraform configurations and supporting scripts that use the Shoreline Terraform Provider and the Shoreline Platform to create turnkey incident automations for common operational issues. Each Op Pack comes with smart defaults and works out of the box with minimal setup, while also providing you and your team with the flexibility to customize, automate, codify, and commit your own Op Pack configurations.

# Frequent primary node elections in a MongoDB replica set.
---

This incident type refers to a recurring problem in a MongoDB replica set where the primary node is frequently being elected, causing disruption to the database operations. This can occur due to various reasons such as network issues, hardware failures, or misconfiguration of MongoDB replica set. The frequent elections can lead to reduced performance, data inconsistency, and downtime of the database system. It requires prompt investigation and resolution to prevent further disruptions and ensure the stability of the database operations.

### Parameters
```shell
export HOSTNAME="PLACEHOLDER"

export PASSWORD="PLACEHOLDER"

export USERNAME="PLACEHOLDER"

export AUTH_DATABASE="PLACEHOLDER"

export NEW_ELECTION_TIMEOUT="PLACEHOLDER"

export CONFIG_FILE_PATH="PLACEHOLDER"
```

## Debug

### Check if all nodes in the replica set are running
```shell
echo "rs.status()" | mongo --host ${HOSTNAME} -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase ${AUTH_DATABASE}
```

### Check the replica set configuration
```shell
echo "rs.conf()" | mongo --host ${HOSTNAME} -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase ${AUTH_DATABASE}
```

### Check the replica set status
```shell
echo "rs.status()" | mongo --host ${HOSTNAME} -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase ${AUTH_DATABASE}
```

### Check the replica set oplog size and usage
```shell
echo "db.getReplicationInfo()" | mongo --host ${HOSTNAME} -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase ${AUTH_DATABASE}
```

### Check the replica set members' ping time
```shell
echo "rs.isMaster()" | mongo --host ${HOSTNAME} -u ${USERNAME} -p ${PASSWORD} --authenticationDatabase ${AUTH_DATABASE}
```

### Check the replica set members' log files for errors
```shell
tail -f /var/log/mongodb/mongod.log
```

## Repair

### Consider increasing the election timeout value to allow more time for a primary node to recover before triggering an election.
```shell


#!/bin/bash



# Set the parameters

ELECTION_TIMEOUT=${NEW_ELECTION_TIMEOUT}

CONFIG_FILE=${CONFIG_FILE_PATH}



# Update the election timeout value in the MongoDB configuration file

sed -i "s/electionTimeoutMillis:.*/electionTimeoutMillis: $ELECTION_TIMEOUT/" $CONFIG_FILE



# Restart the MongoDB service to apply the changes

systemctl restart mongodb.service


```