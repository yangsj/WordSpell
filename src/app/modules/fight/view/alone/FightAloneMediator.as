package app.modules.fight.view.alone
{
	import app.core.Tips;
	import app.events.PackEvent;
	import app.modules.ViewName;
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

		override public function onRegister():void
		{
			isAlone = true;
			maxCount = 30;
			
			super.onRegister();

			// 开始通知
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, startRoundNotify, FightAloneEvent );
			// 结束通知
			addContextListener( FightAloneEvent.NOTIFY_END_ROUND, endRoundNotify, FightAloneEvent );
			
			// 拉取数据
			fightService.startRound();
		}
		
		private function endRoundNotify( event:FightAloneEvent ):void
		{
			view.clear();
			if ( fightModel.fightEndVo.isWin )
				openView( ViewName.FightWinPanel );
			else openView( ViewName.FightLosePanel );
		}
		
		private function startRoundNotify( event:FightAloneEvent ):void
		{
			initData();
		}

		// 物品使用成功
		override protected function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			if ( itemVo )
			{
				if ( itemVo.type == ItemType.EXTRA_TIME )
				{
					view.useExtraTimeProp();
					Tips.showMouse( "时间 +5s" );
				}
				else if ( itemVo.type == ItemType.BROOM )
				{
					view.useBroomProp();
				}
				else if ( itemVo.type == ItemType.HINT )
				{
					var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items;
					if ( letterIndex < items.length )
					{
						var key:String = items[ letterIndex ].letter;
						view.useHintProp( key );
					}
				}
			}
		}

		private function initData():void
		{
			letterIndex = 0;
			view.initialize();
			view.setRoundName( mapModel.currentMapVo.mapName );
			updateMoneyNotify( null );
			setLetters();
		}

	}
}
