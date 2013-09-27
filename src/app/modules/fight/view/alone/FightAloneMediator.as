package app.modules.fight.view.alone
{
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.events.FightEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightAloneMediator extends BaseMediator
	{
		[Inject]
		public var view:FightAloneView;
		
		public function FightAloneMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			// 展开聊天窗口
			dispatch( new ChatEvent( ChatEvent.EXPAND_CHAT ));
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 折叠聊天窗口
			dispatch( new ChatEvent( ChatEvent.FOLD_CHAT ));
			
			// 选择字母
			addViewListener( FightEvent.SELECTED_LETTER, selectedLetterHandler, FightEvent );
			
			view.setLettersPool( "abcdefghijklmnopqrstuvwxyz".split("") );
		}
		
		private function selectedLetterHandler( event:FightEvent ):void
		{
			var key:String = event.data.toString();
			view.delLetterFromDict( key );
			trace( key );
		}
		
	}
}