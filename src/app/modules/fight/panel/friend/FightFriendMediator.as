package app.modules.fight.panel.friend
{
	import app.modules.friend.event.FriendEvent;
	import app.modules.friend.model.FriendModel;
	import app.modules.friend.service.FriendService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightFriendMediator extends BaseMediator
	{
		[Inject]
		public var view:FightFriendPanel;
		[Inject]
		public var friendService:FriendService;
		[Inject]
		public var friendModel:FriendModel;
		
		public function FightFriendMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( FriendEvent.UPDATE_LIST, updateListHandler, FriendEvent );
			
			friendService.pullFriendListReq();
		}
		
		protected function updateListHandler( event:FriendEvent ):void
		{
			view.setDataList( friendModel.onLineList );
		} 
		
	}
}