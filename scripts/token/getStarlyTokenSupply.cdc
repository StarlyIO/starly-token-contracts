import StarlyToken from "../../contracts/flow/token/StarlyToken.cdc"

pub fun main(): UFix64 {
    return StarlyToken.totalSupply
}
