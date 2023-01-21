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

 