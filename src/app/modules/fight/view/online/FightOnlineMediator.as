package app.modules.fight.view.online
{
	import app.modules.chat.event.ChatEvent;
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightAloneService;
	import app.modules.fight.view.item.LetterBubble;
	import app.modules.map.model.MapModel;
	import app.modules.model.vo.ItemType;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightOnlineMediator extends BaseMediator
	{
		[Inject]
		public var view:FightOnlineView;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var mapModel:MapModel;
		[Inject]
		public var fightService:FightAloneService;
		
		private var letterIndex:int = 0;
		
		public function FightOnlineMediator()
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
			
		}
		
		private function selectedLetterHandler( event:FightEvent ):void
		{
			var letterBublle:LetterBubble = event.data as LetterBubble;
			var vo:LetterBubbleVo = letterBublle.data;
			
			// 测试泡泡
			if ( vo.id == -1 )
				return ;
			
			// 选中产生道具的字母泡泡
			if ( vo.itemType != ItemType.DEFAULT )
			{
//				clickPropBubble.push( letterBublle );
				fightService.inputProp( vo.id );
			}
			else // 字母泡泡
			{
				view.delLetterFromDict( vo.letter );
				letterIndex++;
				dispatch( new FightEvent( FightEvent.UPDATE_WORD, vo ));
			}
		}
	}
}