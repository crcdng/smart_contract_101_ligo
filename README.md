# "my first Tezos smart contract"

This short tutorial shows how to install development tools and run a minimal Tezos smart contract. 

- Learn to develop a minimal Tezos smart contract 
- Start from scratch, you need a Mac (Intel) and some patience during the installation steps
- Write code in CameLIGO (https://www.ligolang.org/)
- Run the smart contract on a testnet (copy of the actual blockchain, no risk of value loss)

For a curated overview of Tezos developer resources see https://github.com/crcdng/tezos-dev-resources

## i. Install

### Install general development tools 

1. Download and install the [Visual Studio Code code editor](https://code.visualstudio.com/)

2. Install the [Homebrew](https://brew.sh/) tool environment: open a Terminal and execute this command 

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

If you do not have Apple's XCode already installed, make sure that you confirm when prompted "The XCode Command Line Tools will be installed." Alternatively, you can also get XCode from the Apple App Store.

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

Open the file [my_first_contract.mligo](my_first_contract.mligo). It contains a minimal smart contract, adapted from https://www.ligolang.org/?lang=cameligo:

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

This code is here for demonstration purposes - it does not do something exciting except multiplying and dividing two numbers. The first lines define three types, followed by three functions. The function called `main` takes parameters that describe the three entry points of the smart contract: one that multiplies the current value (storage) with a value, one that divides two values and one that resets the current value to 0. 

You can learn more about LIGO and writing smart contracts in the [documentation](https://www.ligolang.org/docs/intro/introduction?lang=cameligo). For this tutorial we use that smart contract to show the next steps - compile it, deploy it to the testnet and then call the smart contract.

## iii. compile 

### test and compile the code 
 
Visual Studio Code has a menu that allows us to run commands: the Command Palette. With the code in `my_first_contract.mligo` open, select `View` -> `Command Palette` (or press SHIFT-CMD-P) and type `LIGO`. This provides a list of commands: 

![](images/vscode_ligo_commands.jpg)

Select `LIGO: Compile the current LIGO contract`. In the Output section of Visual Studio Code, you should see: 

```
{ parameter (or (or (int %divide) (int %multiply)) (unit %reset)) ;
  storage int ;
  code { UNPAIR ;
         IF_LEFT
           { IF_LEFT
               { SWAP ; EDIV ; IF_NONE { PUSH string "DIV by 0" ; FAILWITH } {} ; CAR }
               { SWAP ; MUL } }
           { DROP 2 ; PUSH int 0 } ;
         NIL operation ;
         PAIR } }
```

Compiling transforms code written in a higher level programming language (here: LIGO) into a lower level language (here: Michelson). In general, you write LIGO code, compile it to Michelson and send the Michelson code to run on the blockchain (you could write Michelson directly, but LIGO is easier for humans to read and write). You do not need to learn Michelson at all, but if you want to dive into the details, you can find them [here](https://tezos.gitlab.io/active/michelson.html).

In order to prepare the next step, you now would save the Michelson code into a file with the name `my_first_contract.tz`.

🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧 
**WORK IN PROGRESS** 

## iV. deploy 

### activate a testnet account 

### deploy the smart contract

### call the smart contract


🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧🚧
**WORK IN PROGRESS** 


## Appendix

Commands to run from the Terminal   

Compile the contract:    
`ligo compile contract my_first_contract.mligo -o my_first_contract.tz`

`ligo run interpret "mul(10,32)" --init-file my_first_contract.mligo`

Test the contract with some entry points and values:        
`ligo run dry-run my_first_contract.mligo "Multiply(32)" "10"`        
`ligo run dry-run my_first_contract.mligo "Divide(32)" "10"`        
`ligo run dry-run my_first_contract.mligo "Divide(32)" "0"`        
`ligo run dry-run my_first_contract.mligo "Reset()" "10"`        
`ligo run dry-run my_first_contract.mligo "Divide(0)" "0"`    


---

Published under the Creative Commons Attribution 4.0 International License (CC BY 4.0).
