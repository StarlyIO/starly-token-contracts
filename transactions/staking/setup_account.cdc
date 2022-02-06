import NonFungibleToken from "../../contracts/flow/contracts/NonFungibleToken.cdc"
import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction {
    prepare(acct: AuthAccount) {
        if acct.borrow<&StarlyTokenStaking.Collection>(from: StarlyTokenStaking.CollectionStoragePath) == nil {
            acct.save(<-StarlyTokenStaking.createEmptyCollection(), to: StarlyTokenStaking.CollectionStoragePath)
            acct.link<&StarlyTokenStaking.Collection{NonFungibleToken.CollectionPublic, StarlyTokenStaking.CollectionPublic}>(
                StarlyTokenStaking.CollectionPublicPath,
                target: StarlyTokenStaking.CollectionStoragePath)
        }
    }
}
