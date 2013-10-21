package app.modules.fight.service
{
	import app.events.ViewEvent;
	import app.modules.LoadingEffect;
	import app.modules.ViewName;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightMatchingVo;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.panel.ready.FightReadyEvent;
	
	import ff.battle_close_ret_t;
	import ff.battle_create_req_t;
	import ff.battle_create_ret_t;
	import ff.battle_quit_req_t;
	import ff.battle_ready_req_t;
	import ff.client_cmd_e;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-19
	 */
	public class FightOnlineService extends BaseService
	{
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var readyModel:FightReadyModel;
		
		public function FightOnlineService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 准备通知
			regist( server_cmd_e.BATTLE_READY_RET , readyNotify, battle_ready_req_t );
			// 取消准备通知
			regist( server_cmd_e.BATTLE_CLOSE_RET, quitNotify, battle_close_ret_t );
			// 匹配成功
			regist( server_cmd_e.BATTLE_CREATE_RET, matchingSuccessNotify, battle_create_ret_t );
		}
		
//*************************** Notify *************************//
		
		// 取消准备通知
		private function quitNotify( resp:SocketResp ):void
		{
			dispatch( new FightOnlineEvent( FightOnlineEvent.QUIT_BATTLE ));
		}
		
		// 准备通知
		private function readyNotify( resp:SocketResp ):void
		{
			dispatch( new FightReadyEvent( FightReadyEvent.UPDATE ));
		}
		
		private function matchingSuccessNotify( resp:SocketResp ):void
		{
			var data:battle_create_ret_t = resp.data as battle_create_ret_t;
			var mathingVo:FightMatchingVo = readyModel.destVo;
			mathingVo.grade = data.dest_grade;
			mathingVo.level = data.dest_level;
			mathingVo.name = data.dest_name;
			mathingVo.uid = data.dest_id;
			mathingVo.gender = data.gender;
			readyModel.destVo = mathingVo;
			readyModel.result = data.result;
			if ( readyModel.isSuccessed )
			{
				dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.FightMatchingPanel ));
				dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.FightReadyPanel ));
			}
			else
			{
				
			}
		}
		
//*************************** Request *************************//
				
		/**
		 * 取消（退出）
		 */
		public function quit():void
		{
			var req:battle_quit_req_t = new battle_quit_req_t();
			call( client_cmd_e.BATTLE_QUIT_REQ, req );
			
			LoadingEffect.hide();
		}
		
		/**
		 * 准备
		 */
		public function ready():void
		{
			var req:battle_ready_req_t = new battle_ready_req_t();
			call( client_cmd_e.BATTLE_READY_REQ, req );
			
			LoadingEffect.hide();
		}
		
		/**
		 * 匹配, mode:0自动匹配，1好友或搜索对战
		 * @params uid 如果=0则标识自动匹配，！=0则表示好友或搜索对战
		 */
		public function matching( uid:int = 0 ):void
		{
			var req:battle_create_req_t = new battle_create_req_t();
			req.mode = uid == 0 ? 0 : 1;
			req.friend_id = uid;
			call( client_cmd_e.BATTLE_CREATE_REQ, req );
			
			LoadingEffect.hide();
		}
		
	}
}