import FungibleToken from "../../contracts/flow/token/FungibleToken.cdc"
import StarlyToken from "../../contracts/flow/token/StarlyToken.cdc"
import TeleportCustodySolana from "../../contracts/flow/teleport/TeleportCustodySolana.cdc"

transaction(target: Address) {
  // The teleport admin reference
  let teleportAdminRef: &TeleportCustodySolana.TeleportAdmin

  prepare(teleportAdmin: AuthAccount) {
    self.teleportAdminRef = teleportAdmin.borrow<&TeleportCustodySolana.TeleportAdmin>(from: TeleportCustodySolana.TeleportAdminStoragePath)
        ?? panic("Could not borrow a reference to the teleport admin resource")
  }

  execute {
    let feeVault <- self.teleportAdminRef.withdrawFee(amount: self.teleportAdminRef.getFeeAmount())

    // Get the recipient's public account object
    let recipient = getAccount(target)

    // Get a reference to the recipient's Receiver
    let receiverRef = recipient.getCapability(StarlyToken.TokenPublicReceiverPath)
      .borrow<&{FungibleToken.Receiver}>()
      ?? panic("Could not borrow receiver reference to the recipient's Vault")

    // Deposit the withdrawn tokens in the recipient's receiver
    receiverRef.deposit(from: <- feeVault)
  }
}
