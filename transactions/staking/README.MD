# Starly Token Staking

## Tour on Emulator

* `flow scripts execute scripts/staking/read_staking_summary.cdc` -- getting summary
```
Result: {
  "unstakingEnabled": true,
  "minStakingSeconds": 0.00000000,
  "minStakePrincipalAmount": 0.00000000,
  "unstakingFeesNotAppliedAfterSeconds": 0.00000000,
  "unstakingDisabledUntilTimestamp": 0.00000000,
  "unstakingFee": 0.00000000,
  "stakingEnabled": true,
  "totalInterestPaid": 0.00000000,
  "unstakingFlatFee": 0.00000000,
  "k": 0.01923438,
  "totalPrincipalAmountStaked": 0.00000000
}
```

* `flow transactions send transactions/staking/admin/set_k.cdc 0.15119371` -- set k to 200% APY, for testing

### Staking and unstaking

* `flow transactions send transactions/staking/setup_account.cdc` -- setup account to receive stakes
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #0
* `flow transactions send transactions/staking/stake.cdc 20000.0` -- stake #1
* `flow transactions send transactions/staking/unstake.cdc 0` -- unstake stake #0
* `flow scripts execute scripts/staking/read_accumulated_amount.cdc 0xf8d6e0586b0a20c7 1` -- see how much is accumulated. On Emulator needs new blocks to be precise
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #2
* `flow transactions send transactions/staking/unstake_all.cdc` -- unstake everything

## Administrative

* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #3
* `flow transactions send transactions/staking/admin/refund.cdc 0xf8d6e0586b0a20c7 3` -- refund stake #3
* `flow transactions send transactions/staking/admin/disable_staking.cdc` -- disable staking
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- should not work
* `flow transactions send transactions/staking/admin/enable_staking.cdc` -- enable staking
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #4
* `flow transactions send transactions/staking/admin/disable_unstaking.cdc` -- disable unstaking
* `flow transactions send transactions/staking/unstake.cdc 4` -- should not work
* `flow transactions send transactions/staking/admin/enable_unstaking.cdc` -- enable unstaking
* `flow transactions send transactions/staking/unstake.cdc 4` --  unstake stake #4

### Fees

* `flow transactions send transactions/staking/admin/set_test_unstaking_fees.cdc` -- set some set unstaking fees
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #5
* `flow transactions send transactions/staking/unstake.cdc 5` -- should not work first 20 seconds, unstake within 60 seconds to pay penalty

### Tricky cases

* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #6
* `flow transactions send transactions/staking/tamper_principal.cdc` -- try to deposit or withdraw from staked principal vault, should not be possible
* `flow transactions send transactions/staking/burn_stake.cdc` -- destroy stake #6, tokens inside should get destroyed, totalTokensStaked should decrease
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #7
* `flow transactions send transactions/staking/stake.cdc 10000.0` -- stake #8
* `flow transactions send transactions/staking/burn_stake_collection.cdc` -- destroy collection with stakes #6 and #7
* `flow transactions send transactions/staking/setup_account.cdc` -- restore collection

### Giving custom stake

* `flow transactions send transactions/staking/admin/custom_stake.cdc 0xf8d6e0586b0a20c7 10000.0 0.41899461 0.0` -- create stake #9 and give to user 0xf8d6e0586b0a20c7
