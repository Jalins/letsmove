/// Module: move_swap
module move_swap::move_swap {
    use sui::balance;
    use sui::balance::Balance;
    use sui::coin;
    use sui::coin::Coin;
    use sui::transfer::{public_transfer, share_object};
    use sui::tx_context::sender;
    use move_coin::rmb::RMB;
    use move_coin::usd::USD;

    public struct AdminCap has key {
        id: UID
    }

    public struct Pool has key {
        id: UID,
        balanceA: Balance<RMB>,
        balanceB: Balance<USD>,
    }

    fun init(ctx: &mut TxContext) {
        let pool = Pool{
            id: object::new(ctx),
            balanceA: balance::zero<RMB>(),
            balanceB: balance::zero<USD>()
        };

        share_object(pool);

        let adminCap = AdminCap {
            id: object::new(ctx)
        };

        transfer::transfer(adminCap, sender(ctx));
    }

    public entry fun deposit_a(pool: &mut Pool, coin: Coin<RMB>, _: &mut TxContext) {
        balance::join(&mut pool.balanceA, coin::into_balance(coin));
    }

    public entry fun deposit_b(pool: &mut Pool, coin: Coin<USD>, _: &mut TxContext) {
        balance::join(&mut pool.balanceB, coin::into_balance(coin));
    }

    public entry fun withdraw_a(_: &AdminCap, pool: &mut Pool, amount: u64, ctx: &mut TxContext) {
        let withdrawBalance = balance::split(&mut pool.balanceA, amount);
        let coin = coin::from_balance(withdrawBalance, ctx);
        public_transfer(coin, sender(ctx));
    }
    public entry fun withdraw_b(_: &AdminCap, pool: &mut Pool, amount: u64, ctx: &mut TxContext) {
        let withdrawBalance = balance::split(&mut pool.balanceB, amount);
        let coin = coin::from_balance(withdrawBalance, ctx);
        public_transfer(coin, sender(ctx));
    }

    // 1a swap 2b
    public entry fun swap_a_2_b(pool: &mut Pool, coin: Coin<RMB>, ctx: &mut TxContext) {
        let amtA = coin::value(&coin);
        let amtB = amtA * 20000 / 10000;

        balance::join(&mut pool.balanceA, coin::into_balance(coin));

        let balanceB = balance::split(&mut pool.balanceB, amtB);
        let coinB = coin::from_balance(balanceB, ctx);
        public_transfer(coinB, sender(ctx));
    }

    // 2b swap 1a
    public entry fun swap_b_2_a(pool: &mut Pool, coin: Coin<USD>, ctx: &mut TxContext) {
        let amtB = coin::value(&coin);
        let amtA = amtB * 10000 / 20000;

        balance::join(&mut pool.balanceB, coin::into_balance(coin));

        let balanceA = balance::split(&mut pool.balanceA, amtA);
        let coinA = coin::from_balance(balanceA, ctx);
        public_transfer(coinA, sender(ctx));
    }

}
