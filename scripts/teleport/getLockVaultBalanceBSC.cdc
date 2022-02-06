import TeleportCustodyBSC from "../../contracts/flow/contracts/TeleportCustodyBSC.cdc"

pub fun main(): UFix64 {
    return TeleportCustodyBSC.getLockVaultBalance()
}
