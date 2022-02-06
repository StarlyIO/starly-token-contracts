import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

pub fun main(): UFix64 {
    return StarlyTokenStaking.totalInterestPaid
}
