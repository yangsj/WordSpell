package app.modules.fight.service
{
	import ff.client_cmd_e;
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
		public function FightService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 开始关卡
			regist( server_cmd_e.START_ROUND_RET, startRoundNotify, start_round_ret_t );
			//
		}
		
		private function startRoundNotify( resp:SocketResp ):void
		{
			var data:start_round_ret_t = resp.data as start_round_ret_t;
		}
		
		////////////// request ///////////
		
		/**
		 * 开始战斗
		 * @param roundLevel 闯关级别 
		 * @param roundType 闯关类型，简单、进阶、达人分别为0,1,2, 3表示约战
		 * @param destUid 对手的uid，只在对战时有效
		 */
		public function startRound(roundLevel:int, roundType:int, destUid:int = 0):void
		{
			var req:start_round_req_t = new start_round_req_t();
			req.level = roundLevel;
			req.mode = roundType;
			req.dest_uid = destUid;
			call( client_cmd_e.START_ROUND_REQ, req );
		}
		
	}
}