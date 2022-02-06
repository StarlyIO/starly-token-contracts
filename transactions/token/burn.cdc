import FungibleToken from "../../contracts/flow/contracts/FungibleToken.cdc"
import StarlyToken from "../../contracts/flow/contracts/StarlyToken.cdc"

transaction(amount: UFix64) {

    let vault: @FungibleToken.Vault

    prepare(signer: AuthAccount) {
        let vaultRef = signer.borrow<&FungibleToken.Vault>(from: StarlyToken.TokenStoragePath)
            ?? panic("Could not borrow reference to the owner's Vault!")
        self.vault <- vaultRef.withdraw(amount: amount)
    }

    execute {
        destroy self.vault;
    }
}
