package net.darkglass.consume.ui;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIGroup;

import net.darkglass.consume.ui.WaTTY;
import net.darkglass.consume.ui.Scrollbar;

/**
 * THIS CLASS IS BROKEN, JUST DO IT MANUALLY FOR NOW, IT'S NOT THAT HARD.
 * 
 * Wraps the WaTTY, a 9-slice background, and a scrollbar all up in one nice
 * object.
 * 
 * I am not a big fan of struggling, as you might guess.
 */
class WaTTYDisplay extends FlxUIGroup
{
    public var tty:WaTTY;
    public var scrollbar:Scrollbar;
    public var nineslice:FlxUI9SliceSprite;

    /**
     * Supposed to be a paper thin wrapper around a WaTTY matched (and wired) to
     * a scrollbar. I'm not a big fan of manually assembling this every single
     * time, sincerely.
     * 
     * @param x             top left x coordinate
     * @param y             top left y coordinate
     * @param width         width of entire thing - scrollbar and all
     * @param height        height of entire thing - scrollbar and all
     * @param scrollOffset  distance to offset scrollbar space
     */
    public function new(x:Float, y:Float, width:Float, height:Float, scrollOffset:Float)
    {
        // call parent first
        super(x, y);

        // should be nine slice first
        // pass

        // tty
        this.tty = new WaTTY(48, 48, (width - 128));
        // probably more here, too
        this.add(this.tty);

        // scrollbar can be next
        var scrollbarX:Float = width-32;  // just too long as an argument
        this.scrollbar = new Scrollbar(scrollbarX, 0, height);
        this.scrollbar.minScroll = y + 96 + scrollOffset;
        this.scrollbar.maxScroll = y + height - 64 + scrollOffset;
        // has to be more here but for now that's enough
        this.add(this.scrollbar);

        // wire it together
        this.scrollbar.onScroll = this.tty.scrollToPercent;
        this.tty.onLengthChange = this.scrollbar.updateScrollbarPosition;
    }

    /**
     * Add text to this.
     * 
     * @param txt text to add, yo.
     */
    public function addText(txt:String):Void
    {
        this.tty.addText(txt);
    }

    /**
     * Changes the main format of this WaTTY
     * 
     * @param font          font face to use
     * @param fontsize      font size to use
     * @param lineHeight    lineheight of font, in lines
     * @param charWidth     charWidth of font, in columns
     */
    public function changeFormat(font:String, fontsize:Int, lineHeight:Int, charWidth:Int):Void
    {
        tty.setFormat(font, fontsize);
        tty.charHeight = lineHeight;
        tty.charWidth  = charWidth;
    }
}