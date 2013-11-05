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
			
			view.setData( getListData );
		}
		
		private function invitePlayerToBattleHandler( event:FightOnlineEvent ):void
		{
			var friendVo:FriendVo = event.data as FriendVo;
			fightOnlineService.matching( friendVo.uid );
		}
		
		private function get getListData():Vector.<FriendVo>
		{
			var vec:Vector.<FriendVo> = new Vector.<FriendVo>();
			for ( var i:int = 0; i < 50; i++ )
			{
				var startIndex:int = int( Math.random() * 20);
				var vo:FriendVo = new FriendVo();
				vo.name = i + "abcdefghijklmnopqrstuvwxyz".substr(startIndex, 6);
				vo.status = int( Math.random() * 3)+1;
				vec.push( vo );
			}
			return vec;
		}
	}
}