package app.modules.friend.view.rightMenu
{
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class RightMenuMediator extends BaseMediator
	{
		[Inject]
		public var view:RightMenu;
		public function RightMenuMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( RightMenuEvent.SELECTED, selectedHandler, RightMenuEvent );
		}
		
		private function selectedHandler( event:RightMenuEvent ):void
		{
			view.removed( int( event.data ) );
		}
		
	}
}