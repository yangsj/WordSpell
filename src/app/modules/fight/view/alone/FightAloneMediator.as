package app.modules.fight.view.alone
{
	import app.core.Tips;
	import app.events.PackEvent;
	import app.modules.ViewName;
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightService;
	import app.modules.main.event.MainUIEvent;
	import app.modules.map.model.MapModel;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	
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
		[Inject]
		public var fightService:FightService;
		
		private var letterIndex:int = 0;
		
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

			// 开始通知
			addContextListener( FightEvent.NOTIFY_START_ROUND, startRoundNotify, FightEvent );
			// 结束通知
			addContextListener( FightEvent.NOTIFY_END_ROUND, endRoundNotify, FightEvent );
			// 更新金币值变化
			addContextListener( MainUIEvent.UPDATE_MONEY, updateMoneyNotify, MainUIEvent );
			// 更新下一个词
			addContextListener( FightEvent.NOTIFY_NEXT_WORD, nextWordUpdateNotify, FightEvent );
			
			// 物品使用成功
			addContextListener( PackEvent.USE_SUCCESS, useItemSuccessHandler, PackEvent );

			// 拉取数据
			fightService.startRound();
		}
		
		private function endRoundNotify( event:FightEvent ):void
		{
			view.clear();
			if ( fightModel.fightEndVo.isWin )
				openView( ViewName.FightWinPanel );
			else openView( ViewName.FightLosePanel );
		}
		
		private function startRoundNotify( event:FightEvent ):void
		{
			initData();
		}
		
		private function nextWordUpdateNotify( event:FightEvent ):void
		{
			letterIndex = 0;
			if ( fightModel.spellVo )
				view.setLettersPool( fightModel.spellVo.items );
		}

		private function updateMoneyNotify( event:MainUIEvent ):void
		{
			view.updateMoneyDisplay();
		}

		private function selectedLetterHandler( event:FightEvent ):void
		{
			var vo:LetterBubbleVo = event.data as LetterBubbleVo;
			view.delLetterFromDict( vo.letter );
			
			letterIndex++;

			dispatch( new FightEvent( FightEvent.UPDATE_WORD, vo ));
			
			// 选中产生道具的字母泡泡
			if ( vo.itemType != ItemType.DEFAULT )
			{
				fightService.inputProp( vo.id );
			}
		}
		
		// 物品使用成功
		private function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
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

		private function initData():void
		{
			letterIndex = 0;
			view.initialize();
			view.setLettersPool( fightModel.spellVo.items );
			view.setRoundName( mapModel.currentMapVo.mapName );
			updateMoneyNotify( null );
		}

	}
}
