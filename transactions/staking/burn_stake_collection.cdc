import StarlyTokenStaking from "../../contracts/flow/contracts/StarlyTokenStaking.cdc"

transaction() {
    let stakeCollection: @StarlyTokenStaking.Collection?

    prepare(acct: AuthAccount) {
        self.stakeCollection <- acct.load<@StarlyTokenStaking.Collection>(from: StarlyTokenStaking.CollectionStoragePath)
    }

    execute {
        destroy self.stakeCollection
    }
}
