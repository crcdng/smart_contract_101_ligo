# ligo_demo_contract

the steps below demonstrate how to install the required development tools and create a minimal Tezos smart contract in LIGO 

- minimal Tezos smart contract demo 
- from scratch, you only need a Mac (Intel) and some patience during the installation steps
- run on testnet (simulation of the blockchain, no risk of loss)
- up to date (some online tutorials are are outdated and don't work)

## i. install

### install general development tools 

1. download and install the VSCode code editor from https://code.visualstudio.com/

2. install the Homebrew (https://brew.sh/) tool environment: open a Terminal and execute this command 
`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

If you do not have Apple's XCode already installed, make sure that you confirm when prompted "The XCode Command Line Tools will be installed." Alternatively, you can also install XCode from the Apple App Store.

### install LIGO specific development tools 

3. install the Tezos client (source: https://github.com/serokell/tezos-packaging/blob/master/docs/distros/macos.md)

in the Terminal execute this command 

`brew tap serokell/tezos-packaging-stable https://github.com/serokell/tezos-packaging-stable.git`

then:

`brew install tezos-client`

4. install LIGO (source: https://www.ligolang.org/docs/intro/installation/?lang=cameligo)

in the Terminal execute this command 

`brew tap ligolang/ligo https://gitlab.com/ligolang/ligo.git`

followed by

`brew install ligolang/ligo/ligo`

5. in VSCode, install the ligolang-vscode extension https://marketplace.visualstudio.com/items?itemName=ligolang-publish.ligo-vscode 

this concludes the installation.

## ii. compile 

### compile and test the code 
From the command line, run: 

`ligo compile contract mycontract.mligo -o mycontract.tz`

`ligo run interpret "mul(10,32)" --init-file mycontract.mligo`

`ligo run dry-run mycontract.mligo "Multiply(32)" "10"`    
`ligo run dry-run mycontract.mligo "Divide(32)" "10"`    
`ligo run dry-run mycontract.mligo "Divide(32)" "0"`    
`ligo run dry-run mycontract.mligo "Divide(0)" "0"`    

## iii. run 

### activate a testnet account 
get the testnet account from https://teztnets.xyz/ithacanet-faucet (unfortunately most tutorials point to the wrong resource). Save the json into a file called account.json in this directory. 

From the command line (wait a bit between the steps for the transactions to commit), run: 

`tezos-client --endpoint https://rpc.ithacanet.teztnets.xyz config update` (again, the giganode adress mentioned in most tutorials won't work)

pick a name for your account. replace [myname] below with that name.

`tezos-client activate account [myname] with account.json`

`tezos-client get balance for [myname]`

### deploy the smart contract
`tezos-client originate contract mycontract transferring 0 from [myname] running mycontract.tz --init 10 --burn-cap 0.2`

### call the smart contract
`tezos-client call mycontract from [myname] --arg "(Left (Right 32))" --burn-cap 0.2`  


