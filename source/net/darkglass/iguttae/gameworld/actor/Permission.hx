package net.darkglass.iguttae.gameworld.actor;

/**
 * Encapsulates permissions in the game world, chiefly for rooms
 */
enum Permission
{
    /**
     * Whether or not the actor can wait.
     * 
     * For an actor to wait, two things must be true: The actor must have
     * permission to wait, and any parents of the actor must have the wait
     * permission.
     */
    WAIT;
}