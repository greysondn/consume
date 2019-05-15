class MySpecies
{
    public function newSpecies(data:Array<Dynamic>)
    {
        name = data[0];                     // name
        skin = data[1];                     // parts.desc.skin
        tail = data[2];                     // parts.tail.has
        taliDesc = data[3];                 // parts.tail.desc
        mouth = data[4];                    // parts.desc.mouth
        legs = data[5];                     // parts.desc.legs
        arms = data[6];                     // parts.desc.arms
        hands = data[7];                    // parts.desc.hands
        feet = data[8];                     // parts.desc.feet
        minHeight = data[9];                // measures.height.min
        maxHeight = data[10];               // measures.height.max
        minWeight = data[11];               // measures.weight.min
        maxWeight = data[12];               // measures.weight.max
        minChest = data[13];                // measures.chest.min
        maxChest = data[14];                // measures.chest.max
        minWaist = data[15];                // measures.waist.min
        maxWaist = data[16];                // measures.waist.max
        minHips = data[17];                 // measures.hips.min
        maxHips = data[18];                 // measures.hips.max
        minButt = data[19];                 // measures.butt.min
        maxButt = data[20];                 // measures.butt.max
        breasts = data[21];                 // start.measures.breasts
        penisL = data[22];                  // start.measures.penis.length
        penisW = data[23];                  // start.measures.penis.width
        balls = data[24];                   // start.measures.balls
        errect = data[25];                  // start.measures.erect
        stomach = data[26];                 // start.capacity.stomach
        bowels = data[27];                  // start.capacity.bowels
        milk = data[28];                    // start.capacity.breast
        cum = data[29];                     // start.capacity.testes
        fatGain = data[30];                 // start.gains.fat
        milkGain = data[31];                // start.gains.milk
        cumGain = data[32];                 // start.gains.spunk
        digestDamage = data[33];            // start.digestion.damage
        stretchRateStomach = data[34];      // start.stretch.time.stomach
        stretchRateBowels = data[35];       // start.stretch.time.bowels
        stretchRateMilk = data[36];         // start.stretch.time.breasts
        stretchRateCum = data[37];          // start.stretch.time.testes
        stretchAmountStomach = data[38];    // start.stretch.amount.stomach
        stretchAmountBowels = data[39];     // start.stretch.amount.bowels
        stretchAmountMilk = data[40];       // start.stretch.amount.breasts
        stretchAmountCum = data[41];        // start.stretch.amount.testes
        sphincter = data[42];               // parts.desc.sphincter
    }
}