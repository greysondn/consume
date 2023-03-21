package net.darkglass.gamekit.card;

import net.darkglass.gamekit.card.Card;

class Deck 
{
    public var cards:Array<Card>;

    public function new() 
    {
        this.cards = new Array<Card>();
    }

    public function add(card:Card)
    {
        this.cards.push(card);
    }

    public function draw():Card
    {
        return this.cards.pop();
    }

    public function shuffle():Void
    {
        // there are good shuffling algorithms
        // this isn't one of them
        // maybe we should use a better one
        for (i in 0...5)
        {
            for (j in 0...this.cards.length)
            {
                var swap:Card = this.cards[Std.random(this.cards.length)];
                this.cards.remove(swap);
                this.cards.push(swap);
            }
        }
    }
}