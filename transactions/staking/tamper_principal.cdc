import FungibleToken from "../../contracts/flow/contracts/FungibleToken.cdc"
import StarlyToken from "../../contracts/flow/contracts/StarlyToken.cdc"
import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction() {
    prepare(acct: AuthAccount) {
        let stakeCollectionRef = acct.borrow<&StarlyTokenStaking.Collection>(from: StarlyTokenStaking.CollectionStoragePath)!
        let stake <- stakeCollectionRef.withdraw(withdrawID: stakeCollectionRef.getIDs()[0]) as! @StarlyTokenStaking.NFT
        let manualWithdraw <- stake.principalVault.withdraw(amount: 1.0)
        destroy manualWithdraw
        stakeCollectionRef.deposit(token: <-stake)
    }
}
