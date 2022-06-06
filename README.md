# demo_contract

Smart contract demo. 

This goes successfully through the deployment steps on Ithaca testnet: 

get the test account from https://teztnets.xyz/ithacanet-faucet (unfortunately most tutorials point to the wrong resource). Save as account.json in this directory. 

tezos-client --endpoint https://rpc.ithacanet.teztnets.xyz config update (again the giganode mentioned in most turials won't work)

tezos-client activate account crc with account.json

tezos-client originate contract contract transferring 0 from crc running contract.tz --init 10 --burn-cap 0.2

tezos-client call contract from crc --arg "(Left (Right 32))" --burn-cap 0.2  