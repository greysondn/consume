package net.darkglass.iguttae.gameworld.actor;

/**
 * Represents a valid direction in our gameworld's compass
 */
enum Compass
{
    /**
     * Compass North
     */
    NORTH;

    /**
     * Compass Northeast
     */
    NORTHEAST;

    /**
     * Compass East
     */
    EAST;

    /**
     * Compass Southeast
     */
    SOUTHEAST;

    /**
     * Compass South
     */
    SOUTH;

    /**
     * Compass Southwest
     */
    SOUTHWEST;

    /**
     * Compass West
     */
    WEST;

    /**
     * Compass Northwest
     */
    NORTHWEST;

    /**
     * Up, as in "closer to the sky"
     */
    UP;
    
    /**
     * Down, as in "further from the sky"
     */
    DOWN;

    /**
     * In, as in "towards the inside of something"
     */
    IN;

    /**
     * Out, as in "towards the outside of something"
     */
    OUT;
}