import FungibleToken from "../../contracts/flow/contracts/flow/token/FungibleToken.cdc"
import StarlyToken from "../../contracts/flow/contracts/flow/token/StarlyToken.cdc"
import TeleportCustodyEthereum from "../../contracts/flow/contracts/TeleportCustodyEthereum.cdc"

transaction(admin: Address, amount: UFix64, target: String) {

    // The TeleportUser reference for teleport operations
    let teleportUserRef: &TeleportCustodyEthereum.TeleportAdmin{TeleportCustodyEthereum.TeleportUser}

    // The Vault resource that holds the tokens that are being transferred
    let sentVault: @FungibleToken.Vault

    prepare(signer: AuthAccount) {
        self.teleportUserRef = getAccount(admin).getCapability(TeleportCustodyEthereum.TeleportAdminTeleportUserPath)
            .borrow<&TeleportCustodyEthereum.TeleportAdmin{TeleportCustodyEthereum.TeleportUser}>()
            ?? panic("Could not borrow a reference to TeleportOut")

        let vaultRef = signer.borrow<&StarlyToken.Vault>(from: StarlyToken.TokenStoragePath)
            ?? panic("Could not borrow a reference to the vault resource")

        self.sentVault <- vaultRef.withdraw(amount: amount)
    }

    execute {
        self.teleportUserRef.lock(from: <- self.sentVault, to: target.decodeHex())
    }
}
