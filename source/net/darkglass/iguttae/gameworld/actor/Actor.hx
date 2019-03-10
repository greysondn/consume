package net.darkglass.iguttae.gameworld.actor;

import net.darkglass.iguttae.gameworld.actor.Compass;
import net.darkglass.iguttae.gameworld.actor.ContainerType;
import net.darkglass.iguttae.gameworld.actor.Permission;
import net.darkglass.iguttae.gameworld.map.Transition;

/**
 * Parent for interactibles ingame. Not really meant to be called itself.
 */
class Actor
{
    /**
     * The types of containables this can contain.
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    private var containerFor:Array<ContainerType> = [];
    
    /**
     * The types of containers this is containable in
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    private var containableIn:Array<ContainerType> = [];

    /**
     * The permissions associated with this actor.
     * 
     * Don't meddle with this directly! There are functions written to interact
     * with this.
     */
    private var permissions:Array<Permission> = [];

    /**
     * Exits from this, as in a room, typically, but could be anything. A
     * container even.
     */
    public var exits:Map<Compass, Transition>;
    
    /**
     * Constructor
     */
    public function new()
    {
        // pass for now
    }
    
    /**
     * Check whether this is a valid container for cType.
     *
     * @param cType type we wonder if this is a container for
     * @return Bool whether it's a container for cType
     */
    public function isContainerFor(cType:ContainerType):Bool
    {
        return (-1 != this.containerFor.indexOf(cType));
    }
    
    /**
     * Makes this now be a container for cType if it wasn't already
     * 
     * @param cType container type
     */
    public function addContainerFor(cType:ContainerType):Void
    {
        // only add it if it's not already there
        if (-1 == this.containerFor.indexOf(cType))
        {
            this.containerFor.push(cType);
        }
    }

    /**
     * Makes this now not be a container for cType if it was before
     * 
     * @param cType container type
     */
    public function removeContainerFor(cType:ContainerType):Void
    {
        this.containerFor.remove(cType);
    }

    /**
     * Check whether this is containable in cType.
     *
     * @param cType type of container we wonder if this can go into
     * @return Bool whether it's containable in cType
     */
    public function isContainableIn(cType:ContainerType):Bool
    {
        return (-1 != this.containableIn.indexOf(cType))
    }
    
    /**
     * Makes this now be containable in cType if it wasn't already
     * 
     * @param cType container type
     */
    public function addContainableIn(cType:ContainerType):Void
    {
        // only add it if it's not already there
        if (-1 == this.containableIn.indexOf(cType))
        {
            this.containableIn.push(cType);
        }
    }
    
    /**
     * Makes this not be containable in cType if it was before
     * 
     * @param cType container type
     */
    public function removeContainableIn(cType:ContainerType):Void
    {
        this.containableIn.remove(cType);
    }

    /**
     * Check if this actor has a certain permission
     * 
     * @param permission 
     * @return Bool
     */
    public function hasPermission(permission:Permission):Bool
    {
        return (-1 != this.permissions.indexOf(permission));
    }

    /**
     * Add a permission to this actor if it isn't present already.
     * 
     * @param permission 
     */
    public function addPermission(permission:Permission):Void
    {
        // only add it if it's not already there
        if (-1 == this.permissions.indexOf(permission))
        {
            this.permissions.push(permission);
        }
    }

    /**
     * Remove a permission from this actor, if it's present.
     * 
     * @param permission 
     */
    public function removePermission(permission:Permission):Void
    {
        this.permissions.remove(permission);
    }
}