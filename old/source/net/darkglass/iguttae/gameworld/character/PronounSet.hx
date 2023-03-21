package net.darkglass.iguttae.gameworld.character;

class PronounSet
{
    /**
     * Plural pronouns can have priority in mixed groups.
     */
    public var priority:Int   = 0;

    /**
     * Subject version. ex: "he", "she"
     */
    public var subject:String = "PN_SUBJECT";

    /**
     * Object version. ex: "him", "her"
     */
    public var object:String  = "PN_OBJECT";

    /**
     * dPossessive version (?). ex: "his", "her"
     */
    public var dPossessive:String = "PN_DPOSSESSIVE";

    /**
     * iPossessive version (?). ex: "his", "hers"
     */
    public var iPossessive:String = "PN_IPOSSESSIVE";

    /**
     * reflexive version. ex: "himself", "herself"
     */
    public var reflexive:String = "PN_REFLEXIVE";

    public function new()
    {
        // pass?
    }
}