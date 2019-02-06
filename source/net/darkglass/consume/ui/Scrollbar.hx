package net.darkglass.consume.ui;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUISpriteButton;

import flixel.FlxG;
import flixel.math.FlxMath;

import net.darkglass.consume.ui.FlxUIDraggableSpriteButton;

/**
 * It's just a scrollbar maaaaaaan.
 */
class Scrollbar extends FlxUIGroup
{
    /**
     * Min scroll dimension (the top)
     */
    public var minScroll:Float;

    /**
     * Max scroll dimension (the bottom)
     */
    public var maxScroll:Float;

    /**
     * Current percentage between the two
     */
    public var curScrollPercent:Float;

    /**
     * previous scroll dimension
     */
    public var prevScroll:Float;

    /**
     * takes new percentage.
     */
    public var onScroll:Float->Void;

    /**
     * handle for the user to drag
     */
    private var scrollHandle:FlxUIDraggableSpriteButton;

    /**
     * Creates a scrollbar. Only vertical ones are possible for now.
     * 
     * @param x         x coordinate of top left of scrollbar
     * @param y         y coordinate of top left of scrollbar
     * @param length    total length along dimensional direction
     */
    public function new(x:Float = 0, y:Float = 0, length:Float = 0)
    {
        super(x, y);

        // minimum size for length is 160, thanks
        if (length < 160)
        {
            length = 160;
        }

        // BG
        var background:FlxUI9SliceSprite = new FlxUI9SliceSprite(0, 0, "assets/images/gui/classic/scrollbar/background.png", new Rectangle(0, 0, 32, length), [1, 1, 2, 2]);
        this.add(background);

        // top
        var topButton:FlxUISpriteButton = new FlxUISpriteButton(0, 0, null, this.onClick_top);
        topButton.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_top.png", false);
        this.add(topButton);

        // up
        var upButton:FlxUISpriteButton = new FlxUISpriteButton(0, 32, null, this.onClick_up);
        upButton.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_up.png", false);
        this.add(upButton);

        // handle
        this.scrollHandle = new FlxUIDraggableSpriteButton(0, 64, true, false);
        this.scrollHandle.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_handle.png");
        this.add(this.scrollHandle);

        // down
        var downButton:FlxUISpriteButton = new FlxUISpriteButton(0, (length - 64), null, this.onClick_down);
        downButton.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_down.png", false);
        this.add(downButton);

        // bottom
        var bottomButton:FlxUISpriteButton = new FlxUISpriteButton(0, (length - 32), null, this.onClick_bottom);
        bottomButton.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_bottom.png", false);
        this.add(bottomButton);

        this.prevScroll = this.scrollHandle.y;
    }

    override public function update(elapsed:Float):Void
    {
        // preclamp handle
        this.clampScrollHandle();

        // run super call
        super.update(elapsed);

        // post clamp handle
        this.clampScrollHandle();

        // if scroll changed, fix it all, fix it all, fix it all
        if (this.scrollHandle.y != this.prevScroll)
        {
            if (this.onScroll != null)
            {
                this.onScroll(convertScrollToPercent(this.scrollHandle.y));
            }

            this.prevScroll = this.scrollHandle.y;
        }
    }

    /**
     * Helper fucntion to set scroll bar to position based on percentage
     * without triggering movement detection in the awful code.
     * 
     * @param newPercent new percentage to scroll window to
     */
    public function updateScrollbarPosition(newPercent:Float)
    {
        var newPos:Float = this.convertPercentToScroll(newPercent);
        this.scrollHandle.y = newPos;
        this.prevScroll = newPos;
    }

    /**
     * fires on click of top
     */
    private function onClick_top():Void
    {
        this.scrollHandle.y = this.minScroll;
    }

    /**
     * fires on click of up
     */
    private function onClick_up():Void
    {
        this.scrollHandle.y = this.scrollHandle.y - 15;
    }

    /**
     * fires on click of down
     */
    private function onClick_down():Void
    {
        this.scrollHandle.y = this.scrollHandle.y + 15;
    }

    /**
     * fires on click of bottom
     */
    private function onClick_bottom():Void
    {
        this.scrollHandle.y = this.maxScroll;
    }

    /**
     * clamps the scroll handle bounds to boundaries of where
     * it can be set
     */
    private function clampScrollHandle():Void
    {
        if (this.scrollHandle.y < this.minScroll)
        {
            this.scrollHandle.y = this.minScroll;
        }

        if (this.scrollHandle.y > this.maxScroll)
        {
            this.scrollHandle.y = this.maxScroll;
        }
    }
    
    /**
     * Takes a scroll point along the and returns the percent
     * @param val       scroll point
     * @return Float    percentage that represents
     */
    private function convertScrollToPercent(val:Float):Float
    {
        return FlxMath.remapToRange(val, this.minScroll, this.maxScroll, 0, 100);
    }

    /**
     * Takes a percent and converts it to a scroll point along the axis
     * 
     * @param val       percentage
     * @return Float    scroll point that represents
     */
    private function convertPercentToScroll(val:Float):Float
    {
        return FlxMath.remapToRange(val, 0, 100, this.minScroll, this.maxScroll);
    }
}