import MetadataViews from "../../contracts/flow/contracts/contracts/MetadataViews.cdc"
import StarlyTokenStaking from "../../contracts/flow/contracts/contracts/StarlyTokenStaking.cdc"

pub fun main(address: Address, id: UInt64): AnyStruct? {
    let account = getAccount(address)
    let stakeCollectionRef = account.getCapability(StarlyTokenStaking.CollectionPublicPath)!
        .borrow<&{MetadataViews.ResolverCollection}>()
        ?? panic("Could not borrow capability from public StarlyTokenStaking collection!")
    let viewResolverRef = stakeCollectionRef.borrowViewResolver(id: id)
    return viewResolverRef.resolveView(Type<MetadataViews.Display>())
}