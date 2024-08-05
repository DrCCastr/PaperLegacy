package;

import openfl.Assets;

class Paths {
    public static function exist(file:String):Bool {
        return Assets.exists(file);
    }

    public static function path(file:String):String {
        var finalPath = 'assets/' + file;

        var curModPath = modPath(file);
        if (curModPath != '') {
            finalPath = curModPath;
        }

        return finalPath;
    }

    public static function modPath(file:String):String {
        var modsList:Xml = Xml.parse('assets/mods/list.xml');
        var finalPath = '';

        for (modXml in modsList.elementsNamed('Mod')) {
            var mod = modXml.get('Name');

            var curModPath = 'assets/mods/' + mod + '/' + file;
            if (Assets.exists(curModPath)) {
                finalPath = curModPath;
                break;
            }
        }

        return finalPath;
    }

    public static function audio(file:String, subFolder:String):String {
        var audioPath = path('audio/' + subFolder + '/' + file + '.ogg');
        return audioPath;
    }

    public static function image(file:String):String {
        return path('images/' + file + '.png');
    }

    public static function imageData(file:String):Xml {
        return readData(file, '.xml', 'images');
    }

    public static function data(file:String, ext:String = '.xml', subFolder:String='data'):String {
        return path(subFolder + '/' + file + ext);
    }

    public static function readData(file:String, ext:String = '.xml', subFolder:String = 'data'):Dynamic {
        var data = Assets.getText(path(subFolder + '/' + file + ext));

        if (ext == '.xml')
            return Xml.parse(data);
        else 
            return data;
    }
}
