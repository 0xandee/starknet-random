#[starknet::interface]
trait IRandom<TContractState> {
    fn felt252(ref self: TContractState, seed: felt252) -> felt252;
    fn bool(ref self: TContractState, seed: felt252) -> bool;
    fn u8(ref self: TContractState, seed: felt252) -> u8;
    fn u16(ref self: TContractState, seed: felt252) -> u16;
    fn u32(ref self: TContractState, seed: felt252) -> u32;
    fn u64(ref self: TContractState, seed: felt252) -> u64;
    fn u128(ref self: TContractState, seed: felt252) -> u128;
    fn u256(ref self: TContractState, seed: felt252) -> u256;
    fn u8_capped(ref self: TContractState, seed: felt252, cap: u8) -> u8;
    fn u16_capped(ref self: TContractState, seed: felt252, cap: u16) -> u16;
    fn u32_capped(ref self: TContractState, seed: felt252, cap: u32) -> u32;
    fn u64_capped(ref self: TContractState, seed: felt252, cap: u64) -> u64;
    fn u128_capped(ref self: TContractState, seed: felt252, cap: u128) -> u128;
    fn u256_capped(ref self: TContractState, seed: felt252, cap: u256) -> u256;
    fn salt(ref self: TContractState, salt: felt252);
}
