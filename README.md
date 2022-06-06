# demo_contract

Smart contract demo. 

these steps go successfully through the deployment of a "hello world" style Tezos smart contract on Ithaca testnet *on a mac*:

install a tezos client by following instructions on https://github.com/serokell/tezos-packaging/blob/master/docs/distros/macos.md (`brew install tezos` from the tutorial does not work. If you use the public testnet node below you don't need to run a full node) 

install Ligo https://ligolang.org/docs/intro/installation (I installed via Docker)

install VSCode and the ligolang-vscode extension https://marketplace.visualstudio.com/items?itemName=ligolang-publish.ligo-vscode (I ran into an error mentioned here: https://gitlab.com/ligolang/ligo/-/issues/1413)

get the test account from https://teztnets.xyz/ithacanet-faucet (unfortunately most tutorials point to the wrong resource). Save as account.json in this directory. 

From the command line (wait a bit between the steps for the transactions to commit): 

tezos-client --endpoint https://rpc.ithacanet.teztnets.xyz config update (again the giganode mentioned in most turials won't work)

pick a name for your account. replace [myname] below with that

tezos-client activate account [myname] with account.json

tezos-client get balance for [myname]

tezos-client originate contract contract transferring 0 from [myname] running contract.tz --init 10 --burn-cap 0.2

tezos-client call contract from [myname] --arg "(Left (Right 32))" --burn-cap 0.2  