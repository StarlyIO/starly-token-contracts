import StarlyTokenStaking from "../../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction(k: UFix64) {

    let adminRef: &StarlyTokenStaking.Admin

    prepare(acct: AuthAccount) {
        self.adminRef = acct.borrow<&StarlyTokenStaking.Admin>(from: StarlyTokenStaking.AdminStoragePath)
            ?? panic("Could not borrow reference to StarlyTokenStaking admin!")
    }

    execute {
        self.adminRef.setK(k)
    }
}