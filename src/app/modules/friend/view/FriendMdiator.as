package app.modules.friend.view
{
	import app.core.Tips;
	import app.modules.chat.model.ChatModel;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.model.FriendVo;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class FriendMdiator extends BaseMediator
	{
		[Inject]
		public var view:FriendView;
		[Inject]
		public var friendModel:FriendModel;
		[Inject]
		public var chatModel:ChatModel;
		
		public function FriendMdiator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( FriendEvent.UPDATE_LIST, updateListHandler, FriendEvent );
			
			addViewListener( FriendEvent.CHAT, chatHandler, FriendEvent );
			addViewListener( FriendEvent.BATTLE, battleHandler, FriendEvent );
			addViewListener( FriendEvent.DELETE, deleteHandler, FriendEvent );
			
			view.setData( friendModel.friendList );
		}
		
		private function deleteHandler( event:FriendEvent ):void
		{
			Tips.showCenter( "删除好友" );
		}
		
		private function battleHandler( event:FriendEvent ):void
		{
			Tips.showCenter( "好友在线对战" );
		}
		
		private function chatHandler( event:FriendEvent ):void
		{
			Tips.showCenter( "好友聊天" );
			chatModel.privateChatFriendVo = event.data as FriendVo;
		}
		
		private function updateListHandler( event:FriendEvent ):void
		{
			
		}
		
	}
}