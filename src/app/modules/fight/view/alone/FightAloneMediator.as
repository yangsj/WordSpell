package app.modules.fight.view.alone
{
	import app.events.PackEvent;
	import app.modules.ViewName;
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.FightType;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseMediator;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	
	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-27
	 */
	public class FightAloneMediator extends FightBaseMediator
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
			if ( mapModel.isNeddOpenFromFight )
				openView( ViewName.SelectedRoundPanel, mapModel.currentMapVo );
		}

		override public function onRegister():void
		{
			view.isAlone = true;
			isAlone = true;
			maxCount = 18;
			
			super.onRegister();

			// 开始通知
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, startRoundNotify, FightAloneEvent );
			// 结束通知
			addContextListener( FightAloneEvent.NOTIFY_END_ROUND, endRoundNotify, FightAloneEvent );
			
			// 拉取数据
			pullData();
		}
		
		protected function endRoundNotify( event:FightAloneEvent ):void
		{
			view.clear();
			if ( fightModel.modeType == FightType.MODE_ERROR )
			{
				openView( ViewName.FightPracticeEndPanel );
			}
			else if ( fightModel.fightEndVo.isWin )
				openView( ViewName.FightWinPanel );
			else openView( ViewName.FightLosePanel );
		}
		
		private function startRoundNotify( event:FightAloneEvent ):void
		{
			initData();
			
			if ( fightModel.isPractice )
			{
				// 展开聊天窗口
				dispatch( new ChatEvent( ChatEvent.SHOW_CHAT ));
				// 折叠聊天窗口
				dispatch( new ChatEvent( ChatEvent.FOLD_CHAT ));
			}
			else
			{
				// 折叠聊天窗口
				dispatch( new ChatEvent( ChatEvent.HIDE_CHAT ));
			}
		}

		// 物品使用成功
		override protected function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			if ( itemVo ) {
				if ( itemVo.type == ItemType.EXTRA_TIME ) {
					view.useExtraTimeProp();
				} else if ( itemVo.type == ItemType.BROOM ) {
					view.useBroomProp();
				} else if ( itemVo.type == ItemType.HINT ) {
					var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items;
					if ( letterIndex < items.length ) {
						var key:String = items[ letterIndex ].letter;
						view.useHintProp( key );
					}
				}
			}
		}
		
		protected function  pullData():void
		{
			fightService.startRound( mapModel.isSelectedRound ? 0 : 1 );
		}

		private function initData():void
		{
			
			view.setRoundName( mapModel.currentMapVo.mapName, !fightModel.isPractice );
			
			letterIndex = 0;
			view.initialize( fightModel.isPractice );
			updateMoneyNotify( null );
			setLetters();
			
			// 设置背景
			view.setBg( mapModel.currentMapVo.mapId );
		}

	}
}
