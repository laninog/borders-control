#!/bin/bash

echo
echo " ____    _____      _      ____    _____ "
echo "/ ___|  |_   _|    / \    |  _ \  |_   _|"
echo "\___ \    | |     / _ \   | |_) |   | |  "
echo " ___) |   | |    / ___ \  |  _ <    | |  "
echo "|____/    |_|   /_/   \_\ |_| \_\   |_|  "
echo
echo "Build your first network (BYFN) end-to-end test"
echo
CHANNEL_NAME="$1"
CHAINCODE_NAME="$2"
CHAINCODE_VERSION="$3"
DESIRED_PEERS="$4"
PEER_WHO_INSTANTIATE="$5"
DESIRED_POLICY="$6"
: ${CHANNEL_NAME:="mychannel"}
: ${TIMEOUT:="60"}
: ${DELAY:="5"}
: ${CHAINCODE_NAME:="chaincode_example02"}
: ${CHAINCODE_VERSION:="1.0"}
: ${DESIRED_PEERS:="0 1 2 3 4"}
: ${PEER_WHO_INSTANTIATE:=0}
: ${DESIRED_POLICY:="OR  ('Org1MSP.member','Org2MSP.member','Org3MSP.member','Org4MSP.member','Org5MSP.member')"}
COUNTER=1
MAX_RETRY=5
ORDERER_CA=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/ordererOrganizations/example.com/orderers/orderer.example.com/msp/tlscacerts/tlsca.example.com-cert.pem

echo "Channel name : "$CHANNEL_NAME

# import setGlobals.sh
. scripts/setGlobals.sh

# verify the result of the end-to-end test
verifyResult () {
	if [ $1 -ne 0 ] ; then
		echo "!!!!!!!!!!!!!!! "$2" !!!!!!!!!!!!!!!!"
    echo "========= ERROR !!! FAILED to execute End-2-End Scenario ==========="
		echo
   		exit 1
	fi
}

installChaincode () { 
	for ch in $1; do
        	# $1 - peerX.orgX , $2 - chaincode_name , $3 - chaincode_version
		PEER=$ch
		setGlobals $PEER
		peer chaincode install -n $2 -v $3 -p github.com/chaincode/$2 >&log.txt
		res=$?
		cat log.txt
        	verifyResult $res "Chaincode installation on remote peer PEER$PEER has Failed"
		echo "===================== Chaincode is installed on remote peer PEER$PEER ===================== "
		echo
	done
}

instantiateChaincode () {
        # $1 - peerX.orgX , $2 - chaincode_name , $3 - chaincode_version , $4 - desired_policy

        PEER=$1
        setGlobals $PEER
        # while 'peer chaincode' command can get the orderer endpoint from the peer (if join was successful),
        # lets supply it directly as we know it using the "-o" option
        if [ -z "$CORE_PEER_TLS_ENABLED" -o "$CORE_PEER_TLS_ENABLED" = "false" ]; then
                peer chaincode instantiate -o orderer.example.com:7050 -C $CHANNEL_NAME -n $2 -v $3 -c '{"Args":["a","200","b","200"]}' -P "$4" >&log.txt
        else
                peer chaincode instantiate -o orderer.example.com:7050 --tls $CORE_PEER_TLS_ENABLED --cafile $ORDERER_CA -C $CHANNEL_NAME -n $2 -v $3 -c '{"Args":["init","a","200","b","200"]}' -P "$4" >&log.txt
        fi
        res=$?
        cat log.txt
        verifyResult $res "Chaincode instantiation on PEER$PEER on channel '$CHANNEL_NAME' failed"
        echo "===================== Chaincode Instantiation on PEER$PEER on channel '$CHANNEL_NAME' is successful ===================== "
        echo ""
}


if [ $# -ne 6 ]
then
   echo "  Invalid parameters: Usage: $0 CHANNEL_NAME CHAINCODE_NAME CHAINCODE_VERSION DESIRED_PEERS PEER_WHO_INSTANTIATE DESIRED_POLICY"
   echo ""
   echo "     Example: $0 channel1 chaincode_example02 1.0 \"0 1 2 3 4\" \"0\" \"OR  ('Org1MSP.member','Org2MSP.member')\""
else
   echo "Installing chaincode on DESIRED_PEERS..."
   installChaincode "$DESIRED_PEERS" "$CHAINCODE_NAME" "$CHAINCODE_VERSION"
   echo ""
   echo "Instantiating chaincode on PEER$PEER_WHO_INSTANTIATE, with policy: $DESIRED_POLICY"
   instantiateChaincode "$PEER_WHO_INSTANTIATE" "$CHAINCODE_NAME" "$CHAINCODE_VERSION" "$DESIRED_POLICY"
   
   echo
   echo "========= All GOOD, Completed!! =========== "
fi

exit 0
