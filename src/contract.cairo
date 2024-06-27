#[starknet::contract]
mod arcade_blobert_actions {
    use core::poseidon::{PoseidonTrait, HashStateImpl};
    use random::{
        interface::IRandom, hash_state::{pop_hash_state, HashStateIOTrait},
        random::{random_felt, random_uint, RandomTrait}
    };
    const ADDRESS: felt252 = 42069;
    #[storage]
    struct Storage {}

    #[abi(embed_v0)]
    impl IRandomImpl of IRandom<ContractState> {
        fn felt252(ref self: ContractState, seed: felt252) -> felt252 {
            random_felt(ADDRESS, seed)
        }
        fn bool(ref self: ContractState, seed: felt252) -> bool {
            (random_uint(ADDRESS, seed) % 2_u128) == 0
        }
        fn u8(ref self: ContractState, seed: felt252) -> u8 {
            random_uint(ADDRESS, seed)
        }
        fn u16(ref self: ContractState, seed: felt252) -> u16 {
            random_uint(ADDRESS, seed)
        }
        fn u32(ref self: ContractState, seed: felt252) -> u32 {
            random_uint(ADDRESS, seed)
        }
        fn u64(ref self: ContractState, seed: felt252) -> u64 {
            random_uint(ADDRESS, seed)
        }
        fn u128(ref self: ContractState, seed: felt252) -> u128 {
            random_uint(ADDRESS, seed)
        }
        fn u256(ref self: ContractState, seed: felt252) -> u256 {
            let mut hash_state = pop_hash_state(ADDRESS, seed);
            u256 {
                high: hash_state.next().into_capped(), low: hash_state.complete('low').into_capped()
            }
        }
        fn u8_capped(ref self: ContractState, seed: felt252, cap: u8) -> u8 {
            random_uint(ADDRESS, seed) % cap
        }
        fn u16_capped(ref self: ContractState, seed: felt252, cap: u16) -> u16 {
            random_uint(ADDRESS, seed) % cap
        }
        fn u32_capped(ref self: ContractState, seed: felt252, cap: u32) -> u32 {
            random_uint(ADDRESS, seed) % cap
        }
        fn u64_capped(ref self: ContractState, seed: felt252, cap: u64) -> u64 {
            random_uint(ADDRESS, seed) % cap
        }
        fn u128_capped(ref self: ContractState, seed: felt252, cap: u128) -> u128 {
            random_uint(ADDRESS, seed) % cap
        }
        fn u256_capped(ref self: ContractState, seed: felt252, cap: u256) -> u256 {
            let mut hash_state = pop_hash_state(ADDRESS, seed);
            u256 {
                high: hash_state.next().into_capped(),
                low: hash_state.update('low').finalize().into_capped()
            } % cap
        }
        fn salt(ref self: ContractState, salt: felt252) {
            pop_hash_state(ADDRESS, salt);
        }
    }
}
