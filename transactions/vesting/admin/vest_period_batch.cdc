import NonFungibleToken from "../../../contracts/NonFungibleToken.cdc"
import StarlyToken from "../../../contracts/StarlyToken.cdc"
import StarlyTokenVesting from "../../../contracts/StarlyTokenVesting.cdc"

transaction() {

    let vaultRef: &StarlyToken.Vault
    let minterRef: &StarlyTokenVesting.NFTMinter
    let vestingCollectionRef: &{NonFungibleToken.CollectionPublic}

    prepare(acct: AuthAccount) {
        self.vaultRef = acct.borrow<&StarlyToken.Vault>(from: StarlyToken.TokenStoragePath)
            ?? panic("Could not borrow reference to the owner's StarlyToken vault!")
        self.minterRef = acct.borrow<&StarlyTokenVesting.NFTMinter>(from: StarlyTokenVesting.MinterStoragePath)
            ?? panic("Could not borrow reference to StarlyTokenVesting minter!")
        self.vestingCollectionRef = getAccount(acct.address).getCapability(StarlyTokenVesting.CollectionPublicPath)!
            .borrow<&{NonFungibleToken.CollectionPublic}>()
            ?? panic("Could not borrow capability from public StarlyTokenVesting collection!")
    }

    execute {
        let wallets: [Address] = [
            0xfc963d69eb651c45,
            0x59af517ec2899bf3,
            0xbbcef6361ddb21d7,
            0xd07d70eec3713e6a,
            0x9b6b31419e5e3262,
            0x7ff6aa1c41afeff5,
            0x1923e2eafbab0c27,
            0x77cea81bed6d14ad,
            0x8caf69e346fd1077,
            0xc3ea3fbd82869e11,
            0x4e79b1abd8f53640,
            0xa11645460ba7cff4,
            0x2932adb5b9b8b27d,
            0x667b86ed5eb5098d,
            0x4e79b1abd8f53640,
            0x65d593ca2366dc99,
            0x5b1f8fd09603441f,
            0xd27cc6c485cd0474,
            0xc1bdbabbfa885c8f,
            0x03350625d161af34,
            0x7d337ff884b1e4c3,
            0x07dd3ad568c89fa9,
            0xddceaed4685b2d98,
            0xb939878720707311,
            0x8e067d7a7841115a,
            0x3ecb08002f940602,
            0x14ef0215c8f73170,
            0x278d8660937c9ece,
            0xddf2140c87df10ea,
            0xcc778ad0752a2e37,
            0xa78c6248e2f1f33c,
            0x808c8a48ac702bf1,
            0x90ce5de6809b6ec0,
            0x326e4a4926b43204,
            0x9a1f9dd4900a07ea,
            0xb40ab128f49526ed
        ]
        for wallet in wallets {
            let vault <- self.vaultRef.withdraw(amount: 1000.0) as! @StarlyToken.Vault
            let timestamp = getCurrentBlock().timestamp
            let vesting <- self.minterRef.mintPeriod(
                beneficiary: wallet,
                vestedVault: <-vault,
                schedule: {
                    timestamp + 0.0*60.0*60.0*24.0: 0.0,
                    timestamp + 1.0*60.0*60.0*24.0: 0.1,
                    timestamp + 2.0*60.0*60.0*24.0: 0.2,
                    timestamp + 3.0*60.0*60.0*24.0: 0.3,
                    timestamp + 4.0*60.0*60.0*24.0: 0.4,
                    timestamp + 5.0*60.0*60.0*24.0: 0.5,
                    timestamp + 6.0*60.0*60.0*24.0: 0.6,
                    timestamp + 7.0*60.0*60.0*24.0: 0.7,
                    timestamp + 8.0*60.0*60.0*24.0: 0.8,
                    timestamp + 9.0*60.0*60.0*24.0: 0.9,
                    timestamp + 10.0*60.0*60.0*24.0: 1.0})
            self.vestingCollectionRef.deposit(token: <-vesting)
        }
    }
}
