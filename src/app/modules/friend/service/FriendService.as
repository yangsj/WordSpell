package app.modules.friend.service
{
	import app.core.Alert;
	import app.core.Tips;
	import app.events.GameEvent;
	import app.modules.friend.model.FriendApplyVo;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.model.FriendVo;
	
	import ff.add_friend_req_t;
	import ff.add_friends_success_ret_t;
	import ff.client_cmd_e;
	import ff.confirm_add_friend_req_t;
	import ff.del_friend_req_t;
	import ff.del_friend_ret_t;
	import ff.friend_info_t;
	import ff.friend_t;
	import ff.notify_add_friend_ret_t;
	import ff.server_cmd_e;
	
	import victor.framework.core.BaseService;
	import victor.framework.socket.SocketResp;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-6
	 */
	public class FriendService extends BaseService
	{
		[Inject]
		public var friendModel:FriendModel;

		public function FriendService()
		{
			super();
		}

		override protected function initRegist():void
		{
			// 好友列表信息通知
			regist( server_cmd_e.FRIEND_INFO_RET, friendListNotify, friend_info_t );
			// 添加好友成功通知
			regist( server_cmd_e.ADD_FRIEND_SUCCESS_RET, addFriendSuccessedNotify, add_friends_success_ret_t );
			// 加好友申请通知
			regist( server_cmd_e.NOTIFY_ADD_FRIEND_RET, applyAddFriendNotify, notify_add_friend_ret_t );
			// 成功删除好友通知
			regist( server_cmd_e.DEL_FRIEND_RET, delFriendNotify, del_friend_ret_t );
		}
		
	////////////////////////////////// notify 
		
		// 好友列表
		private function friendListNotify( resp:SocketResp ):void
		{
			var data:friend_info_t = resp.data as friend_info_t;
			var list:Array = data.friend_list;
			
			// 清除原有的列表数据
			friendModel.clearZero();
			
			for each ( var friend:friend_t in list )
				friendModel.addFriend(getFriendVo( friend ), false );
			
			// 更新列表
			friendModel.update();
			
			// 检查是否进入游戏（登陆时检查一次）
			if (friendModel.hasFriendList == false ) {
				friendModel.hasFriendList = true;
				dispatch( new GameEvent( GameEvent.ACQUIRE_FRIEND_DATA ));
			}
		}
		
		// 添加好友成功
		private function addFriendSuccessedNotify( resp:SocketResp ):void
		{
			var data:add_friends_success_ret_t = resp.data as add_friends_success_ret_t;
			
			Tips.showCenter( "成功添加好友[ " + data.name + " ]" );
		}
		
		// 好友申请通知
		private function applyAddFriendNotify( resp:SocketResp ):void
		{
			var data:notify_add_friend_ret_t = resp.data as notify_add_friend_ret_t;
			var applyVo:FriendApplyVo = new FriendApplyVo();
			applyVo.name = data.name;
			applyVo.uid = data.uid;
			friendModel.addApplyAddFriendList( applyVo );
			if ( friendModel.applyAddFriendList.length == 1 ) dealApplyList();
		}
		
		// 成功删除好友通知
		private function delFriendNotify( resp:SocketResp ):void
		{
			var data:del_friend_ret_t = resp.data as del_friend_ret_t;
			friendModel.delFriend( data.uid );
			Tips.showCenter( "成功删除好友" );
		}
		
	////////////////////////////////// private 
		
		/**
		 * 好友申请通知处理
		 */
		private function dealApplyList():void
		{
			var applyVo:FriendApplyVo = friendModel.applyAddFriendList[0];
			Alert.show( "[ " + applyVo.name + " ]申请和您成为好友，您是否同意？", callBack, "同意", "拒绝" );
			function callBack( type:int ):void
			{
				var isAgree:Boolean = type == Alert.YES;
				agreeAddFriend( applyVo.uid, isAgree );
				friendModel.applyAddFriendList.shift();
				if ( friendModel.isEmptyApplyList == false )
					dealApplyList();
			}
		}
		
	////////////////////////////////// public 
		
		/**
		 * 数据类型转换
		 * @param friend 协议定义的好友数据结构
		 * @return 
		 */
		public function getFriendVo( friend:friend_t ):FriendVo
		{
			var friendVo:FriendVo = new FriendVo();
			friendVo.uid = friend.uid;
			friendVo.name = friend.name;
			friendVo.grade = friend.grade;
			friendVo.level = friend.level;
			friendVo.status = friend.status;
			return friendVo;
		}
		
		/**
		 * 拉取好友列表数据
		 */
		public function getFriendListReq():void
		{
			
		}
		
		/**
		 * 添加好友
		 * @param friendName 添加的好友名称
		 */
		public function addFriend( friendName:String ):void
		{
			var req:add_friend_req_t = new add_friend_req_t();
			req.name = friendName;
			call( client_cmd_e.ADD_FRIEND_REQ, req );
			
			Tips.showMouse( "申请消息已发送！" );
		}
		
		/**
		 * 同意或拒绝加为好友
		 * @param uid 好友id
		 * @param isAgree 是否同意加好友
		 */
		public function agreeAddFriend(uid:int, isAgree:Boolean):void
		{
			var req:confirm_add_friend_req_t = new confirm_add_friend_req_t();
			req.uid = uid;
			req.permit_flag = isAgree;
			call( client_cmd_e.CONFIRM_ADD_FRIEND_REQ, req );
		}
		
		/**
		 * 删除好友
		 * @param uid 好友id
		 */
		public function delFriend( uid:int ):void
		{
			var req:del_friend_req_t = new del_friend_req_t();
			req.uid = uid;
			call( client_cmd_e.DEL_FRIEND_REQ, req );
		}

	}
}