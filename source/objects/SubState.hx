package objects;

import flixel.FlxG;
import flixel.FlxState;

class SubState {
    public var parentState:FlxState;

    public function new(parentState:FlxState) {
        this.parentState = parentState;
    }

    public function update(elapsed:Float) {}

    public function onEnter() {}

    public function onExit() {}

    public function add(object:Dynamic) {
        FlxG.state.add(object);
    }

    public function remove(object:Dynamic) {
        FlxG.state.remove(object);
    }
}
