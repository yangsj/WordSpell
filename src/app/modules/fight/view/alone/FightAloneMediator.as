package app.modules.fight.view.alone
{
	import app.core.Tips;
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.main.event.MainUIEvent;
	import app.modules.map.model.MapModel;
	
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
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var mapModel:MapModel;

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
			// 时间到
			addViewListener( FightEvent.TIME_OVER, timeOverHandler, FightEvent );

			// 更新金币值变化
			addContextListener( MainUIEvent.UPDATE_MONEY, updateMoneyHandler, MainUIEvent );
			// 更新下一个词
			addContextListener( FightEvent.NOTIFY_NEXT_WORD, nextWordUpdateHandler, FightEvent );

			initData();
		}
		
		private function timeOverHandler(event:FightEvent ):void
		{
			Tips.showCenter( "答题时间结束！", 20 );
			view.hide();
		}
		
		private function nextWordUpdateHandler( event:FightEvent ):void
		{
			view.setLettersPool( fightModel.spellVo.items );
		}

		private function updateMoneyHandler( event:MainUIEvent ):void
		{
			view.updateMoneyDisplay();
		}

		private function selectedLetterHandler( event:FightEvent ):void
		{
			var vo:LetterBubbleVo = event.data as LetterBubbleVo;
			view.delLetterFromDict( vo.letter );

			dispatch( new FightEvent( FightEvent.UPDATE_WORD, vo ));
		}

		private function initData():void
		{
			view.initialize();
			view.setLettersPool( fightModel.spellVo.items );
			view.setRoundName( mapModel.currentMapVo.mapName );
			updateMoneyHandler( null );
		}

	}
}
