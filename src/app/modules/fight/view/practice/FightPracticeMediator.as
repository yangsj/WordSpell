package app.modules.fight.view.practice
{
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.view.alone.FightAloneMediator;
	import app.modules.fight.view.alone.FightAloneView;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-20
	 */
	public class FightPracticeMediator extends FightAloneMediator
	{
		public function FightPracticeMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view = this.viewComponent as FightAloneView;
			
			super.onRegister();
			
			// 展开聊天窗口
			dispatch( new ChatEvent( ChatEvent.SHOW_CHAT ));
			// 折叠聊天窗口
			dispatch( new ChatEvent( ChatEvent.FOLD_CHAT ));
		}
		
		override protected function pullData():void
		{
			fightService.startRound( 3 );
		}
		
	}
}