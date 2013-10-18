package app.modules.fight.service
{
	import flash.utils.Dictionary;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.FightEndVo;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.spell.SpellVo;
	import app.modules.map.model.MapModel;
	import app.modules.map.model.RoundVo;
	
	import ff.bubble_info_t;
	import ff.client_cmd_e;
	import ff.end_round_ret_t;
	import ff.input_req_t;
	import ff.next_word_t;
	import ff.select_item_bubble_req_t;
	import ff.server_cmd_e;
	import ff.start_round_req_t;
	import ff.start_round_ret_t;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-24
	 */
	public class FightService extends BaseService
	{
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var mapModel:MapModel;

		public function FightService()
		{
			super();
		}

		override protected function initRegist():void
		{
			// 闯关练习开始关卡
			regist( server_cmd_e.START_ROUND_RET, startRoundNotify, start_round_ret_t );
			// 关卡结束
			regist( server_cmd_e.END_ROUND_RET, endRoundNotify, end_round_ret_t );
			// 闯关练习下一个单词
			regist( server_cmd_e.NEXT_WORD_RET, nextWordNotify, next_word_t );
		}

		// 闯关练习开始
		private function startRoundNotify( resp:SocketResp ):void
		{
			var data:start_round_ret_t = resp.data as start_round_ret_t;
			var cnAry:Array = data.chinese_words;
			var blanks:Array = data.blank;
			var bubbles:Array = data.bubble_info;
			var length:int = cnAry.length;
			var spellList:Vector.<SpellVo> = new Vector.<SpellVo>( length );
			var spellVo:SpellVo;
			var info:bubble_info_t;
			var order:int;
			var index:int;
			var tempBub:Array;
			var listBub:Vector.<LetterBubbleVo>;
			var str:String = "";
			var letterBubbleVo:LetterBubbleVo;
			var allLetterList:Vector.<LetterBubbleVo> = new Vector.<LetterBubbleVo>();
			for ( var i:int = 0; i < length; i++ )
			{
				index = int( blanks[ i ]);
				tempBub = bubbles.splice( 0, index );
				listBub = new Vector.<LetterBubbleVo>();
				str = "";
				order = 0;
				for each ( info in tempBub )
				{
					letterBubbleVo = new LetterBubbleVo();
					letterBubbleVo.index = order;
					letterBubbleVo.id = info.bubble_id;
					letterBubbleVo.letter = info.word;
					letterBubbleVo.itemType = info.item_type;
					listBub.push( letterBubbleVo );
					str += letterBubbleVo.letter;
					order++;
					
					allLetterList.push( letterBubbleVo );
				}
				spellVo = new SpellVo();
				spellVo.chinese = cnAry[ i ];
				spellVo.items = listBub;
				spellList[ i ] = spellVo;
				trace( spellVo.chinese, str );
			}
			
			var dict:Dictionary = new Dictionary();
			for ( var key:* in data.bubble_item )
			{
				var ary:Array = data.bubble_item[key];
				var temp:Array = [];
				order = 0;
				for each ( info in ary )
				{
					letterBubbleVo = new LetterBubbleVo();
					letterBubbleVo.index = order;
					letterBubbleVo.id = info.bubble_id;
					letterBubbleVo.letter = info.word;
					letterBubbleVo.itemType = info.item_type;
					temp.push( letterBubbleVo );
					order++;
				}
				dict[ key ] = temp;
			}
			fightModel.dictPropPos = dict;
			fightModel.allLetterList = allLetterList;
			fightModel.spellList = spellList;
			fightModel.modeType = data.mode;

			// 设置第一个单词信息
			updateLetterInfoList();
			// 
			fightModel.currentIndex = 0;

			// 
			dispatch( new FightEvent( FightEvent.NOTIFY_START_ROUND ));
		}

		// 结束
		private function endRoundNotify( resp:SocketResp ):void
		{
			var data:end_round_ret_t = resp.data as end_round_ret_t;
			var endVo:FightEndVo = fightModel.fightEndVo || new FightEndVo();
			endVo.addExp = data.inc_exp;
			endVo.addMoney = data.inc_coin;
			endVo.currentLevel = data.cur_level;
			endVo.isWin = data.win;
			endVo.rightNum = data.right_num;
			endVo.wrongList = data.wrong_words;
			fightModel.fightEndVo = endVo;
			
			//更新等级
			if ( endVo.currentLevel != GameData.instance.selfVo.level )
				GameData.instance.updateLevel( endVo.currentLevel );
			
			//更新经验值
			if ( endVo.addExp > 0 )
				GameData.instance.updateAddExp( endVo.addExp );
			// 
			dispatch( new FightEvent( FightEvent.NOTIFY_END_ROUND ));
		}

		// 下一个单词
		private function nextWordNotify( resp:SocketResp ):void
		{
			var data:next_word_t = resp.data as next_word_t;

			if ( data.answer_flag )
				Tips.showCenter( "恭喜您！答对了。" );
			else
				Tips.showCenter( "答错了！骚年，继续加油。" );

			if ( data.inc_coin > 0 )
				GameData.instance.updateAddMoney( data.inc_coin );

			// 设置下一个单词信息
			if ( fightModel.isFinish == false )
			{
				fightModel.currentIndex++;
				updateLetterInfoList();
				//
				dispatch( new FightEvent( FightEvent.NOTIFY_NEXT_WORD ));
			}
		}
		
		private function updateLetterInfoList():void
		{
			fightModel.spellVo = fightModel.spellList.shift();
			fightModel.allLetterList.splice(0, fightModel.spellVo.charsLength );
		}

		////////////// request ///////////

		/**
		 * 开始战斗 [type: 0 表示普通闯关，1表示练习这一关, 2 表示进行下一关]
		 * @param roundLevel 世界地图的类型
		 * @param roundType 0-9 哪一组
		 * @param destUid 对手的uid，只在对战时有效
		 */
		public function startRound( type:int = 0 ):void
		{
			var roundVo:RoundVo = mapModel.currentRoundVo;
			var req:start_round_req_t = new start_round_req_t();
			req.round_type = roundVo.mapId;
			req.round_group_id = roundVo.chapterId;
			req.round_id = roundVo.roundId;
			req.mode = type;
			call( client_cmd_e.START_ROUND_REQ, req );
		}

		public function inputOver( sequence:Array ):void
		{
			var req:input_req_t = new input_req_t();
			req.input = sequence;
			call( client_cmd_e.INPUT_REQ, req );
		}

		/**
		 * 点击到道具
		 * @param id
		 */
		public function inputProp( id:int ):void
		{
			var req:select_item_bubble_req_t = new select_item_bubble_req_t();
			req.bubble_id = id;
			call( client_cmd_e.SELECT_ITEM_BUBBLE_REQ , req );
		}

	}
}
