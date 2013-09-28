package app.modules.fight.model
{
	import app.modules.fight.view.spell.SpellVo;
	
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightModel extends Actor
	{
		private var _spellVo:SpellVo;
		
		public function FightModel()
		{
			super();
		}
		
		public function testData( chinese:String, english:String ):SpellVo
		{
			var temp:SpellVo = new SpellVo();
			temp.chinese = chinese;
			temp.english = english;
			var list:Vector.<LetterBubbleVo> = new Vector.<LetterBubbleVo>();
			var array:Array = english.split("");
			for (var i:int = 0; i < array.length; i++ )
			{
				var vo:LetterBubbleVo = new LetterBubbleVo();
				vo.id = i;
				vo.letter = array[ i ];
				list.push( vo );
			}
			temp.items = list;
			return temp;
		}
		
		public function get spellVo():SpellVo
		{
			if ( _spellVo == null )
			{
				_spellVo = testData( "幸运", "luckiness" );
			}
			return _spellVo;
		}

		public function set spellVo(value:SpellVo):void
		{
			_spellVo = value;
		}
		
		public function get sequence():String
		{
			var temp:Array = [];
			for each (var vo:LetterBubbleVo in _spellVo.items )
			{
				temp.push( vo.id );
			}
			return temp.join(",");
		}

	}
}