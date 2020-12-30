class MyCharacter
{

    private var perks:Array<MyPerk>;
    
    public function totalWeight():Float
    {
        var addedWeight:Float = this.weight;
        // Add up the weight of the player
        
        if (this.stomachContents.length != 0)
        {
            // Add in stomach contents
            for (i in 0...this.stomachContents.length)
            {
                addedWeight += this.stomachContents[i].mass;
            }
        }
        
        addedWeight += this.stomachCurrent;
        
        addedWeight += this.bowelsCurrent;
        
        addedWeight += this.str * 0.8; // Add weight for muscles
        
        addedWeight += this.fat;
        
        return addedWeight;
    }
    
    public function gender(pronoun:String):String
    {
        var genderString:String = "";
        var returnString:String = "";
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:String = "";
        
        if (this.breasts && this.vagina && !this.penis && !this.balls)
            genderString = "Female";
        if (!this.breasts && !this.vagina && this.penis && (this.balls || !this.balls))
            genderString = "Male";
        if ((this.breasts || !this.breasts) && this.vagina && this.penis && (this.balls || !this.balls))
            genderString = "Herm";
        if (this.breasts && !this.vagina && this.penis && (!this.balls || this.balls))
            genderString = "Dickgirl";
        if (this.breasts && !this.vagina && !this.penis && !this.balls)
            genderString = "Doll";
        if (!this.breasts && this.vagina && !this.penis && !this.balls)
            genderString = "Cuntboy";
        if (!this.breasts && !this.vagina && !this.penis && !this.balls)
            genderString = "Neuter";
            
        if (this.perks != null)
        {
            for (i in 0...this.perks.length)
            {
                perkEffectList = this.perks[i].effect.split(" ");
                for (x in 0...perkEffectList.length)
                {
                    perkAction = perkEffectList[x].split(":");
                    perkTarget = perkAction[0];
                    if (perkAction.length > 1)
                    {
                        perkValue = Std.string(perkAction[1]);
                    }
                    
                    if (perkTarget == "GENDER")
                        genderString = perkValue;
                }
            }
        }
        
        switch (pronoun)
        {
            case "gender":
                returnString = genderString;
            case "sub":
                // ported into cdb
            case "obj":
                // ported into cdb
            case "pos":
                // ported into cdb
        }
        
        return returnString;
    }
    
    public function stomachSizeDesc():String
    {
        var message:String = "";
        var size:Int = this.stomachSize();
        
        // this was here but immediately overwritten
        // by the next bit of code anyway?
        message = size + "in";
        
        // this part is now in the new code.

        return message;
    }
    
    public function breastSizeDesc():String
    {
        // already ported to new code
    }
    
    public function chestSizeDesc():String
    {
        var message:String = "";
        var size:Int = this.chestSize;
        
        // Change this into a description, like the breast size later
        
        message = size + " inch";
        
        return message;
    }
    
    public function strDesc():String
    {
        var message:String = "";
        var size:Int = this.str;
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:Int = 0;
        
        for (i in 0...this.perks.length)
        {
            perkEffectList = this.perks[i].effect.split(" ");
            for (x in 0...perkEffectList.length)
            {
                perkAction = perkEffectList[x].split(":");
                perkTarget = perkAction[0];
                if (perkAction.length > 1)
                {
                    perkValue = Std.parseInt(perkAction[1]);
                }
                
                if (perkTarget == "MUSCLES")
                    size += perkValue;
            }
        }
        
        if (size <= 3)
            message = "non-existent";
        if (size > 3 && size <= 5)
            message = "small";
        if (size > 5 && size <= 7)
            message = "average";
        if (size > 7 && size <= 11)
            message = "big";
        if (size > 11 && size <= 20)
            message = "huge";
        if (size > 20 && size <= 30)
            message = "massive";
        if (size > 30 && size <= 50)
            message = "bulging";
        if (size > 50)
            message = "off the chart";
            
        message += " muscles";
        
        return message;
    }
    
    public function ballSizeDesc():String
    {
        var message:String = "";
        var size:Int = this.ballDiam();
        
        if (size <= 3)
            message = "tiny";
        if (size > 3 && size <= 6)
            message = "small";
        if (size > 6 && size <= 8)
            message = "average";
        if (size > 8 && size <= 10)
            message = "big";
        if (size > 10 && size <= 14)
            message = "large";
        if (size > 14 && size <= 20)
            message = "huge";
        if (size > 20 && size <= 30)
            message = "massive";
        if (size > 30 && size <= 50)
            message = "door-filling";
        if (size > 50 && size <= 90)
            message = "person-sized";
        if (size > 90 && size <= 200)
            message = "room-filling";
        if (size > 200)
            message = "off the charts";
            
        return message;
    }
    
    public function breastDiam():Int
    {
        var breastWidth:Int = 0;
        var modBreastSize:Int = this.breastSize;
        var bigBreastVal:Int = 0;
        var breastMass:Float = 0;
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:Int = 0;
        
        for (i in 0...this.perks.length)
        {
            perkEffectList = this.perks[i].effect.split(" ");
            for (x in 0...perkEffectList.length)
            {
                perkAction = perkEffectList[x].split(":");
                perkTarget = perkAction[0];
                if (perkAction.length > 1)
                {
                    perkValue = Std.parseInt(perkAction[1]);
                }
                
                if (perkTarget == "BREASTSIZE")
                {
                    for (i in 0...this.perks[i].count)
                    {
                        modBreastSize += perkValue;
                    }
                }
            }
        }
        
        breastMass = this.breastCurrent + this.breastSize;
        // Add fat to the character's breast size
        breastMass += this.fat / 10;
        
        // breastWidth. breastCurrent same as stomach except the value is for both breasts. So we need to get the size of one boob.
        breastWidth = Math.round(2 * Math.pow((3 * (breastMass / 2)) / (4 * Math.PI), 1 / 3));
        
        return breastWidth + modBreastSize;
    }
    
    public function stomachSize():Int
    {
        var stomachWidth:Int = 0;
        var bigBellyVal:Int = 0;
        var stomachMass:Float = 0;
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:Int = 0;
        
        for (i in 0...this.perks.length)
        {
            perkEffectList = this.perks[i].effect.split(" ");
            for (x in 0...perkEffectList.length)
            {
                perkAction = perkEffectList[x].split(":");
                perkTarget = perkAction[0];
                if (perkAction.length > 1)
                {
                    perkValue = Std.parseInt(perkAction[1]);
                }
                
                if (perkTarget == "BELLYSIZE")
                {
                    for (i in 0...this.perks[i].count)
                    {
                        bigBellyVal += perkValue;
                    }
                }
            }
        }
        
        if (this.stomachCurrent > bigBellyVal)
        {
            stomachMass = this.stomachCurrent;
        } else
        {
            stomachMass = bigBellyVal;
        }
        // Add fat to the calculation
        stomachMass += this.fat / 10; // 10% of the player's fat is added to the mass of their belly
        
        // stomachWidth. stomachCurrent is the player's current stomach mass in cubic inches. so have to translate that into a diamater
        // formula D=2(((3V)/(4pi))^(1/3))
        stomachWidth = Math.round(2 * Math.pow((3 * stomachMass) / (4 * Math.PI), (1 / 3)));
        
        return stomachWidth;
    }
    
    public function ballDiam():Int
    {
        var ballWidth:Int = 0;
        var bigBallVal:Float = this.ballSize;
        var ballMass:Float = 0;
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:Int = 0;
        
        for (i in 0...this.perks.length)
        {
            perkEffectList = this.perks[i].effect.split(" ");
            for (x in 0...perkEffectList.length)
            {
                perkAction = perkEffectList[x].split(":");
                perkTarget = perkAction[0];
                if (perkAction.length > 1)
                {
                    perkValue = Std.parseInt(perkAction[1]);
                }
                
                if (perkTarget == "BALLSIZE")
                {
                    for (i in 0...this.perks[i].count)
                    {
                        bigBallVal += perkValue;
                    }
                }
            }
        }
        
        ballMass = this.ballSize + this.cumCurrent;
        
        ballWidth = Math.round(2 * Math.pow((3 * (ballMass / 2)) / (4 * Math.PI), 1 / 3));
        
        return Math.round(bigBallVal + ballWidth);
    }
    
    public function penisLength():Int
    {
        var cockLength:Int = 0;
        var bigCockVal:Float = this.penisL;
        var cockMass:Float = 0;
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:Int = 0;
        
        for (i in 0...this.perks.length)
        {
            perkEffectList = this.perks[i].effect.split(" ");
            for (x in 0...perkEffectList.length)
            {
                perkAction = perkEffectList[x].split(":");
                perkTarget = perkAction[0];
                if (perkAction.length > 1)
                {
                    perkValue = Std.parseInt(perkAction[1]);
                }
                
                if (perkTarget == "PENISLENGTH")
                {
                    for (i in 0...this.perks[i].count)
                    {
                        bigCockVal += perkValue;
                    }
                }
            }
        }
        
        if (this.arousal < 50)
            cockMass = bigCockVal;
        if (this.arousal >= 50 && this.arousal < 100)
            cockMass = bigCockVal * this.errect;
        if (this.arousal >= 100)
            cockMass = bigCockVal * (this.errect * 1.5);
            
        cockLength = Math.round(cockMass);
        
        return cockLength;
    }
    
    public function penisDiam():Int
    {
        var cockWidth:Int = 0;
        var bigCockVal:Float = this.penisW;
        var cockMass:Float = 0;
        var perkEffectList:Array<String> = new Array();
        var perkAction:Array<String> = new Array();
        var perkTarget:String = "";
        var perkValue:Int = 0;
        
        for (i in 0...this.perks.length)
        {
            perkEffectList = this.perks[i].effect.split(" ");
            for (x in 0...perkEffectList.length)
            {
                perkAction = perkEffectList[x].split(":");
                perkTarget = perkAction[0];
                if (perkAction.length > 1)
                {
                    perkValue = Std.parseInt(perkAction[1]);
                }
                
                if (perkTarget == "PENISWIDTH")
                {
                    for (i in 0...this.perks[i].count)
                    {
                        bigCockVal += perkValue;
                    }
                }
            }
        }
        
        if (this.arousal < 50)
            cockMass = bigCockVal;
        if (this.arousal >= 50 && this.arousal < 100)
            cockMass = bigCockVal * this.errect;
        if (this.arousal >= 100)
            cockMass = bigCockVal * (this.errect * 1.5);
            
        cockWidth = Math.round(cockMass);
        
        return cockWidth;
    }
    
    public function addPerk(addThis:String, globals:GlobalVars, count:Int = 1):Bool
    {
        // New version of this function, Perks now have multiple levels that can be added
        // So when the player wants a perk we need to see if they alreay have the perk using hasPerk
        // if they do then we add one to the value of count, if they don't, we just add the perk
        var perkIndex:Int = -1;
        var perkToAdd:MyPerk = new MyPerk();
        
        for (i in 0...globals.perks.length)
        {
            if (globals.perks[i].name == addThis)
                perkToAdd = globals.perks[i];
        }
        
        perkIndex = this.perks.indexOf(perkToAdd);
        
        if (perkIndex == -1)
        {
            for (i in 0...this.perks.length)
            {
                if (this.perks[i].name == perkToAdd.name)
                    perkIndex = i;
            }
        }
        
        if (this.hasPerk(perkToAdd.name))
        {
            // Player already has the perk
            this.perks[perkIndex].count = this.perks[perkIndex].count + count;
        } else
        {
            this.perks.push(perkToAdd);
            this.perks[this.perks.length - 1].count = count;
        }
        
        return true;
    }
    
    public function perkCount(perkName:String):Int
    {
        var perkIndex:Int = 0;
        
        for (perkIndex in 0...this.perks.length)
        {
            if (this.perks[perkIndex].name == perkName)
                return this.perks[perkIndex].count;
        }
        return 0;
    }
    
    public function hasPerk(perkName:String):Bool
    {
        // Function to test if the character has a perk named 'perkName'. perkName should match the 'name' field of a MyPerk object, not the dispName field.
        var testResult:Bool = false;
        
        for (i in 0...this.perks.length)
        {
            if (this.perks[i].name == perkName)
                testResult = true;
        }
        
        return testResult;
    }
    
    public function removePerk(perkName:String):Bool
    {
        // Function to remove a perk named 'perkName' from a character. Returns true if the perk was removed. False if it was not. Will also return false if the character didn't have the perk to start.
        // Should probably add a check to make sure we're not removing a prereq perk, but this function should never be called anyway.
        var perkID:Int = -1;
        
        for (i in 0...this.perks.length)
        {
            if (this.perks[i].name == perkName)
                perkID = i;
        }
        
        if (perkID == -1)
            return false;
            
        this.perks.remove(this.perks[perkID]);
        return true;
    }
    
    public function newCharacter(species:MySpecies, breasts:Bool, vagina:Bool, penis:Bool, balls:Bool, str:Int, agi:Int, end:Int, int:Int,
            name:String = "NPC", ?perks:Array<MyPerk>)
    {
        var rndHeight:Int = 0;
        var rndWeight:Int = 0;
        var heightRange:Int = 0;
        var weightRange:Int = 0;
        
        var globals:Object = Lib.current.getChildByName("GlobalVars");
        
        this.species = species;
        
        this.name = species.name;
        this.arms = species.arms;
        this.skin = species.skin;
        this.legs = species.legs;
        this.tail = species.tail;
        this.taliDesc = species.taliDesc;
        this.mouth = species.mouth;
        this.hands = species.hands;
        this.feet = species.feet;
        this.sphincter = species.sphincter;
        
        this.breasts = breasts;
        this.vagina = vagina;
        this.penis = penis;
        this.balls = balls;
        this.lac = false;
        
        this.breastSize = species.breasts;
        this.penisL = species.penisL;
        this.penisW = species.penisW;
        this.ballSize = species.balls;
        this.errect = species.errect;
        
        this.stomachCap = species.stomach;
        this.bowelsCap = species.bowels;
        this.breastCap = species.milk;
        this.cumCap = species.cum;
        
        this.fatGain = species.fatGain;
        this.milkGain = species.milkGain;
        this.cumGain = species.cumGain;
        this.digestDamage = species.digestDamage;
        
        this.stretchRateStomach = species.stretchRateStomach;
        this.stretchRateBowels = species.stretchRateBowels;
        this.stretchRateMilk = species.stretchRateMilk;
        this.stretchRateCum = species.stretchRateCum;
        
        this.stretchAmountStomach = species.stretchAmountStomach;
        this.stretchAmountBowels = species.stretchAmountBowels;
        this.stretchAmountMilk = species.stretchAmountMilk;
        this.stretchAmountCum = species.stretchAmountCum;
        
        // Determin the player's maleness, which affects how much they start with here
        
        heightRange = species.maxHeight - species.minHeight;
        weightRange = species.maxWeight - species.minWeight;
        
        rndHeight = species.minHeight + Math.round(Math.random() * heightRange);
        rndWeight = species.minWeight + Math.round(Math.random() * weightRange);
        
        this.tall = rndHeight;
        this.weight = rndWeight;
        
        if (breasts)
        {
            this.chestSize = species.minChest;
            this.waistSize = species.minWaist;
        } else
        {
            this.chestSize = species.maxChest;
            this.waistSize = species.maxWaist;
        }
        if (penis)
        {
            this.hipSize = species.minHips;
            this.buttSize = species.minButt;
        } else
        {
            this.hipSize = species.maxHips;
            this.buttSize = species.maxHips;
        }
        
        this.fat = 0;
        this.stomachCurrent = 10;
        this.breastCurrent = 0;
        this.cumCurrent = 0;
        this.bowelsCurrent = 0;
        
        this.str = str;
        this.agi = agi;
        this.end = end;
        this.int = int;
        
        this.dodge = agi;
        this.melee = agi;
        this.run = agi;
        this.sneak = agi;
        this.spot = int;
        
        this.healthMax = 5 + (this.end * 2);
        this.healthCurr = this.healthMax;
        
        this.name = name;
        
        if (perks != null)
        {
            this.perks = new Array();
            for (i in 0...perks.length)
            {
                if (!this.addPerk(perks[i].name, globals))
                    new AlertBox("ERROR: Perk '" + perks[i].dispName + "' not added.");
            }
        }
    }
    
    public function new() {}
}
