package app.modules.fight.command
{
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.service.FightService;
	import app.modules.fight.view.alone.FightAloneMediator;
	import app.modules.fight.view.alone.FightAloneView;
	import app.modules.fight.view.online.FightOnlineMediator;
	import app.modules.fight.view.online.FightOnlineView;
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
			
			mapView( PropList, PropListMediator );
			mapView( SpellArea, SpellAreaMediator );
			
			injectActor( FightModel );
			
			injectActor( FightService );
		}
		
	}
}