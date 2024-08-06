package objects;

import Paths;
import Xml;
import flixel.FlxG;
import flixel.FlxObject;
import flixel.FlxSprite;
import flixel.util.FlxTimer;

class Entitie extends FlxObject
{
    var BodyParts:Array<BodyPart> = [];
    var Animations:Array<Animation> = [];
    var currentAnimation:Animation;
    var animationTimer:FlxTimer;
    var currentFrameIndex:Int = 0;
    var animationElapsed:Float = 0;

    public function new(data:Xml)
    {
        super();
        for (part in data.elementsNamed('BodyPart'))
        {
            BodyParts.push(new BodyPart(part));
        }
        for (animation in data.elementsNamed('Animation'))
        {
            Animations.push(new Animation(animation));
        }
        animationTimer = new FlxTimer();
    }

    public function playAnim(animName:String):Void
    {
        for (animation in Animations)
        {
            if (animation.name == animName)
            {
                if (currentAnimation != animation)
                {
                    currentAnimation = animation;
                    currentFrameIndex = 0;
                    animationElapsed = 0;
                    updateBodyPartsPosition(); 
                }
                return;
            }
        }
        trace('Unknown animation: ' + animName);
    }

    override public function update(elapsed:Float):Void
    {
        super.update(elapsed);

        if (currentAnimation != null)
        {
            animationElapsed += elapsed;
            var frame = currentAnimation.frames[currentFrameIndex];
            if (animationElapsed >= frame.duration)
            {
                animationElapsed -= frame.duration;
                currentFrameIndex = (currentFrameIndex + 1) % currentAnimation.frames.length;
                updateBodyPartsPosition();
            }
        }
    }

    private function updateBodyPartsPosition():Void
    {
        if (currentAnimation == null) return;

        var frame = currentAnimation.frames[currentFrameIndex];
        for (event in frame.events)
        {
            if (event.type == "MovePart")
            {
                var partName = event.getProp("Part");
                var part = getBodyPartByName(partName);
                if (part != null)
                {
                    var x = Std.parseFloat(event.getProp("x")) + this.x;
                    var y = Std.parseFloat(event.getProp("y")) + this.y;
                    var angle = Std.parseFloat(event.getProp("angle"));
                    part.Sprite.setPosition(x, y);
                    part.Sprite.angle = angle;
                }
            }
        }
    }

    private function getBodyPartByName(name:String):BodyPart
    {
        for (part in BodyParts)
        {
            if (part.Name == name)
            {
                return part;
            }
        }
        return null;
    }

    override public function destroy():Void
    {
        super.destroy();
        for (part in BodyParts)
        {
            FlxG.state.remove(part.Sprite);
            part.Sprite.destroy();
        }
    }
}

private class BodyPart
{
    public var Graphic:String;
    public var Name:String;
    public var Sprite:FlxSprite;

    public function new(Part:Xml)
    {
        Graphic = Part.get('graphic');
        Name = Part.get('name');
        Sprite = new FlxSprite().loadGraphic(Paths.image('entities/' + Graphic));
        FlxG.state.add(Sprite);
    }
}

private class Animation
{
    public var name:String;
    public var frames:Array<Frame> = [];

    public function new(Animation:Xml)
    {
        name = Animation.get('name');
        for (frame in Animation.elementsNamed('Frame'))
        {
            frames.push(new Frame(frame));
        }
    }
}

private class Frame
{
    public var duration:Float;
    public var events:Array<FrameEvent> = [];

    public function new(frame:Xml)
    {
        duration = Std.parseFloat(frame.get('duration'));
        for (frameEvent in frame.elementsNamed('FrameEvent'))
        {
            events.push(new FrameEvent(frameEvent));
        }
    }
}

private class FrameEvent
{
    public var type:String;
    public var props:Array<Prop> = [];

    public function new(frameEvent:Xml)
    {
        type = frameEvent.get('type');
        for (prop in frameEvent.elementsNamed('Prop'))
        {
            props.push(new Prop(prop));
        }
    }

    public function getProp(name:String):String
    {
        for (prop in props)
        {
            if (prop.name == name)
            {
                return prop.value;
            }
        }
        return "";
    }
}

private class Prop
{
    public var name:String;
    public var value:String;

    public function new(prop:Xml)
    {
        name = prop.get('name');
        value = prop.get('value');
    }
}
