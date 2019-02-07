package net.darkglass.consume.ui;

import flixel.math.FlxMath;

import flixel.addons.ui.FlxUIText;

class WaTTY extends FlxUIText
{
    /**
     * the textbuffer to draw from
     */
    public var textBuffer:Array<String> = [];

    /**
     * the actual, factual, full log
     */
     public var textLog:Array<String> = [];

    /**
     * width this can be, in characters
     */
    public var charWidth:Int = 80;

    /**
     * height this can be, in characters
     */
    public var charHeight:Int = 80;

    /**
     * line count in buffer
     */
    public var lineCount:Int = 1;

    /**
     * current line in buffer
     */
    public var currentLine:Int = 0;

    /**
     * when the length is changed, has percent
     */
    public var onLengthChange:Float->Void;

    /**
     * This entire thing, I guess.
     * 
     * @param x         x coordinate of top left corner
     * @param y         y coordinate of top left corner
     * @param width     width of text field area. I don't think this works.
     */
    public function new(x:Float = 0, y:Float = 0, width:Float = 0)
    {
        super(x, y, width, null, null, true);

        // append some empty lines
        // just as a sort of rule of thumb exercise
        for (i in 1...81)
        {
            this.textBuffer.push("");
        }
    }

    /**
     * Adds text to this thing's buffer and scrolls to it.
     * 
     * @param txt text to add.
     */
    public function addText(txt:String):Void
    {
        // we can break on newlines for what we're dealing with.
        var lines:Array<String> = txt.split("\n");

        for (line in lines)
        {
            // now the hard part, split on space
            var words:Array<String> = line.split(" ");

            var oldLn:String = "";
            var newLn:String = "";

            var firstLine:Bool = true;

            for (word in words)
            {
                // try to assemble new line
                if (firstLine)
                {
                    newLn = word;
                    firstLine = false;
                }
                else
                {
                    newLn = oldLn + " " + word;
                }
                
                // see if it's longer than limit
                if (newLn.length > charWidth)
                {
                    // longer than limit
                    this.textBuffer.push(oldLn);
                    this.textLog.push(oldLn);

                    // create new oldLn
                    oldLn = word;
                }
                else
                {
                    // not longer than limit
                    oldLn = newLn;
                }
            }

            // at the end we need to push so we don't lose the last few lines
            this.textBuffer.push(oldLn);
        }

        // we can now set max line because it's more
        this.lineCount = textBuffer.length;

        // scroll to furthest point down now
        this.scrollToPercent(100);

        // our length changed
        if (this.onLengthChange != null)
        {
            this.onLengthChange(100);
        }
    }

    public function scrollToLine(ln:Int):Void
    {
        // make sure that's in range
        ln = this.clampLineNumber(ln);

        // clear display
        this.text = "";

        // calc start end
        var txtStart:Int = this.clampLineNumber(ln - this.charHeight);
        var txtEnd:Int   = ln;

        // var for eventual display text
        var endText:String = "";

        // assemble endtext
        for (index in txtStart...(txtEnd + 1))
        {
            endText = endText + this.textBuffer[index] + "\n";
        }

        // set endtext up proper
        this.text = endText;
    }

    public function scrollToPercent(val:Float):Void
    {
        this.scrollToLine(this.percentToLine(val));
    }

    private function percentToLine(val:Float):Int
    {
        return Std.int(FlxMath.roundDecimal(FlxMath.remapToRange(val, 0, 100, 80, this.lineCount), 0));
    }

    private function lineToPercent(val:Float):Float
    {
        return FlxMath.remapToRange(val, 80, this.lineCount, 0, 100);
    }

    private function clampLineNumber(ln:Int):Int
    {
        var ret:Int = ln;

        if (ret < this.charHeight)
        {
            ret = this.charHeight;
        }
        if (ret > (this.lineCount - 1))
        {
            ret = (this.lineCount -1);
        }

        return ret;
    }
}