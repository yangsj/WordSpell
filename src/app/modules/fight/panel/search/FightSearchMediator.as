package app.modules.fight.panel.search
{
	import app.modules.friend.model.FriendVo;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightSearchMediator extends BaseMediator
	{
		[Inject]
		public var view:FightSearchPanel;
		
		public function FightSearchMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			view.setDataList( new Vector.<FriendVo>());
		}
	}
}