package app.modules.fight.view.online
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.ViewName;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseMediator;
	import app.modules.fight.view.spell.SpellVo;
	import app.modules.model.vo.ItemType;
	import app.modules.model.vo.ItemVo;
	
	import victor.framework.log.Logger;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightOnlineMediator extends FightBaseMediator
	{
		[Inject]
		public var view:FightOnlineView;
		
		public function FightOnlineMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 更新下一个词
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordUpdateNotify, FightAloneEvent );
			// 结束通知
			addContextListener( FightOnlineEvent.BATTLE_END, endBattleNotify, FightOnlineEvent );
			
			initData();
		}
		
		private function endBattleNotify( event:FightOnlineEvent ):void
		{
			view.clear();
			openView( ViewName.FightOnlineResultPanel );
		}
		
		private function nextWordUpdateNotify( event:FightAloneEvent ):void
		{
			letterIndex = 0;
			setLetters();
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
					Tips.showMouse( "时间 +8s" );
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
			view.setPlayerName( GameData.instance.selfVo.name, readyModel.destVo.name );
			updateMoneyNotify( null );
			setLetters();
			setOtherLetters();
		}
		
		private function setOtherLetters():void
		{
			if ( fightModel.spellListCopy && fightModel.spellListCopy.length )
			{
				var spellVo:SpellVo = fightModel.spellListCopy.shift();
				var items:Vector.<LetterBubbleVo> = spellVo.items.slice();
				var length:int = fightModel.allLetterList.length;
				var index:int = 0;
				fightModel.allLetterListCopy.splice(0, spellVo.charsLength );
				for ( index = 0; index < 15; index++ )
				{
					if ( index < length ) items.push( fightModel.allLetterListCopy[ index ] );
					else break;
					if ( items.length > 15 )
						break;
				}
				view.setLettersPool( items, false );
			}
		}
		
	}
}