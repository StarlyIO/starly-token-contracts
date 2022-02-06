# Starly Token

### Setup StarlyToken Vault (Emulator)
```
flow transactions send ./transactions/token/setup_account.cdc \
  --signer starly-user-emulator
```

### Setup StarlyToken Vault (Testnet)
```
flow transactions send ./transactions/token/setup_account.cdc \
  --signer starly-user-testnet \
  --network testnet
```

### Transfer StarlyToken (Emulator)
```
flow transactions send ./transactions/token/transfer.cdc \
  100.0 0x01cf0e2f2f715450 \
   --signer starly-admin-emulator
```

### Transfer StarlyToken (Testnet)
```
flow transactions send ./transactions/token/transfer.cdc \
  100.0 0x2c662219431fe24b \
   --signer starly-testnet
```


### Burn StarlyToken (Emulator)
```
flow transactions send ./transactions/token/burn.cdc \
  25.0 \
  --signer starly-user-emulator
```

### Burn StarlyToken (Testnet)
```
flow transactions send ./transactions/token/burn.cdc \
  25.0 \
  --signer starly-user-testnet
  --network testnet
```
