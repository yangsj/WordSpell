package app.modules.fight.panel.search
{
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.service.FightOnlineService;
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
		[Inject]
		public var fightOnlineService:FightOnlineService;
		
		public function FightSearchMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( FightOnlineEvent.INVITE_PLAYER_BATTLE, invitePlayerToBattleHandler, FightOnlineEvent );
			
			view.setDataList( new Vector.<FriendVo>());
		}
		
		private function invitePlayerToBattleHandler( event:FightOnlineEvent ):void
		{
			var friendVo:FriendVo = event.data as FriendVo;
			fightOnlineService.matching( friendVo.uid );
		}
	}
}