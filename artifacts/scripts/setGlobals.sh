#!/bin/bash

setGlobals () {

	if [ $1 -eq 0 ] ; then
		CORE_PEER_LOCALMSPID="Org1MSP"
		CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/peers/peer0.org1.example.com/tls/ca.crt
		CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org1.example.com/users/Admin@org1.example.com/msp
                CORE_PEER_ADDRESS=peer0.org1.example.com:7051
	elif [ $1 -eq 1 ]; then
                CORE_PEER_LOCALMSPID="Org2MSP"
                CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/peers/peer0.org2.example.com/tls/ca.crt
                CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/org2.example.com/users/Admin@org2.example.com/msp
                CORE_PEER_ADDRESS=peer0.org2.example.com:7051
#	elif [ $1 -eq 2 ]; then
#                CORE_PEER_LOCALMSPID="Org3MSP"
#                CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/lab2.pharmacy.com/peers/peer0.lab2.pharmacy.com/tls/ca.crt
#                CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/lab2.pharmacy.com/users/Admin@lab2.pharmacy.com/msp
#                CORE_PEER_ADDRESS=peer0.lab2.pharmacy.com:7051
#        elif [ $1 -eq 3 ]; then
#                CORE_PEER_LOCALMSPID="Org4MSP"
#                CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/arf.pharmacy.com/peers/peer0.arf.pharmacy.com/tls/ca.crt
#                CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/arf.pharmacy.com/users/Admin@arf.pharmacy.com/msp
#                CORE_PEER_ADDRESS=peer0.arf.pharmacy.com:7051	
#        elif [ $1 -eq 4 ]; then
#                CORE_PEER_LOCALMSPID="Org5MSP"
#                CORE_PEER_TLS_ROOTCERT_FILE=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/phar1.pharmacy.com/peers/peer0.phar1.pharmacy.com/tls/ca.crt
#                CORE_PEER_MSPCONFIGPATH=/opt/gopath/src/github.com/hyperledger/fabric/peer/crypto/peerOrganizations/phar1.pharmacy.com/users/Admin@phar1.pharmacy.com/msp
#                CORE_PEER_ADDRESS=peer0.phar1.pharmacy.com:7051
        fi

	env |grep CORE
}
