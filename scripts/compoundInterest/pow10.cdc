import CompoundInterest from "../../contracts/flow/contracts/CompoundInterest.cdc"

pub fun main(x: UFix64): UFix64 {
  return CompoundInterest.pow10(x)
}
