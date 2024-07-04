module task2::supersodawater_coin {
    use sui::coin::{Self, Coin, TreasuryCap};
     use sui::url::{Self,Url};

    public struct SUPERSODAWATER_COIN has drop {}

    fun init(witness: SUPERSODAWATER_COIN, ctx: &mut TxContext) {
        let (treasury_cap, metadata) = coin::create_currency<SUPERSODAWATER_COIN>(
            witness,
            9,
            b"SUPERSODAWATER_COIN",
            b"SUPERSODAWATER",
            b"learning for letsmove, power by supersodawater",
            option::some<Url>(url::new_unsafe_from_bytes(b"https://avatars.githubusercontent.com/u/167277163")),
            ctx
        );
        transfer::public_freeze_object(metadata);
        transfer::public_transfer(treasury_cap, tx_context::sender(ctx))
    }
    public entry fun mint(
        treasury_cap: &mut TreasuryCap<SUPERSODAWATER_COIN>,
        amount: u64,
        recipient: address,
        ctx: &mut TxContext
    ) {
        coin::mint_and_transfer(treasury_cap, amount, recipient, ctx);
    }
    public fun burn(
        treasury_cap: &mut TreasuryCap<SUPERSODAWATER_COIN>, 
        coin: Coin<SUPERSODAWATER_COIN>
    ) {
        coin::burn(treasury_cap, coin);
    }
}