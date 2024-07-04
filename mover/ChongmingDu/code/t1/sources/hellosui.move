/*
/// Module: hellosui
module hellosui::hellosui {

}
*/

module hellosui::hello {
    use std::ascii::{String, string};
    use sui::object::{Self,UID};
    use sui::transfer::transfer;
    use sui::tx_context::{TxContext, sender};

    public struct Hello has key{
        id:UID,
        say: String
    }

    fun init(ctx: &mut TxContext) {
        let hello_sui = Hello {
            id:object::new(ctx),
            say: string(b"move"),
        };
        transfer(hello_sui, sender(ctx));
    }
}