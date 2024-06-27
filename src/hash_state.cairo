use core::{
    integer::BoundedInt, hash::{HashStateTrait, HashStateExTrait, HashStateEx},
    poseidon::{PoseidonTrait, HashState, HashStateImpl}
};
use starknet::{get_block_timestamp, get_tx_info, StorageAddress};
use random::syscalls::{read_syscall, write_syscall};

#[generate_trait]
impl HashStateIOImpl of HashStateIOTrait {
    fn read(self: felt252) -> HashState {
        HashState {
            s0: read_syscall(self),
            s1: read_syscall(self + 1),
            s2: read_syscall(self + 2),
            odd: read_syscall(self + 3) != 0,
        }
    }
    fn write(self: felt252, hash_state: HashState) {
        write_syscall(self, hash_state.s0);
        write_syscall(self + 1, hash_state.s1);
        write_syscall(self + 2, hash_state.s2);
        write_syscall(self + 3, hash_state.odd);
    }
    fn next(ref self: HashState) -> felt252 {
        let hash_state = self.update('next');
        self.s0 = hash_state.s0;
        self.s1 = hash_state.s1;
        self.s2 = hash_state.s2;
        self.odd = hash_state.odd;
        hash_state.finalize()
    }
    fn complete(self: HashState, value: felt252) -> felt252 {
        self.update(value).finalize()
    }
}

fn pop_hash_state(address: felt252, seed: felt252) -> HashState {
    let hash_state = address.read().update_with((get_tx_info().unbox().transaction_hash, seed));
    address.write(hash_state);
    hash_state
}
