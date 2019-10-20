#!/bin/bash

# import setGlobals
. scripts/setGlobals.sh


   echo -e "\033[0;32mCreating channel...\033[0m"
   ./scripts/create_join_updateanchors.sh mychannel 5 "0 1"

   #echo -e "\033[0;32mInstalling chaincodes ARM, LAB, ARF and PHA...\033[0m"
   echo -e "\033[0;32mInstalling chaincode meds...\033[0m"
   ./scripts/install_instantiate.sh mychannel meds v0 "0 1" "0" "OR  ('Org1MSP.member','Org2MSP.member')"
   #./scripts/install_instantiate.sh mychannel lab v0 "0 1" "0" "OR  ('Org1MSP.member','Org2MSP.member')"
   #./scripts/install_instantiate.sh mychannel arf v0 "0 1" "0" "OR  ('Org1MSP.member','Org2MSP.member')"
   #./scripts/install_instantiate.sh mychannel pha v0 "0 1" "0" "OR  ('Org1MSP.member','Org2MSP.member')"

   #echo -e "\033[0;32mCreating ARM1 by default...\033[0m"
   #setGlobals 0
   #peer chaincode invoke --tls true --cafile /opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem -C mychannel -n arm -c '{"Args":["addARM", "ARM1", "Default ARM"]}'

   echo -e "\033[0;32m Completed !!...\033[0m"

exit 0
