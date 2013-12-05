package app.modules.friend.view
{
	import app.modules.ViewName;
	import app.modules.friend.event.FriendEvent;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendOnlineListMediator extends FriendMdiator
	{
		
		public function FriendOnlineListMediator()
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
			
			view = this.viewComponent as FriendOnlineListView;
			
			super.onRegister();
		}
		
		override protected function setFriendList():void
		{
			view.setData( friendModel.onLineList );
		}
		
	}
}