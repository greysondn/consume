package net.darkglass.gamekit.card.poker;

import net.darkglass.gamekit.card.Deck;

import net.darkglass.gamekit.card.poker.Suit;
import net.darkglass.gamekit.card.poker.Face;
import net.darkglass.gamekit.card.poker.PokerCard;


class PokerDeck extends Deck
{
    public function new(?numberOfDecks:Int = 1)
    {
        // let parent do the thing
        super();

        // add decks
        for (i in 0...numberOfDecks)
        {
            for(suit in Suit.createAll())
            {
                for (face in Face.createAll())
                {
                    this.add(new PokerCard(suit, face));
                }
            }
        }
    }

    public function drawCard():PokerCard
    {
        return cast(this.draw(), PokerCard);
    }
}