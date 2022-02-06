import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

pub fun main(address: Address): UFix64 {
    let stakePublicRef = getAccount(address).getCapability(StarlyTokenStaking.StakePublicPath)
        .borrow<&{StarlyTokenStaking.StakePublic}>()
        ?? panic("Could not borrow StarlyTokenStaking stake public reference!")
    return stakePublicRef.getUnstakingFees()
}
