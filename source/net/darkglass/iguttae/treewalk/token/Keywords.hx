package net.darkglass.iguttae.treewalk.token;

import net.darkglass.iguttae.treewalk.token.TokenType;

class Keywords
{
    private static var instance:Keywords;
    private static var inited:Bool = false;

    public var dict:Map<String, TokenType>;

    public function new()
    {
        this.dict = new Map<String, TokenType>();

        // and now all the keywords...

        // booleans
        this.dict["true"] = BOOLEAN;
        this.dict["false"] = BOOLEAN;

        // directions
        this.dict["n"] = DIRECTION;
        this.dict["north"] = DIRECTION;

        this.dict["ne"] = DIRECTION;
        this.dict["northeast"] = DIRECTION;

        this.dict["e"] = DIRECTION;
        this.dict["east"] = DIRECTION;

        this.dict["se"] = DIRECTION;
        this.dict["southeast"] = DIRECTION;

        this.dict["s"] = DIRECTION;
        this.dict["south"] = DIRECTION;

        this.dict["sw"] = DIRECTION;
        this.dict["southwest"] = DIRECTION;

        this.dict["w"]    = DIRECTION;
        this.dict["west"] = DIRECTION;

        this.dict["nw"] = DIRECTION;
        this.dict["northwest"] = DIRECTION;

        this.dict["up"] = DIRECTION;
        this.dict["down"] = DIRECTION;

        this.dict["in"] = DIRECTION;
        this.dict["out"] = DIRECTION;

        // preposition?
        this.dict["with"] = WITH;

        // core language?
        this.dict["if"] = IF;
        this.dict["elif"] = ELIF;
        this.dict["else"] = ELSE;
        this.dict["label"] = LABEL;
        this.dict["goto"] = GOTO;
        this.dict["include"] = INCLUDE;

        // commands? Leave them for now?

        Keywords.inited = true;
    }

    public static function create():Keywords
    {
        if (!Keywords.inited)
        {
            Keywords.instance = new Keywords();
        }

        return Keywords.instance;
    }
}