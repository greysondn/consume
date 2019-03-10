package net.darkglass.iguttae.gameworld.actor;

/**
 * Gives us a stable comparable for what type of container something is/goes
 * into.
 */
enum ContainerType
{
    /**
     * Rooms are like you'd expect.. and also generic spaces one can be in.
     */
    ROOM;

    /**
     * Stomaches can handle edibles. You never know just how much.
     */
    STOMACH;

    /**
     * Storage is purely for items. Nothing more.
     */
    STORAGE;
}