package;

import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.group.FlxGroup;
import flixel.util.FlxColor;
import objects.SubState;
import states.StartState;

class MainState extends FlxState {
    static var currentSubState:SubState;

    override public function create() {
        super.create();
        bgColor = FlxColor.WHITE;

        switchToSubState(new StartState(this));

        if (FlxG.save.isEmpty()) initData();
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);

        if (currentSubState != null) {
            currentSubState.update(elapsed);
        }
    }

    public function switchToSubState(newSubState:SubState) {
        if (currentSubState != null) {
            currentSubState.onExit();
        }

        currentSubState = newSubState;
        currentSubState.onEnter();
    }

    public function initData() {
        FlxG.save.data.antialiasing = false;
        FlxG.save.flush();
    }
}
