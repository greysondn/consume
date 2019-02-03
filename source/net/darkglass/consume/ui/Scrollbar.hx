package net.darkglass.consume.ui;

import flash.geom.Rectangle;

import flixel.addons.ui.FlxUI9SliceSprite;
import flixel.addons.ui.FlxUIGroup;
import flixel.addons.ui.FlxUISpriteButton;

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
    public var curScroll:Float;

    public var onScroll:Float->Void;

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
        var handle:FlxUIDraggableSpriteButton = new FlxUIDraggableSpriteButton(0, 64, true, false);
        handle.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_handle.png");
        this.add(handle);

        // down
        var downButton:FlxUISpriteButton = new FlxUISpriteButton(0, (length - 64), null, this.onClick_down);
        downButton.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_down.png", false);
        this.add(downButton);

        // bottom
        var bottomButton:FlxUISpriteButton = new FlxUISpriteButton(0, (length - 32), null, this.onClick_bottom);
        bottomButton.loadGraphicsUpOverDown("assets/images/gui/classic/scrollbar/button_bottom.png", false);
        this.add(bottomButton);
    }

    private function onClick_top():Void
    {
        // pass
    }

    private function onClick_up():Void
    {
        // pass
    }

    private function onClick_down():Void
    {
        // pass
    }

    private function onClick_bottom():Void
    {
        // pass
    }
}