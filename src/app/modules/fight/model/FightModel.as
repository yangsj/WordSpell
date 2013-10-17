package app.modules.fight.model
{
	import flash.utils.Dictionary;
	
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
		private var _spellList:Vector.<SpellVo>;
		private var _modeType:int;
		private var _fightEndVo:FightEndVo;
		private var _dictPropPos:Dictionary;
		private var _currentIndex:int = 0;
		private var _allLetterList:Vector.<LetterBubbleVo>;
		
		public function FightModel()
		{
			super();
		}
		
		public function get spellVo():SpellVo
		{
			return _spellVo;
		}

		public function set spellVo(value:SpellVo):void
		{
			_spellVo = value;
		}

		/**
		 * 单词信息列表
		 */
		public function get spellList():Vector.<SpellVo>
		{
			return _spellList;
		}

		/**
		 * @private
		 */
		public function set spellList(value:Vector.<SpellVo>):void
		{
			_spellList = value;
		}

		/**
		 * 选择的模式 ( 模式 1简单、2进阶、3达人 )
		 */
		public function get modeType():int
		{
			return _modeType;
		}

		/**
		 * @private
		 */
		public function set modeType(value:int):void
		{
			_modeType = value;
		}
		
		/**
		 * 是否完成所有单词
		 */
		public function get isFinish():Boolean
		{
			return _spellList == null || _spellList.length == 0;
		}

		/**
		 * 关卡结束数据
		 */
		public function get fightEndVo():FightEndVo
		{
			return _fightEndVo;
		}

		/**
		 * @private
		 */
		public function set fightEndVo(value:FightEndVo):void
		{
			_fightEndVo = value;
		}
		
		public function get currentIndex():int
		{
			return _currentIndex;
		}
		
		public function set currentIndex(value:int):void
		{
			_currentIndex = value;
		}

		public function get dictPropPos():Dictionary
		{
			return _dictPropPos;
		}

		public function set dictPropPos(value:Dictionary):void
		{
			_dictPropPos = value;
		}

		/**
		 * 所有字母泡泡信息
		 */
		public function get allLetterList():Vector.<LetterBubbleVo>
		{
			return _allLetterList;
		}

		/**
		 * @private
		 */
		public function set allLetterList(value:Vector.<LetterBubbleVo>):void
		{
			_allLetterList = value;
		}


	}
}