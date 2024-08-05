package states;

import Paths;
import flixel.FlxG;
import flixel.FlxSprite;
import flixel.FlxState;
import flixel.text.FlxText;
import flixel.tweens.FlxTween;
import flixel.util.FlxColor;
import haxe.Timer;
import objects.SubState;
import states.stages.World;

class StartState extends SubState {
    var parent:Dynamic;

    var PaperName:FlxSprite;
    var PaperNameRot:FlxTween;
    var PaperNameRotState:Int = 1;
    var PaperNameScale:FlxTween;

    var PlaceText:FlxText;

    public function new(parentState:FlxState) {
        super(parentState);
        parent = parentState;
    }

    override public function onEnter() {
        super.onEnter();
        PaperName = new FlxSprite().loadGraphic(Paths.image('PaperName'));
        PaperName.antialiasing = FlxG.save.data.antialiasing;
        PaperName.scale.set(2, 2);
        PaperName.x = (FlxG.width - PaperName.width) / 2;
        PaperName.y = (FlxG.height - PaperName.height) / 4;
        PaperNameRot = FlxTween.tween(PaperName, {angle: 15 * PaperNameRotState}, 0.5).start();
        add(PaperName);

        PlaceText = new FlxText(0, FlxG.height - 350, FlxG.width, 'Press enter to play');
        PlaceText.setFormat(null, 200, FlxColor.BLACK, "center");
        FlxTween.tween(PlaceText, {angle: 5 * PaperNameRotState}, 0.5).start();
        add(PlaceText);
    }

    override public function onExit() {
        super.onExit();
        remove(PaperName);
        remove(PlaceText);
    }

    override public function update(elapsed:Float) {
        super.update(elapsed);
        handleTween(elapsed);
        handleInput(elapsed);
    }

    private function handleInput(elapsed:Float) {
        var justPress = FlxG.keys.justPressed;
        if (justPress.ENTER) {
            parent.switchToSubState(new World(parent));
        }
    }

    private function handleTween(elapsed:Float) {
        
        if (PaperNameRot.finished) {
            PaperNameRotState *= -1;
            PaperNameRot = FlxTween.tween(PaperName, {angle: 15 * PaperNameRotState}, 0.5).start();
            FlxTween.tween(PlaceText, {angle: 5 * PaperNameRotState}, 0.5).start();
            PaperNameScale = FlxTween.tween(PaperName, {'scale.x': 2.5, 'scale.y': 2.5}, 0.1).start();
            Timer.delay(function () {
                PaperNameScale = FlxTween.tween(PaperName, {'scale.x': 2, 'scale.y': 2}, 0.1).start();
            }, 100);
        }
    }
}
