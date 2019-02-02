package net.darkglass.consume.ui;

import flixel.addons.ui.FlxUISprite;
import flixel.FlxG;
import flixel.input.mouse.FlxMouseEventManager;
import flixel.math.FlxPoint;

/**
 * An FlxUISprite with mouse draggability. Was prerequisite to design a basic
 * scrollbar.
 */
class FlxUIDraggableSprite extends FlxUISprite
{
    /**
     * Whether this can be dragged vertically
     */
    public var dragVertical:Bool = true;

    /**
     * Whether this can be dragged horizontally
     */
    public var dragHorizontal:Bool = true;

    /**
     * Var that keeps track of whether or not we're dragging this right now.
     */
    private var dragging:Bool = false;

    /**
     * Var that keeps track of last mouse position so that the drag feels
     * fairly intuitive instead of clunky.
     */
    private var lastMousePos:FlxPoint = new FlxPoint(0, 0);

    /**
     * Create a new FlxUIDraggableSprite
     * 
     * @param X             x pos of top left corner
     * @param Y             y pos of top left corner
     * @param vertical      whether or not we can drag this vertically
     * @param horizontal    whether or not we can drag this horizontally
     * @param SimpleGraphic a simple graphic to use as this sprite's graphic
     */
    public function new(X:Float=0,Y:Float=0,vertical:Bool=true, horizontal:Bool=true,SimpleGraphic:Dynamic=null) 
    {
        // super constructor
        super(X, Y, SimpleGraphic);

        // set the two thingies.
        this.dragHorizontal = horizontal;
        this.dragVertical   = vertical;

        // add mouse event manager event to read click in bounds
        FlxMouseEventManager.add(this, this.onClick)
    }

    override public function update(elapsed:Float):Void
    {
        this.doDrag();
        super.update(elapsed);
    }

    public function doDrag():Void
    {
        // make sure we're still dragging
        if (FlxG.mouse.justReleased)
        {
            // reset all the data
            this.dragging = false;
            this.lastMousePos.x = 0;
            this.lastMousePos.y = 0;
        }

        // update position based on mouse
        if (this.dragging)
        {
            if (this.dragHorizontal)
            {
                this.x = this.x + (FlxG.mouse.x - this.lastMousePos.x);
            }
            
            if (this.dragVertical)
            {
                this.y = this.y + (FlxG.mouse.y - this.lastMousePos.y);
            }

            // update last mouse position
            this.lastMousePos.x = FlxG.mouse.x;
            this.lastMousePos.y = FlxG.mouse.y;
        }
    }

    private function onClick(object:FlxUIDraggableSprite):Void
    {
        this.dragging = true;
        this.lastMousePos.x = FlxG.mouse.x;
        this.lastMousePos.y = FlxG.mouse.y;
    }
}