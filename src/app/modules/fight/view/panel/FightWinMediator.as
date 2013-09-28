package app.modules.fight.view.panel
{
	import app.modules.ViewName;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class FightWinMediator extends BaseMediator
	{
		public function FightWinMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			closeView( ViewName.FightAlone );
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
		}
	}
}