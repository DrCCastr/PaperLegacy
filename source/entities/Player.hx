package entities;

import objects.Entitie;

class Player extends Entitie
{
	public function new()
	{
		super(Xml.parse(Paths.data('player')));
		playAnim('idle');
    }
}