module lazy_forever_coin::lazy_forever_faucet {
    use std::option;
    use sui::coin::{Self, Coin, TreasuryCap};
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};
    use sui::url::{Url,Self};

    /// The type identifier of coin. The coin will have a type
    /// tag of kind: `Coin<package_object::mycoin::MYCOIN>`
    /// Make sure that the name of the type matches the module's name.
    public struct LAZY_FOREVER_FAUCET has drop {}

    /// Module initializer is called once on module publish. A treasury
    /// cap is sent to the publisher, who then controls minting and burning
    fun init(witness: LAZY_FOREVER_FAUCET, ctx: &mut TxContext) {
        let (treasury, metadata) = coin::create_currency(
            witness,
            6,
            b"LAZY_FOREVER_FAUCET",
            b"lazy_forever",
            b"lazy_forever's faucet",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://blog.lazyforever.top/img/favicon.png")),
            ctx);
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury, tx_context::sender(ctx))
    }
    public fun mint(treasury_cap: &mut TreasuryCap<LAZY_FOREVER_FAUCET>, recipient: address, ctx: &mut TxContext) {
        coin::mint_and_transfer(treasury_cap, 1000000, recipient, ctx);
    }

    public fun burn(treasury_cap: &mut TreasuryCap<LAZY_FOREVER_FAUCET>, coin: Coin<LAZY_FOREVER_FAUCET>) {
        coin::burn(treasury_cap, coin);
    }
}
