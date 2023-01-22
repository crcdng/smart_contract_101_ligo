# "my first Tezos smart contract"

This short tutorial shows how to install the development tools and run a minimal Tezos smart contract. You need a Mac (tested on an Intel Mac) and some patience during the installation steps.

- Start from scratch, no previous knowledge necessary 
- Learn to develop a minimal Tezos smart contract 
- Write code in CameLIGO (https://www.ligolang.org/)
- Run the smart contract on a testnet (copy of the actual blockchain, no risk of value loss)

For a curated overview of Tezos developer resources see https://github.com/crcdng/tezos-dev-resources

## i. Install

### Install general development tools 

1. Download and install the [Visual Studio Code code editor](https://code.visualstudio.com/)

2. Install the [Homebrew](https://brew.sh/) tooling environment: open a Terminal (press command-Spacebar and type "terminal"), then execute this command in the Terminal 

`/bin/bash -c "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/HEAD/install.sh)"`

If you do not already have Apple's XCode installed, make sure that you confirm when the installations prompts you with "The XCode Command Line Tools will be installed." Alternatively, you can also get XCode from the Apple App Store.
### Install LIGO specific development tools 

3. Install the Tezos client 

In the Terminal, execute this command 

`brew tap serokell/tezos-packaging-stable https://github.com/serokell/tezos-packaging-stable.git`

then:

`brew install tezos-client`

(source: https://github.com/serokell/tezos-packaging/blob/master/docs/distros/macos.md)

4. Install LIGO 

In the Terminal, execute this command 

`brew tap ligolang/ligo https://gitlab.com/ligolang/ligo.git`

followed by

`brew install ligolang/ligo/ligo`

(source: https://www.ligolang.org/docs/intro/installation/?lang=cameligo)

Note: LIGO is getting regular updates, announced [on their website](https://ligolang.org/). You can run the following  commands to get the latest versions:  

```
brew update
brew upgrade
```

5. In Visual Studio Code, install the [ligolang-vscode extension](https://marketplace.visualstudio.com/items?itemName=ligolang-publish.ligo-vscode) 

...this concludes the installation. Now you are ready to code.

## ii. Code  

Download and unzip this repository (or clone it if you are familiar with git) and open the folder in Visual Studio Code. To do this, either drag and drop the folder on an open Visual Studio Code window, or on its icon in the Dock. Alternatively, select `File` -> `Open Folder...` from the menu and navigate to the folder. 

Open the file [my_first_contract.mligo](my_first_contract.mligo). This is a minimal smart contract, adapted from https://www.ligolang.org/?lang=cameligo. It looks like this: 

```ligo
type storage = int

type parameter =
  Increment of int
| Decrement of int
| Reset

let add (store, delta : storage * int) = store + delta
let sub (store, delta : storage * int) = store - delta

let main (action, store : parameter * storage) : operation list * storage =
 [],   
 (match action with
   Increment (n) -> add (store, n)
 | Decrement (n) -> sub (store, n)
 | Reset         -> 0)
```

The smart contract shown here is for learning - all it does is to multiply or divide two numbers. However, its basic structure is useful to understand any contract.

In the first part it defines three types, followed by three functions. The `main` function is the starting point of the smart contract. It receives parameters that describe three possible actions of the smart contract and returns an empty list of operations and the updated storage. The three actions are: multiply the current value (storage) with a value, divide the two values and reset the storage to 0.

Type definitions and functions are the major building blocks for smart contracts. You can learn more about this, the LIGO syntax and more elaborate smart contracts in the [documentation](https://www.ligolang.org/docs/intro/introduction?lang=cameligo). 

For this tutorial we use the above code to show the next steps - compile it, deploy it to the testnet and then call the smart contract on the blockchain.

## iii. Compile and Test

### Compile the code 
 
Visual Studio Code has a menu for running commands: the Command Palette. With the code in `my_first_contract.mligo` open, select `View` -> `Command Palette` (or press SHIFT-CMD-P) and type `LIGO`. This provides a list of commands like this one: 

![](images/vscode_ligo_commands.jpg)

Select `LIGO: Compile the current LIGO contract`. In the Output section of Visual Studio Code, you should see: 

```
{ parameter (or (or (int %decrement) (int %increment)) (unit %reset)) ;
  storage int ;
  code { UNPAIR ;
         IF_LEFT { IF_LEFT { SWAP ; SUB } { ADD } } { DROP 2 ; PUSH int 0 } ;
         NIL operation ;
         PAIR } }
```

Compiling transforms code written in a higher level programming language meant for humans (here: LIGO) into a lower level language (here: Michelson). In general, you write code in LIGO, compile it to Michelson and send the Michelson code to run on the blockchain. You do not need to learn Michelson at all, but if you want to dive into the details, you can find them [here](https://tezos.gitlab.io/active/michelson.html).

While the Command Palette is useful for quick testing, there is a second way to run more LIGO commands: the command line interface (CLI). To use the CLI, open a Terminal window in VSCode `Terminal -> New Terminal`.

Then enter this line into the Terminal window:

```
ligo compile contract my_first_contract.mligo -o my_first_contract.tz
```

It creates a new file `my_first_contract.tz`. Look into that file: it contains the compiled contract, the same output as above.

```
ligo compile contract my_first_contract.mligo -o my_first_contract.tz
```

### Test the code 

Now you can also test - "dry run" - the code. To add 8 to the initial storage value 0, enter this line into the Terminal window:

```
ligo run dry-run my_first_contract.mligo "Increment(8)" "0"
```

The output is:

```
( LIST_EMPTY() , 8 )
```

This is the empty list of operations and the value 8 in the updated storage, as mentioned above.

Now, in a real project you would be well-advised to test the functions of the smart contract more thoroughly and also to test the Michelson code on a local, simulated blockchain. These steps are described [here](https://ligolang.org/docs/tutorials/getting-started?lang=cameligo#test-the-code-with-ligo-test-framework) and [here](https://ligolang.org/docs/tutorials/getting-started?lang=cameligo#testing-the-michelson-contract). We will go on and deploy our contract on a public chain made for testing - the Ghostnet.

## iv. Deploy 

**WORK IN PROGRESS** 

---

This repository is part of an onging effort to support Tezos developers and encourage artists who want to learn about creative (blockchain)   coding that started during [hicathon](https://hicathon.xyz/). Published under the Creative Commons Attribution 4.0 International License (CC BY 4.0).
