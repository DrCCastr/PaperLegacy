package entities;

import Paths;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;

class Player extends FlxObject 
{
    var Head:FlxSprite;
    var Torso:FlxSprite;
    var RArm:FlxSprite;
    var LArm:FlxSprite;
    var RLeg:FlxSprite;
    var LLeg:FlxSprite;

    public function new() {
        super();

        Head = new FlxSprite().loadGraphic(Paths.image('entities/player/Head'));
        Head.antialiasing = FlxG.save.data.antialiasing;
        FlxG.state.add(Head);

        Torso = new FlxSprite().loadGraphic(Paths.image('entities/player/Torso'));
        Torso.antialiasing = FlxG.save.data.antialiasing;
        FlxG.state.add(Torso);

        RArm = new FlxSprite().loadGraphic(Paths.image('entities/player/Arm'));
        RArm.antialiasing = FlxG.save.data.antialiasing;
        FlxG.state.add(RArm);

        LArm = new FlxSprite().loadGraphic(Paths.image('entities/player/Arm'));
        LArm.antialiasing = FlxG.save.data.antialiasing;
        FlxG.state.add(LArm);

        RLeg = new FlxSprite().loadGraphic(Paths.image('entities/player/Leg'));
        RLeg.antialiasing = FlxG.save.data.antialiasing;
        FlxG.state.add(RLeg);

        LLeg = new FlxSprite().loadGraphic(Paths.image('entities/player/Leg'));
        LLeg.antialiasing = FlxG.save.data.antialiasing;
        FlxG.state.add(LLeg);
    }
}
