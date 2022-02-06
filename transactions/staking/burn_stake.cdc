import NonFungibleToken from "../../contracts/flow/contracts/NonFungibleToken.cdc"
import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction() {
    let stake: @NonFungibleToken.NFT

    prepare(acct: AuthAccount) {
        let stakeCollectionRef = acct.borrow<&StarlyTokenStaking.Collection>(from: StarlyTokenStaking.CollectionStoragePath)!
        self.stake <- stakeCollectionRef.withdraw(withdrawID: stakeCollectionRef.getIDs()[0])
    }

    execute {
        destroy self.stake
    }
}
