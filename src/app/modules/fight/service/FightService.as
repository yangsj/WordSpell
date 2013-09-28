package app.modules.fight.service
{
	import app.core.Tips;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.FightModel;
	
	import ff.client_cmd_e;
	import ff.end_round_ret_t;
	import ff.input_req_t;
	import ff.next_word_t;
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
		
		public function FightService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 开始关卡
			regist( server_cmd_e.START_ROUND_RET, startRoundNotify, start_round_ret_t );
			// 关卡结束
			regist( server_cmd_e.END_ROUND_RET, endRoundNotify, end_round_ret_t );
			// 下一个单词
			regist( server_cmd_e.NEXT_WORD_RET, nextWordNotify, next_word_t );
		}
		
		// 开始
		private function startRoundNotify( resp:SocketResp ):void
		{
			var data:start_round_ret_t = resp.data as start_round_ret_t;
			
			
			// 
			dispatch( new FightEvent( FightEvent.NOTIFY_START_ROUND ));
		}
		
		// 结束
		private function endRoundNotify( resp:SocketResp ):void
		{
			var data:end_round_ret_t = resp.data as end_round_ret_t;
			
			// 
			dispatch( new FightEvent( FightEvent.NOTIFY_END_ROUND ));
		}
		
		// 下一个单词
		private function nextWordNotify( resp:SocketResp ):void
		{
			var data:next_word_t = resp.data as next_word_t;
			
			//
			dispatch( new FightEvent( FightEvent.NOTIFY_NEXT_WORD ));
		}
		
		////////////// request ///////////
		
		/**
		 * 开始战斗
		 * @param roundLevel 世界地图的类型
		 * @param roundType 0-9 哪一组
		 * @param destUid 对手的uid，只在对战时有效
		 */
		public function startRound(mapId:int, chapterId:int, roundId:int = 0):void
		{
			var req:start_round_req_t = new start_round_req_t();
			req.round_type = mapId;
			req.round_group_id = chapterId;
			req.round_id = roundId;
			call( client_cmd_e.START_ROUND_REQ, req );
		}
		
		public function inputOver( sequence:Array ):void
		{
//			var req:input_req_t = new input_req_t();
//			req.input = sequence;
//			call( client_cmd_e.INPUT_REQ, req );
			
			// test data
			if ( sequence.join(",") == fightModel.sequence )
				Tips.showCenter( "恭喜您！答对了。" );
			else Tips.showCenter( "答错了！继续加油哦。" );
			var test:Array = [ [ "第一", "first" ], [ "第二", "second" ], [ "第三", "third" ], [ "第四", "fourth" ], ["第五", "fifth"], ["第六", "sixth"], ["第七", "seventh"], ["第八", "eighth"], ["第九", "ninth"], ["第十", "tenth"] ];
			var ary:Array = test[ int(Math.random() * 10) ];
			fightModel.spellVo = fightModel.testData( ary[0], ary[1] );
			dispatch( new FightEvent( FightEvent.NOTIFY_NEXT_WORD ));
		}
		
	}
}