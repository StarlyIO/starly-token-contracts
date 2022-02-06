import StarlyToken from "../../contracts/flow/contracts/StarlyToken.cdc"

pub fun main(): UFix64 {
    return StarlyToken.totalSupply
}
