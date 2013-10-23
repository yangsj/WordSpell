package app.modules.friend.view
{
	import app.modules.friend.model.FriendModel;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendOnlineListMediator extends BaseMediator
	{
		[Inject]
		public var view:FriendOnlineListView;
		[Inject]
		public var friendModel:FriendModel;
		
		public function FriendOnlineListMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			view.setData( friendModel.onLineList );
		}
		
	}
}