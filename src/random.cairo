use core::{
    integer::BoundedInt, hash::{HashStateTrait, HashStateExTrait, HashStateEx},
    poseidon::{PoseidonTrait, HashState, HashStateImpl}
};

use random::hash_state::pop_hash_state;

fn random_uint<T, +BoundedInt<T>, +Into<T, u256>, +Into<T, felt252>, +TryInto<u256, T>,>(
    address: felt252, seed: felt252
) -> T {
    random_felt(address, seed).into_capped()
}

fn random_felt(address: felt252, seed: felt252) -> felt252 {
    pop_hash_state(address, seed).finalize()
}

#[generate_trait]
impl RandomImpl of RandomTrait {
    fn into_capped<T, +BoundedInt<T>, +Into<T, u256>, +Into<T, felt252>, +TryInto<u256, T>,>(
        self: felt252
    ) -> T {
        (Into::<felt252, u256>::into(self) & BoundedInt::<T>::max().into()).try_into().unwrap()
    }
}
