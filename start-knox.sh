#!/bin/bash

runuser -l $KNOX_USER -c $BIN_PATH'/knoxcli.sh create-master --master knox'
runuser -l $KNOX_USER -c $BIN_PATH'/ldap.sh start'
runuser -l $KNOX_USER -c $BIN_PATH'/gateway.sh start'
runuser -l $KNOX_USER -c $BIN_PATH'/knoxcli.sh create-alias sandbox.discovery.pwd --value maria_dev'
tail -f $KNOX_PATH/logs/gateway.log