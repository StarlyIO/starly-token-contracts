import FungibleToken from "../../contracts/FungibleToken.cdc"
import StarlyToken from "../../contracts/StarlyToken.cdc"
import StarlyTokenVesting from "../../contracts/StarlyTokenVesting.cdc"

transaction() {
    prepare(acct: AuthAccount) {
        let vestingCollectionRef = acct.borrow<&StarlyTokenVesting.Collection>(from: StarlyTokenVesting.CollectionStoragePath)!
        let vesting <- vestingCollectionRef.withdraw(withdrawID: vestingCollectionRef.getIDs()[0]) as! @StarlyTokenVesting.NFT
        let manualWithdraw <- vesting.vestedVault.withdraw(amount: 1.0)
        destroy manualWithdraw
        vestingCollectionRef.deposit(token: <-vesting)
    }
}
