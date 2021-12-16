package test

import (
	"strings"
	"testing"

	emulator "github.com/onflow/flow-emulator"
	"github.com/onflow/flow-go-sdk"
	"github.com/onflow/flow-go-sdk/crypto"
	"github.com/onflow/flow-go-sdk/templates"
	"github.com/onflow/flow-go-sdk/test"
	"github.com/stretchr/testify/assert"

	ft_contracts "github.com/onflow/flow-ft/lib/go/contracts"
)

func StarlyTokenDeployContract(b *emulator.Blockchain, t *testing.T) (flow.Address, flow.Address, crypto.Signer) {
	accountKeys := test.AccountKeyGenerator()

	// Should be able to deploy a contract as a new account with no keys.
	fungibleTokenCode := loadFungibleToken()
	fungibleAddr, err := b.CreateAccount(
		[]*flow.AccountKey{},
		[]templates.Contract{{
			Name:   "FungibleToken",
			Source: string(fungibleTokenCode),
		}},
	)
	assert.NoError(t, err)

	_, err = b.CommitBlock()
	assert.NoError(t, err)

	starlyTokenAccountKey, starlyTokenSigner := accountKeys.NewWithSigner()
	starlyTokenCode := loadStarlyToken(fungibleAddr)

	starlyTokenAddr, err := b.CreateAccount(
		[]*flow.AccountKey{starlyTokenAccountKey},
		[]templates.Contract{{
			Name:   "StarlyToken",
			Source: string(starlyTokenCode),
		}},
	)
	assert.NoError(t, err)

	_, err = b.CommitBlock()
	assert.NoError(t, err)

	return fungibleAddr, starlyTokenAddr, starlyTokenSigner
}

func loadFungibleToken() []byte {
	return ft_contracts.FungibleToken()
}

func loadStarlyToken(fungibleAddr flow.Address) []byte {
	return []byte(strings.ReplaceAll(
		string(readFile(starlyTokenPath)),
		"\"./FungibleToken.cdc\"",
		"0x"+fungibleAddr.String(),
	))
}
