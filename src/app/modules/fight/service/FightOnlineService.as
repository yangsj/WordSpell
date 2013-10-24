package app.modules.fight.service
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.LoadingEffect;
	import app.modules.ViewName;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightMatchingVo;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.model.LetterBubbleVo;
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
		[Inject]
		public var aloneService:FightAloneService;
		
		public function FightOnlineService()
		{
			super();
		}
		
		override protected function initRegist():void
		{
			// 准备通知
			regist( server_cmd_e.BATTLE_READY_RET , readyNotify, battle_ready_req_t );
			// 对战结束通知
			regist( server_cmd_e.BATTLE_CLOSE_RET, battleEndNotify, battle_close_ret_t );
			// 匹配成功
			regist( server_cmd_e.BATTLE_CREATE_RET, matchingSuccessNotify, battle_create_ret_t );
			// 对方邀请要来一局通知
//			regist( server_cmd_e.BATTLE_CREATE_RET, againBattleInviteNotify, battle_create_ret_t );
			// 对方消除泡泡通知
//			regist( server_cmd_e.BATTLE_CREATE_RET, destBubbleNotify, battle_create_ret_t );
		}
		
//*************************** Notify *************************//
		
		// 取消准备通知
		private function battleEndNotify( resp:SocketResp ):void
		{
			var data:battle_close_ret_t = resp.data as battle_close_ret_t;
			
			fightModel.battleResult = data.win;
			fightModel.battleResultFlag = data.flag;
			fightModel.battleEndSelfVo = aloneService.getBattleEndVo( data.self_result );
			fightModel.battleEndDestVo = aloneService.getBattleEndVo( data.dest_result );
			
			//更新等级
			if ( fightModel.battleEndSelfVo.currentLevel != GameData.instance.selfVo.level )
				GameData.instance.updateLevel( fightModel.battleEndSelfVo.currentLevel );
			
			//更新经验值
			if ( fightModel.battleEndSelfVo.addExp > 0 )
				GameData.instance.updateAddExp( fightModel.battleEndSelfVo.addExp );
			
			dispatch( new FightOnlineEvent( FightOnlineEvent.BATTLE_END ));
		}
		
		// 准备通知
		private function readyNotify( resp:SocketResp ):void
		{
			dispatch( new FightReadyEvent( FightReadyEvent.UPDATE ));
		}
		
		// 匹配成功通知
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
		}
		
		// 对方邀请再来一局
		private function againBattleInviteNotify( resp:SocketResp ):void
		{
			
		}
		
		// 对方泡泡消除通知
		private function destBubbleNotify( resp:SocketResp ):void
		{
			
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
		 * @params uid 如果=0则标识自动匹配，!=0则表示好友或搜索对战
		 */
		public function matching( uid:int = 0 ):void
		{
			var req:battle_create_req_t = new battle_create_req_t();
			req.mode = uid == 0 ? 0 : 1;
			req.friend_id = uid;
			call( client_cmd_e.BATTLE_CREATE_REQ, req );
			
			LoadingEffect.hide();
		}
		
		/**
		 * 对战中选择泡泡后发送到服务器
		 * @param vo
		 */
		public function selectedBubble( vo:LetterBubbleVo ):void
		{
			
			LoadingEffect.hide();
		}
		
		/**
		 * 再来一局
		 */
		public function againBattle():void
		{
			Tips.showCenter( "【再来一局】功能暂未开放！稍后放出" );
		}
		
		/**
		 * 是否同意再来一局
		 * @param uid
		 * @param isAgree
		 */
		public function agreeAgain( uid:int, isAgree:Boolean ):void
		{
			
		}
		
	}
}