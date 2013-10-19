package app.modules.fight.panel.ready
{
	import app.modules.fight.model.FightReadyModel;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightReadyMediator extends BaseMediator
	{
		[Inject]
		public var  readyModel:FightReadyModel;
		
		public function FightReadyMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 准备
			addViewListener( FightReadyEvent.READY, readyHandler , FightReadyEvent );
			
			// 更新
			addContextListener( FightReadyEvent.UPDATE, updateHandler, FightReadyEvent );
			
			
		}
		
		private function updateHandler( event:FightReadyEvent ):void
		{
			
		}
		
		private function readyHandler( event:FightReadyEvent ):void
		{
			
		}
		
	}
}