package app.modules.friend.view
{
	import app.core.Tips;
	import app.modules.ViewName;
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.service.FriendService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendAddMediator extends BaseMediator
	{
		[Inject]
		public var friendService:FriendService;
		[Inject]
		public var view:FriendAddView;
		
		public function FriendAddMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			openView( ViewName.Friend );
			
			super.onRemove();
		}
		
		override public function onRegister():void
		{
			// 关闭
			closeView( ViewName.Friend );
			
			super.onRegister();
			addViewListener( FriendEvent.ADD_FRIEND, addFriendHandle, FriendEvent );
		}
		
		private function addFriendHandle( event:FriendEvent ):void
		{
			var friendName:String = view.txtInput.text;
			if ( friendName )
				friendService.addFriend( friendName );
			else Tips.showMouse( "太不小心了，好友名称还没输入呢！" );
		}
	}
}