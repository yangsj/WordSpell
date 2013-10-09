package app.modules.fight.view.panel
{
	import app.modules.ViewName;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.service.FightService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class FightResultBaseMediator extends BaseMediator
	{
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var fightService:FightService;
		
		public function FightResultBaseMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			addViewListener( FightResultEvent.AGAIN, againHandler, FightResultEvent );
			addViewListener( FightResultEvent.CLOSE, closeHandler, FightResultEvent );
			addViewListener( FightResultEvent.NEXT, nextHandler, FightResultEvent );
			addViewListener( FightResultEvent.PRACTICE, practiceHandler, FightResultEvent );
			
		}
		
		protected function againHandler( event:FightResultEvent ):void
		{
			
		}
		
		protected function closeHandler( event:FightResultEvent ):void
		{
			closeView( ViewName.FightAlone );
		}
		
		protected function nextHandler( event:FightResultEvent ):void
		{
			
		}
		
		protected function practiceHandler( event:FightResultEvent ):void
		{
			
		}
		
	}
}