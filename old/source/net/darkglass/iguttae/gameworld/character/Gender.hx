package net.darkglass.iguttae.gameworld.character;

class Gender
{
    // I should extract these consts to an enum.
    // TODO: extract constants to enum
    public static var FIRST_SINGULAR(default, null):Int     = 0;
    public static var FIRST_PLURAL(default, null):Int       = 1;
    public static var SECOND_SINGULAR(default, null):Int    = 2;
    public static var SECOND_PLURAL(default, null):Int      = 3;
    public static var THIRD_SINGULAR(default, null):Int     = 4;
    public static var THIRD_PLURAL(default, null):Int       = 5;

    public var uuid:String = "";
    public var name:String = "";
    public var shortdesc:String = "";

    public var terms:Map<Int, PronounSet> = [];

    public function new()
    {
        // we can go ahead and set up the terms, though
        // we'll be lazy and just set them all to the default
        var swp:PronounSet = new PronounSet();

        // and literally we're just setting them all up to exist
        terms.set(Gender.FIRST_SINGULAR, swp);
        terms.set(Gender.FIRST_PLURAL, swp);
        terms.set(Gender.SECOND_SINGULAR, swp);
        terms.set(Gender.SECOND_PLURAL, swp);
        terms.set(Gender.THIRD_SINGULAR, swp);
        terms.set(Gender.THIRD_PLURAL, swp);
    }
}