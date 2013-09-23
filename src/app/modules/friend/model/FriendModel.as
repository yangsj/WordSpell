package app.modules.friend.model
{
	import app.modules.friend.event.FriendEvent;
	
	import org.robotlegs.mvcs.Actor;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-6
	 */
	public class FriendModel extends Actor
	{
		private var _friendList:Vector.<FriendVo>;

		public function FriendModel()
		{
			super();
		}
		
		////////// privates 
		
		private function update():void
		{
			dispatch( new FriendEvent( FriendEvent.UPDATE_LIST ));
		}

		/////////// publics 
		/**
		 * 添加好友，若是添加的好友已存在列表中将会更新好友数据
		 * @param friendVo
		 */
		public function addFriend( friendVo:FriendVo ):void
		{
			var key:int = getIndexByUid( friendVo.uid );
			if ( key != -1 )
				friendList[ key ] = friendVo;
			else
				friendList.push( friendVo );
			
			update();
		}
		
		/**
		 * 删除好友
		 * @param uid 需要删除的好友id
		 */
		public function delFriend( uid:int ):void
		{
			var key:int = getIndexByUid( uid );
			if ( key != -1 )
				friendList.splice( key, 1 );
		}

		/**
		 * 更新好友数据。若是当前好友不在列表中，则添加到列表中
		 * @param friendVo
		 */
		public function updateFriend( friendVo:FriendVo ):void
		{
			var key:int = getIndexByUid( friendVo.uid );
			if ( key != -1 )
				friendList[ key ] = friendVo;
		}

		/**
		 * 通过好友id获取好友数据信息。若是找不到指定的好友，则返回null。
		 * @param uid
		 * @return 
		 */
		public function getFriendByUId( uid:int ):FriendVo
		{
			for each ( var friendVo:FriendVo in friendList )
			{
				if ( friendVo && friendVo.uid == uid )
					return friendVo;
			}
			return null;
		}

		/**
		 * 通过id获取好友数据在列表中的排列序号index。若是找不到指定的数据，则返回-1。
		 * @param uid
		 * @return 
		 */
		public function getIndexByUid( uid:int ):int
		{
			var friendVo:FriendVo;
			for ( var key:String in friendList )
			{
				friendVo = friendVo[ key ];
				if ( friendVo && friendVo.uid == uid )
					return int( key );
			}
			return -1;
		}
		
		/////////// getters/setters
		
		/**
		 * 获取在线好友列表
		 * @return 
		 */
		public function get onLineList():Vector.<FriendVo>
		{
			var vecList:Vector.<FriendVo> = new Vector.<FriendVo>();
			for each (var friendVo:FriendVo in friendList )
			{
				if ( friendVo.onLine )
					vecList.push( friendVo );
			}
			return vecList;
		}

		/**
		 * 好友列表数据
		 * @return 
		 */
		public function get friendList():Vector.<FriendVo>
		{
			return _friendList ||= new Vector.<FriendVo>();
		}

		

	}
}
