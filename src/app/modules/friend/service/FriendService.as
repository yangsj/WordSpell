package app.modules.friend.service
{
	import app.events.GameEvent;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.model.FriendVo;
	
	import ff.friend_info_t;
	import ff.friend_t;
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
			regist( server_cmd_e.FRIEND_INFO_RET, friendListNotify, friend_info_t );
		}

		private function friendListNotify( resp:SocketResp ):void
		{
			var data:friend_info_t = resp.data as friend_info_t;
			var list:Array = data.friend_list;
			var friendVo:FriendVo;
			for each ( var friend:friend_t in list )
			{
				friendVo = new FriendVo();
				friendVo.uid = friend.uid;
				friendVo.name = friend.name;
				friendVo.grade = friend.grade;
				friendVo.level = friend.level;
				friendVo.status = friend.status;

				friendModel.friendList.push( friendVo );
			}
			
			// 检查是否进入游戏（登陆时检查一次）
			if (friendModel.hasFriendList == false )
			{
				friendModel.hasFriendList = true;
				dispatch( new GameEvent( GameEvent.ACQUIRE_FRIEND_DATA ));
			}
		}

	}
}