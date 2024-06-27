use starknet::{
    syscalls::{storage_read_syscall, storage_write_syscall}, StorageAddress, SyscallResultTrait
};

fn read_syscall<T, +TryInto<T, StorageAddress>,>(address: T) -> felt252 {
    storage_read_syscall(0, address.try_into().unwrap()).unwrap_or_default()
}

fn write_syscall<T, S, +TryInto<T, StorageAddress>, +Into<S, felt252>, +Drop<S>>(
    address: T, value: S
) {
    storage_write_syscall(0, address.try_into().unwrap(), value.into()).unwrap_syscall();
}
