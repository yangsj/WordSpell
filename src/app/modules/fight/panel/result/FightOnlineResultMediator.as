package app.modules.fight.panel.result
{
	import flash.events.Event;
	
	import app.core.Tips;
	import app.data.GameData;
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.events.PanelEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightOnlineResultMediator extends BaseMediator
	{
		[Inject]
		public var view:FightOnlineResultPanel;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var readyModel:FightReadyModel;
		
		public function FightOnlineResultMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 退出
			addViewListener( PanelEvent.CLOSE, closeQuitHandler, PanelEvent );
			// 再来一次
			addViewListener( "again", againHandler, Event );
			
			var iswin:Boolean = fightModel.battleResult;
			var winPlayer:String = iswin ? GameData.instance.selfVo.name : readyModel.destVo.name;
			var losePlayer:String = iswin ? GameData.instance.selfVo.name : readyModel.destVo.name;
			view.setPlayer( winPlayer, losePlayer );
			view.setData( iswin ? fightModel.battleEndSelfVo : fightModel.battleEndDestVo, !iswin ? fightModel.battleEndSelfVo : fightModel.battleEndDestVo );
			
		}
		
		private function againHandler( event:Event ):void
		{
			// 再来一次
			Tips.showCenter( "再来一局，功能暂未开放！" );
		}
		
		private function closeQuitHandler( event:PanelEvent ):void
		{
			closeView( ViewName.FightOnline );
		}
		
	}
}