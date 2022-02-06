import StarlyTokenStaking from "../../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction(address: Address, id: UInt64) {

    let adminRef: &StarlyTokenStaking.Admin
    let stakeCollectionRef: &{StarlyTokenStaking.CollectionPublic}

    prepare(acct: AuthAccount) {
        self.adminRef = acct.borrow<&StarlyTokenStaking.Admin>(from: StarlyTokenStaking.AdminStoragePath)
            ?? panic("Could not borrow reference to StarlyTokenStaking admin!")
        self.stakeCollectionRef = getAccount(address).getCapability(StarlyTokenStaking.CollectionPublicPath)!
            .borrow<&{StarlyTokenStaking.CollectionPublic}>()
            ?? panic("Could not borrow capability from public collection")
    }

    execute {
        self.adminRef.refund(collection: self.stakeCollectionRef, id: id, k: StarlyTokenStaking.k)
    }
}
