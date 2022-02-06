# CompoundInterest

### See generated compound interest

t = 1 year has 31556952 seconds, k = 0.01923438 which is equivalent of 15% APY
```
flow scripts execute ./scripts/compoundInterest/generated_compound_interest.cdc 31556952.0 0.01923438 \
  --network testnet
```

### pow10 that supports fractions

e.g. 10^1.12345678 is 13.287913122544017, pow10 gives 13.28791317, with error of 0.00000005
```
flow scripts execute ./scripts/compoundInterest/pow10.cdc 1.12345678 \
  --network testnet
```
