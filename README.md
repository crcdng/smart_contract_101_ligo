# "my first Tezos smart contract"

this short tutorial shows how to install the required development tools and run a minimal Tezos smart contract 

- minimal Tezos smart contract demo 
- step by step from scratch, you only need a Mac (Intel) and some patience during the installation 
- up to date (some online tutorials are are outdated / don't work)
- written in CameLIGO (https://www.ligolang.org/)
- runs the smart contract on a testnet (copy of the actual blockchain, no risk of value loss)

for a more comprehensive overview of Tezos developer resources see https://github.com/crcdng/tezos-dev-resources

## i. install

### install general development tools 

1. download and install the [Visual Studio Code code editor](https://code.visualstudio.com/)

2. install the [Homebrew](https://brew.sh/) tool environment: open a Terminal and execute this command 

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

If you do not have Apple's XCode already installed, make sure that you confirm when prompted "The XCode Command Line Tools will be installed." Alternatively, you can also install XCode from the Apple App Store.

### install LIGO specific development tools 

3. install the Tezos client 

in the Terminal execute this command 

`brew tap serokell/tezos-packaging-stable https://github.com/serokell/tezos-packaging-stable.git`

then:

`brew install tezos-client`

(source: https://github.com/serokell/tezos-packaging/blob/master/docs/distros/macos.md)

4. install LIGO 

in the Terminal execute this command 

`brew tap ligolang/ligo https://gitlab.com/ligolang/ligo.git`

followed by

`brew install ligolang/ligo/ligo`

(source: https://www.ligolang.org/docs/intro/installation/?lang=cameligo)

5. in Visual Studio Code, install the [ligolang-vscode extension](https://marketplace.visualstudio.com/items?itemName=ligolang-publish.ligo-vscode) 

...this concludes the installation. Now you are ready to code.

## ii. code  

The file [my_first_contract.mligo](my_first_contract.mligo) contains a minimal smart contract, adapted from from https://www.ligolang.org/?lang=cameligo. 

Download and unzip this this repository (or clone it if you are familiar with git) and open the folder in Visual Studio Code. Either drag and drop the folder on an open Visual Studio Code window, or on its icon in the dock. Alternatively, select `File` -> `Open Folder...` from the menu and navigate to the folder of this repository. The code in `my_first_contract.mligo` looks like this:

```ligo
type storage = int

type parameter =
  Multiply of int
| Divide of int
| Reset

type return = operation list * storage

let mul (store, delta : storage * int) : storage = store * delta
let div (store, delta : storage * int) : storage = store / delta
   
let main (action, store : parameter * storage) : return =
 ([] : operation list),   
 (match action with
   Multiply (n) -> mul (store, n)
 | Divide (n) -> div (store, n)
 | Reset         -> 0)
```

It defines three types and three functions. The funcion called `main` takes parameters that describe the entry points of the smart contract, one that multiplies the current value (storage) with a value, one that divides and one that resets it to 0. You can learn more about LIGO and writing smart contracts in the [documentation](https://www.ligolang.org/docs/intro/introduction?lang=cameligo). 


🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧 **WORK IN PROGRESS** 


## iii. compile 


### compile and test the code 
From the command line, run: 

`ligo compile contract mycontract.mligo -o mycontract.tz`

`ligo run interpret "mul(10,32)" --init-file mycontract.mligo`

`ligo run dry-run mycontract.mligo "Multiply(32)" "10"`    
`ligo run dry-run mycontract.mligo "Divide(32)" "10"`    
`ligo run dry-run mycontract.mligo "Divide(32)" "0"`    
`ligo run dry-run mycontract.mligo "Divide(0)" "0"`    

## iV. deploy 

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

**WORK IN PROGRESS** 🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧

Published under the Creative Commons Attribution 4.0 International License (CC BY 4.0).
