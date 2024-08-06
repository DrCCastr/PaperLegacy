package states.stages;

import entities.Player;
import flixel.FlxObject;
import flixel.FlxState;
import objects.SubState;

class World extends SubState
{
    var Player:FlxObject;

    public function new(parentState:FlxState) {
        super(parentState);
    }

    public override function onEnter() {
        super.onEnter();
        Player = new Player();
    }

    public override function onExit() {
        super.onExit();
        remove(Player);
    }

    public override function update(elapsed:Float) {
        super.update(elapsed);
    }
}