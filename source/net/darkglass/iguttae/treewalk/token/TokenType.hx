package net.darkglass.iguttae.treewalk.token;

enum TokenType
{
    // single symbol
    DOT;         // .
    COMMA;       // ,

    PLUS;        // +
    MINUS;       // -
    STAR;        // *
    SLASH;       // /

    SEMICOLON;   // ;

    ASSIGNMENT;  // =

    // pairs
    LEFT_PAREN;  // (
    RIGHT_PAREN; // )
    LEFT_BRACE;  // {
    RIGHT_BRACE; // }
    LEFT_BRACK;  // [
    RIGHT_BRACK; // ]

    // comparators and logic
    
    NOT;                        // !
    AND;                        // '&&' | 'and'
    OR;                         // '||' | 'or'

    IS_EQUAL;                   // '=='
    NOT_EQUAL;                  // '!='

    GREATER_THAN;               // '>'
    GREATER_THAN_OR_EQUAL;      // '>='
    
    LESS_THAN;                  // '<'
    LESS_THAN_OR_EQUAL;         // '<='

    // literal values
    IDENTIFIER;
    STRING;
    NUMBER;
    BOOLEAN;

    // keywords: Core language
    IF;
    ELIF;
    ELSE;
    LABEL;
    GOTO;
    INCLUDE;

    // keywords: directions
    DIRECTION;
    
    // 'n'  | 'north'
    // 'ne' | 'northeast'
    // 'e'  | 'east'
    // 'se' | 'southeast'
    // 's'  | 'south'
    // 'sw' | 'southwest'
    // 'w'  | 'west'
    // 'nw' | 'northwest'
    // 'u'  | 'up'
    // 'd'  | 'down'

    // 'in'
    // 'out'

    // keywords - pop goes the preposition?
    WITH;       // 'with'

    // keywords - commands (NOT RECOGNIZED RIGHT NOW)
    DROP;       //  'd' | 'drop'
    GET;        //  'g' | 'get'
    HELP;       //        'help'
    INVENTORY;  //  'i' | 'inventory'
    LOCK;       //        'lock'
    LOOK;       //  'l' | 'look'
    GO;         //        'go'
    UNLOCK;     //        'unlock'

    // keywords - debug commands (NOT RECOGNIZED RIGHT NOW)
    ECHO;       // 'echo'
    TELEPORT;   // 'teleport'

    // end of the line?
    EOF;

    // missing from CI: CLASS, FUN, FOR, NIL, RETURN, SUPER, THIS, WHILE
    // missing from language def: 'option', 'choice',
}