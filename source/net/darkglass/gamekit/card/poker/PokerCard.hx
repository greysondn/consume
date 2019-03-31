package net.darkglass.gamekit.card.poker;

import net.darkglass.gamekit.card.Card;

import net.darkglass.gamekit.card.poker.Suit;
import net.darkglass.gamekit.card.poker.Face;

class PokerCard extends Card
{
    public var suit:Suit;
    public var face:Face;

    public function new(suit:Suit, face:Face)
    {
        // let parent do its thing
        super();

        // set card
        this.suit = suit;
        this.face = face;
    }
}