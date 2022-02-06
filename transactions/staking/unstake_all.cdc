import FungibleToken from "../../contracts/flow/contracts/FungibleToken.cdc"
import NonFungibleToken from "../../contracts/flow/contracts/NonFungibleToken.cdc"
import StarlyToken from "../../contracts/flow/contracts/StarlyToken.cdc"
import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction() {
    let vaultRef: &StarlyToken.Vault
    let stakeCollectionRef: &StarlyTokenStaking.Collection

    prepare(acct: AuthAccount) {
        self.vaultRef = acct.borrow<&StarlyToken.Vault>(from: StarlyToken.TokenStoragePath)
            ?? panic("Could not borrow reference to the owner's StarlyToken vault!")

        self.stakeCollectionRef = acct.borrow<&StarlyTokenStaking.Collection>(from: StarlyTokenStaking.CollectionStoragePath)
            ?? panic("Could not borrow reference to the owner's StarlyTokenStaking collection!")
    }

    execute {
        self.vaultRef.deposit(from: <-self.stakeCollectionRef.unstakeAll())
    }
}
