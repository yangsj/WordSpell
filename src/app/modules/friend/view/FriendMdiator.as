package app.modules.friend.view
{
	import app.modules.friend.event.FriendEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class FriendMdiator extends BaseMediator
	{
		public function FriendMdiator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addContextListener( FriendEvent.UPDATE_LIST, updateListHandler, FriendEvent );
		}
		
		private function updateListHandler( event:FriendEvent ):void
		{
			
		}
		
	}
}