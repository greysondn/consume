import yaml

def nextLine(oStr, toAdd):
    return oStr + toAdd + "\n"

def indexHeader(oStr, index):
    ret = oStr
    ret = nextLine(ret, "")
    ret = nextLine(ret, "----------------------------------------")
    ret = nextLine(ret, f"index: {index}")
    ret = nextLine(ret, "----------------------------------------")
    ret = nextLine(ret, "")
    return ret

def uidFrom(index):
    ret = str(index)
    ret = ret.zfill(4)
    ret = "_" + ret
    return ret

def sideUidFrom(shorthand):
    # cheating, vaguely, lazily
    lookupTable =   {
                        "n"   : "_0000",
                        "ne"  : "_0001",
                        "e"   : "_0002",
                        "se"  : "_0003",
                        "s"   : "_0004",
                        "sw"  : "_0005",
                        "w"   : "_0006",
                        "nw"  : "_0007",
                        "i"   : "_0008",
                        "o"   : "_0009",
                        "u"   : "_0010",
                        "d"   : "_0011"
                    }
                    
    # with that it's as easy as
    return lookupTable[shorthand]

def main():
    src = yaml.load(open("doors.yaml").read())
    
    final = ""
    
    # just traverse those
    for door in src:
        # this will be output eventually.
        out = ""
        swp = ""
        

        
        # index will be helpful.
        if ("index" in door):
            out = indexHeader(out, door["index"])
        else:
            out = indexHeader(out, "unknown")
        
        # full shebang prefix
        swp = swp + "[{ rooms : [ "
        
        # ----------------------------------------------------------------------
        # LEFT DOOR
        # ----------------------------------------------------------------------
        
        dUid  = uidFrom(door["rooms"]["left"]["index"])
        dName = door["desc"]["name"]["rightToLeft"]

        dLook = ""
        if ("look" in door["desc"]):
            dLook = door["desc"]["look"]["rightToLeft"]
            if dLook == None:
                dLook = ""
        
        dSide = sideUidFrom(door["rooms"]["left"]["side"])
        
        # prefix still
        swp = swp + "{ uid : \"left\", "
        
        # index
        swp = swp + "room : \"" + dUid + "\", "
        
        # description fold
        swp = swp + "description : [ { "
        
        # name
        swp = swp + "name : \"" + dName + "\", "
        
        # look description
        swp = swp + "look : \"" + dLook + "\", "
        
        # lock description... they're all null so we just slide over.
        swp = swp + "lock : \"\" } ], "
        
        # side this door is on
        swp = swp + "side : \"" + dSide + "\" "

        # end of one side
        swp = swp + "}, "
        
        # ----------------------------------------------------------------------
        # RIGHT DOOR
        # ----------------------------------------------------------------------
        
        dUid  = uidFrom(door["rooms"]["right"]["index"])
        dName = door["desc"]["name"]["leftToRight"]

        dLook = ""
        if ("look" in door["desc"]):
            dLook = door["desc"]["look"]["leftToRight"]
            if dLook == None:
                dLook = ""

        dSide = sideUidFrom(door["rooms"]["right"]["side"])
        
        # prefix still
        swp = swp + "{ uid : \"right\", "
        
        # index
        swp = swp + "room : \"" + dUid + "\", "
        
        # description fold
        swp = swp + "description : [ { "
        
        # name
        swp = swp + "name : \"" + dName + "\", "
        
        # look description
        swp = swp + "look : \"" + dLook + "\", "
        
        # lock description... they're all null so we just slide over.
        swp = swp + "lock : \"\" } ], "
        
        # side this door is on
        swp = swp + "side : \"" + dSide + "\" "

        # end of other side... and the whole shebang.
        swp = swp + "} ] }]"
        
        # stack to the print
        out = nextLine(out, swp)
        out = nextLine(out, "")
        
        # add to our ender
        final = final + out

    print(final)

if __name__ == "__main__":
    main()