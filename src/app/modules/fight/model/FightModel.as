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
		private var _spellCopyVo:SpellVo;
		private var _spellList:Vector.<SpellVo>;
		private var _spellListCopy:Vector.<SpellVo>;
		private var _modeType:int;
		private var _fightEndVo:FightEndVo;
		private var _dictPropPos:Dictionary;
		private var _currentSelfIndex:int = 0;
		private var _currentDestIndex:int = 0;
		private var _allLetterList:Vector.<LetterBubbleVo>;
		private var _allLetterListCopy:Vector.<LetterBubbleVo>;
		private var _battleEndSelfVo:FightEndVo;
		private var _battleEndDestVo:FightEndVo;
		private var _battleResult:Boolean = false;
		private var _battleResultFlag:int;
		private var _mapId:int = 0;
		private var _roundId:int = 0;
		private var _isFighting:Boolean;
		private var _isSelfExit:Boolean;
		private var _isErrorLastAnswerForPractice:Boolean = false;
		private var _isShowAnswer:Boolean = false;
		
		public function FightModel()
		{
			super();
		}
		
		public function updateSelfWordList():void
		{
			_spellVo = spellList.shift();
			allLetterList.splice(0, _spellVo.charsLength );
		}
		
		public function updateDestWordList():void
		{
			_spellCopyVo = spellListCopy.shift();
			allLetterListCopy.splice(0, _spellCopyVo.charsLength );
		}
		
		public function get spellVo():SpellVo
		{
			return _spellVo;
		}

		public function get spellCopyVo():SpellVo
		{
			return _spellCopyVo;
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
		 * 选择的模式 ( 模式 1简单、2进阶、3达人、4练习、5对战、6错误练习 )
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
		
		public function get currentSelfIndex():int
		{
			return _currentSelfIndex;
		}
		
		public function set currentSelfIndex(value:int):void
		{
			_currentSelfIndex = value;
		}
		
		public function get currentDestIndex():int
		{
			return _currentDestIndex;
		}
		
		public function set currentDestIndex(value:int):void
		{
			_currentDestIndex = value;
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

		/**
		 * 单词列表副本信息
		 */
		public function get spellListCopy():Vector.<SpellVo>
		{
			return _spellListCopy;
		}

		/**
		 * @private
		 */
		public function set spellListCopy(value:Vector.<SpellVo>):void
		{
			_spellListCopy = value;
		}

		public function get allLetterListCopy():Vector.<LetterBubbleVo>
		{
			return _allLetterListCopy;
		}

		public function set allLetterListCopy(value:Vector.<LetterBubbleVo>):void
		{
			_allLetterListCopy = value;
		}

		/**
		 * 对战结束玩家自己的数据
		 */
		public function get battleEndSelfVo():FightEndVo
		{
			return _battleEndSelfVo ||= new FightEndVo();
		}

		/**
		 * @private
		 */
		public function set battleEndSelfVo(value:FightEndVo):void
		{
			_battleEndSelfVo = value;
		}

		/**
		 * 对战结束对手数据
		 */
		public function get battleEndDestVo():FightEndVo
		{
			return _battleEndDestVo ||= new FightEndVo();
		}

		/**
		 * @private
		 */
		public function set battleEndDestVo(value:FightEndVo):void
		{
			_battleEndDestVo = value;
		}

		/**
		 * 对战结果
		 */
		public function get battleResult():Boolean
		{
			return _battleResult;
		}

		/**
		 * @private
		 */
		public function set battleResult(value:Boolean):void
		{
			_battleResult = value;
		}

		/**
		 * 0标识比赛正常结束|1标识对方放弃
		 */
		public function get battleResultFlag():int
		{
			return _battleResultFlag;
		}

		/**
		 * @private
		 */
		public function set battleResultFlag(value:int):void
		{
			_battleResultFlag = value;
		}

		public function get mapId():int
		{
			return _mapId;
		}

		public function set mapId(value:int):void
		{
			_mapId = Math.max( value, 0 );
		}
		
		/**
		 * 关卡id  0 - 49
		 */
		public function get roundId():int
		{
			return _roundId;
		}
		
		/**
		 * @private
		 */
		public function set roundId(value:int):void
		{
			_roundId = Math.max( 0, value );
		}

		/**
		 * 是否是闯关失败或者错误练习
		 */
		public function get isPractice():Boolean
		{
			return modeType == 4 || modeType == 6;
		}
		
		/**
		 * 是否是错误练习
		 */
		public function get isErrorPractice():Boolean
		{
			return modeType == 6;
		}

		/**
		 * 是否正在战斗中
		 */
		public function get isFighting():Boolean
		{
			return _isFighting;
		}

		/**
		 * @private
		 */
		public function set isFighting(value:Boolean):void
		{
			_isFighting = value;
		}

		/**
		 * 在练习模式下是自己主动退出的
		 */
		public function get isSelfExit():Boolean
		{
			return _isSelfExit;
		}

		/**
		 * @private
		 */
		public function set isSelfExit(value:Boolean):void
		{
			_isSelfExit = value;
		}

		/**
		 *  練習模式上一個詞是否答錯
		 */
		public function get isErrorLastAnswerForPractice():Boolean
		{
			return _isErrorLastAnswerForPractice;
		}

		/**
		 * @private
		 */
		public function set isErrorLastAnswerForPractice(value:Boolean):void
		{
			_isErrorLastAnswerForPractice = value;
		}

		/**
		 * 是否点击显示答案
		 */
		public function get isShowAnswer():Boolean
		{
			return _isShowAnswer;
		}

		/**
		 * @private
		 */
		public function set isShowAnswer(value:Boolean):void
		{
			_isShowAnswer = value;
		}


	}
}