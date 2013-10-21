package app.modules.fight.command
{
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.panel.friend.FightFriendMediator;
	import app.modules.fight.panel.friend.FightFriendPanel;
	import app.modules.fight.panel.matching.FightMatchingMediator;
	import app.modules.fight.panel.matching.FightMatchingPanel;
	import app.modules.fight.panel.ready.FightReadyMediator;
	import app.modules.fight.panel.ready.FightReadyPanel;
	import app.modules.fight.panel.result.FightOnlineResultMediator;
	import app.modules.fight.panel.result.FightOnlineResultPanel;
	import app.modules.fight.panel.search.FightSearchMediator;
	import app.modules.fight.panel.search.FightSearchPanel;
	import app.modules.fight.service.FightAloneService;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.fight.view.alone.FightAloneMediator;
	import app.modules.fight.view.alone.FightAloneView;
	import app.modules.fight.view.online.FightOnlineMediator;
	import app.modules.fight.view.online.FightOnlineView;
	import app.modules.fight.view.panel.FightLoseMediator;
	import app.modules.fight.view.panel.FightLosePanel;
	import app.modules.fight.view.panel.FightWinMediator;
	import app.modules.fight.view.panel.FightWinPanel;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.prop.PropListMediator;
	import app.modules.fight.view.spell.SpellArea;
	import app.modules.fight.view.spell.SpellAreaMediator;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightInitCommand extends BaseCommand
	{
		public function FightInitCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			addView( ViewName.FightAlone, FightAloneView, FightAloneMediator );
			addView( ViewName.FightOnline, FightOnlineView, FightOnlineMediator );
			
			addView( ViewName.FightWinPanel, FightWinPanel, FightWinMediator );
			addView( ViewName.FightLosePanel, FightLosePanel, FightLoseMediator );
			
			addView( ViewName.FightMatchingPanel, FightMatchingPanel, FightMatchingMediator );
			addView( ViewName.FightReadyPanel, FightReadyPanel, FightReadyMediator );
			addView( ViewName.FightOnlineResultPanel, FightOnlineResultPanel, FightOnlineResultMediator );
			addView( ViewName.FightFriendPanel, FightFriendPanel, FightFriendMediator );
			addView( ViewName.FightSearchPanel, FightSearchPanel, FightSearchMediator );
			
			mapView( PropList, PropListMediator );
			mapView( SpellArea, SpellAreaMediator );
			
			injectActor( FightModel );
			injectActor( FightReadyModel );
			injectActor( FightAloneService );
			injectActor( FightOnlineService );
		}
		
	}
}