package app.modules.fight.view
{
	import flash.geom.Point;
	
	import app.core.Tips;
	import app.events.PackEvent;
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.FightType;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.FightReadyModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightAloneService;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.fight.view.prop.PropList;
	import app.modules.fight.view.spell.SpellEvent;
	import app.modules.main.event.MainUIEvent;
	import app.modules.map.model.MapModel;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	
	import victor.framework.core.BaseMediator;
	import victor.framework.log.Logger;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-22
	 */
	public class FightBaseMediator extends BaseMediator
	{
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var readyModel:FightReadyModel;
		[Inject]
		public var mapModel:MapModel;
		[Inject]
		public var fightService:FightAloneService;
		
		private var baseView:FightBaseView;
		
		protected var letterIndex:int = 0;
		/**
		 * 是否点击道具泡泡
		 */
		protected var clickPropBubble:Array;
		/**
		 * 是否一个人状态
		 */
		protected var isAlone:Boolean = true;
		/**
		 * 不是基础模式时出现泡泡的最大数量
		 */
		protected var maxCount:int = 15;
		/**
		 * 选中的泡泡的位置
		 */
		protected var removeBubblePoint:Point;
		
		
		public function FightBaseMediator()
		{
			super();
		}
		
		override public function onRemove():void
		{
			super.onRemove();
			// 展开聊天窗口
			dispatch( new ChatEvent( ChatEvent.SHOW_CHAT ));
			
			baseView.clear();
			
			baseView.isValidOperate = false;
		}
		
		override public function onRegister():void
		{
			baseView = this.viewComponent as FightBaseView;
			
			super.onRegister();
			
			// 折叠聊天窗口
			dispatch( new ChatEvent( ChatEvent.HIDE_CHAT ));
			
			// 选择字母
			addViewListener( FightAloneEvent.SELECTED_LETTER, selectedLetterHandler, FightAloneEvent );
			
			// 更新金币值变化
			addContextListener( MainUIEvent.UPDATE_MONEY, updateMoneyNotify, MainUIEvent );
			// 物品使用成功
			addContextListener( PackEvent.USE_SUCCESS, useItemSuccessHandler, PackEvent );
			// 物品更新
			addContextListener( PackEvent.UPDATE_ITEMS, updateItemsHandler, PackEvent );
			// 更新下一个词
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordUpdateNotify, FightAloneEvent );
			// 显示增加金币动画
			addContextListener( FightAloneEvent.ADD_MONEY_EFFECT, addMoneyEffectHandler, FightAloneEvent );
			// 完成一个单词输入
			addContextListener( SpellEvent.ONE_WORD_OVER, onWordOverHandler, SpellEvent );
			
			baseView.mapId = fightModel.mapId;
			
			clickPropBubble = [];
			
			baseView.isValidOperate = true;
		}
		
		private function onWordOverHandler( event:SpellEvent ):void
		{
			baseView.isValidOperate = false;
		}
		
		protected function addMoneyEffectHandler( event:FightAloneEvent ):void
		{
			var array:Array = event.data as Array;
			if ( array[0] && removeBubblePoint )
				baseView.playAddMoneyEffect( int(array[1]), removeBubblePoint );
		}
		
		protected function updateMoneyNotify( event:MainUIEvent ):void
		{
			baseView.updateMoneyDisplay();
		}
		
		protected function updateItemsHandler( event:PackEvent ):void
		{
			if ( clickPropBubble )
			{
				var bubble:LetterBubble = ( clickPropBubble.length > 0 ) ? clickPropBubble.shift() : null;
				if ( bubble )
				{
					var itemType:int = bubble.data.itemType;
					baseView.delPropItemFromDict( itemType );
					baseView.playAddPropEffect( bubble, PropList.itemPoints[ itemType ] );
				}
			}
		}
		
		private function nextWordUpdateNotify( event:FightAloneEvent ):void
		{
			baseView.isValidOperate = true;
			letterIndex = 0;
			setLetters();
		}
		
		// 物品使用成功
		protected function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			if ( itemVo )
			{
				if ( itemVo.type == ItemType.EXTRA_TIME )
				{
					baseView.useExtraTimeProp();
					Tips.showMouse( "时间 +8s" );
				}
				else if ( itemVo.type == ItemType.BROOM )
				{
					baseView.useBroomProp();
				}
				else if ( itemVo.type == ItemType.HINT )
				{
					var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items;
					if ( letterIndex < items.length )
					{
						var key:String = items[ letterIndex ].letter;
						baseView.useHintProp( key );
					}
				}
			}
		}
		
		protected function selectedLetterHandler( event:FightAloneEvent ):void
		{
			var letterBublle:LetterBubble = event.data as LetterBubble;
			var vo:LetterBubbleVo = letterBublle.data;
			
			removeBubblePoint = letterBublle.globalPoint;
			
			// 测试泡泡
			if ( vo.id == -1 )
				return ;
			
			selectedBubble( vo );
			
			// 选中产生道具的字母泡泡
			if ( vo.itemType != ItemType.DEFAULT )
			{
				clickPropBubble.push( letterBublle );
				fightService.inputProp( vo.id );
			}
			else // 字母泡泡
			{
				baseView.delLetterFromDict( vo.letter );
				letterIndex++;
				dispatch( new FightAloneEvent( FightAloneEvent.UPDATE_WORD, vo ));
			}
		}
		
		protected function selectedBubble( vo:LetterBubbleVo ):void
		{
		}
		
		protected function setLetters():void
		{
			if ( fightModel.spellVo )
			{
				var modeType:int = fightModel.modeType;
				var items:Vector.<LetterBubbleVo> = fightModel.spellVo.items.slice();
				if ( modeType != FightType.MODE_EASY && modeType != FightType.MODE_PRACTICE ) // 不为容易和练习
				{
					var length:int = fightModel.allLetterList.length;
					var index:int = 0;
//					for ( index = 0; index < maxCount; index++ )
//					{
//						if ( index < length ) items.push( fightModel.allLetterList[ index ] );
//						else break;
//						if ( items.length > maxCount )
//							break;
//					}
					
					maxCount = Math.min( int( Math.random() * 3 + 2 ), length );
					for ( index = 0; index < maxCount; index++ ) {
						items.push( fightModel.allLetterList[ index ] );
					}
				}
				baseView.setLettersPool( items );
				Logger.debug( " fightModel.currentIndex *********************************************" +  fightModel.currentSelfIndex );
				if ( modeType > 1 )
				{
					var array:Array = fightModel.dictPropPos[ fightModel.currentSelfIndex ] as Array;
					if ( array ) {
						var letterVo:LetterBubbleVo;
						for each ( letterVo in array )
							baseView.addPropItem( letterVo );
					}
					baseView.displayPropItem();
				}
			}
		}
		
	}
}