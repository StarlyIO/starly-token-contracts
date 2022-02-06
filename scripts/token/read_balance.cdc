import FungibleToken from "../../contracts/flow/contracts/FungibleToken.cdc"
import StarlyToken from "../../contracts/flow/contracts/StarlyToken.cdc"

pub fun main(address: Address): UFix64 {
    let balanceRef = getAccount(address).getCapability(StarlyToken.TokenPublicBalancePath)
        .borrow<&{FungibleToken.Balance}>()
        ?? panic("Could not borrow balance public reference")

    return balanceRef.balance
}
