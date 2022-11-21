# "my first Tezos smart contract"

This short tutorial shows how to install development tools and run a minimal Tezos smart contract. 

- Learn to develop a minimal Tezos smart contract 
- Start from scratch, you need a Mac (Intel) and some patience during the installation steps
- Write code in CameLIGO (https://www.ligolang.org/)
- Run the smart contract on a testnet (copy of the actual blockchain, no risk of value loss)

For a curated overview of Tezos developer resources see https://github.com/crcdng/tezos-dev-resources

## i. Install

### v general development tools 

1. Download and install the [Visual Studio Code code editor](https://code.visualstudio.com/)

2. Install the [Homebrew](https://brew.sh/) tool environment: open a Terminal and execute this command 

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

If you do not have Apple's XCode already installed, make sure that you confirm when prompted "The XCode Command Line Tools will be installed." Alternatively, you can also install XCode from the Apple App Store.

### Install LIGO specific development tools 

3. Install the Tezos client 

In the Terminal execute this command 

`brew tap serokell/tezos-packaging-stable https://github.com/serokell/tezos-packaging-stable.git`

then:

`brew install tezos-client`

(source: https://github.com/serokell/tezos-packaging/blob/master/docs/distros/macos.md)

4. Install LIGO 

In the Terminal execute this command 

`brew tap ligolang/ligo https://gitlab.com/ligolang/ligo.git`

followed by

`brew install ligolang/ligo/ligo`

(source: https://www.ligolang.org/docs/intro/installation/?lang=cameligo)

5. In Visual Studio Code, install the [ligolang-vscode extension](https://marketplace.visualstudio.com/items?itemName=ligolang-publish.ligo-vscode) 

...this concludes the installation. Now you are ready to code.

## ii. Code  

Download and unzip this repository (or clone it if you are familiar with git) and open the folder in Visual Studio Code. To do this, either drag and drop the folder on an open Visual Studio Code window, or on its icon in the dock. Alternatively, select `File` -> `Open Folder...` from the menu and navigate to the folder. 

Open the file [my_first_contract.mligo](my_first_contract.mligo). It contains a minimal smart contract that multiplies / divides numbers, adapted from https://www.ligolang.org/?lang=cameligo. The code in `my_first_contract.mligo` looks like this:

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

This code defines three types and three functions. The funcion called `main` takes parameters that describe the three entry points of the smart contract: one that multiplies the current value (storage) with a value, one that divides two values and one that resets a value to 0. 

You can learn more about LIGO and writing smart contracts in the [documentation](https://www.ligolang.org/docs/intro/introduction?lang=cameligo). For now we use this code to demonstrate what to doi with it - to compile 

  
🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧 **WORK IN PROGRESS** 

## iii. compile 

### compile and test the code 
 
Visual Studio Code provides a menu to run commands: the Command Palette. Open it by selecting `View` -> `Command Palette` and type `LIGO`. This shows a list of commands 

## iV. deploy 

### activate a testnet account 

### deploy the smart contract

### call the smart contract

**WORK IN PROGRESS** 🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧

Published under the Creative Commons Attribution 4.0 International License (CC BY 4.0).
