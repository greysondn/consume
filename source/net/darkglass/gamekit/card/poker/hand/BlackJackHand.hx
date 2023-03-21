package net.darkglass.gamekit.card.poker.hand;

import haxe.ui.components.Switch;
import net.darkglass.gamekit.card.poker.PokerCard;
import net.darkglass.gamekit.card.poker.Face;

class BlackJackHand
{
    public var cards:Array<PokerCard> = [];

    public function new()
    {
        // pass
    }

    private function rate():Int
    {
        // let's do this
        var ret:Int = -1;
        var minValue:Int = 9001;

        // possible values this hand can have
        var values:Array<Int> = [0];

        // iterate over the cards
        for (card in this.cards)
        {
            // add ranks to array
            if (Face.ACE == card.face)
            {
                var startLength:Int = values.length;

                for (i in 0...startLength)
                {
                    values.push(values[i]);

                    values[i] = values[i] + 1;
                    values[values.length - 1] = values[values.length - 1] + 11;
                }
            }
            else
            {
                var cardValue:Int = 42;

                if (Face.TWO == card.face)
                {
                    cardValue = 2;
                }
                else if (Face.THREE == card.face)
                {
                    cardValue = 3;
                }
                else if (Face.FOUR == card.face)
                {
                    cardValue = 4;
                }
                else if (Face.FIVE == card.face)
                {
                    cardValue = 5;
                }
                else if (Face.SIX == card.face)
                {
                    cardValue = 6;
                }
                else if (Face.SEVEN == card.face)
                {
                    cardValue = 7;
                }
                else if (Face.EIGHT == card.face)
                {
                    cardValue = 8;
                }
                else if (Face.NINE == card.face)
                {
                    cardValue = 9;
                }
                else if (Face.TEN == card.face)
                {
                    cardValue = 10;
                }
                else if (Face.JACK == card.face)
                {
                    cardValue = 10;
                }
                else if (Face.QUEEN == card.face)
                {
                    cardValue = 10;
                }
                else if (Face.KING == card.face)
                {
                    cardValue = 10;
                }

                for (i in 0...values.length)
                {
                    values[i] = values[i] + cardValue;
                }
            }
        }

        // we want the maximum value under 21
        for (i in 0...values.length)
        {
            if (values[i] < 22 && values[i] > ret)
            {
                ret = values[i];
            } 

            if (values[i] < minValue)
            {
                minValue = values[i];
            }
        }

        // make sure ret is a sane value or else min value
        if (-1 == ret)
        {
            ret = minValue;
        }

        return ret;
    }
}