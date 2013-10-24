package app.modules.fight.view.online
{
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.view.FightBaseMediator;
	import app.modules.fight.view.spell.SpellVo;
	
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
			
			// 若是结果显示面板已打开则关闭
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.FightOnlineResultPanel ));
			
			// 更新自己下一个词
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordUpdateNotify, FightAloneEvent );
			// 结束通知
			addContextListener( FightOnlineEvent.BATTLE_END, endBattleNotify, FightOnlineEvent );
			// 删除对手屏幕中的泡泡
			addContextListener( FightOnlineEvent.DEL_DEST_BUBLLE, delDestBubbleHandler, FightOnlineEvent );
			
			initData();
		}
		
		// 删除对手屏幕中的泡泡
		private function delDestBubbleHandler( event:FightOnlineEvent ):void
		{
			view.delBubbleByIdForOther( int(event.data) );
		}
		
		// 结束通知
		private function endBattleNotify( event:FightOnlineEvent ):void
		{
			view.clear();
			openView( ViewName.FightOnlineResultPanel );
		}
		
		// 更新自己下一个词
		private function nextWordUpdateNotify( event:FightAloneEvent ):void
		{
			letterIndex = 0;
			setLetters();
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
		
		override protected function selectedBubble(vo:LetterBubbleVo):void
		{
			view.delBubbleByIdForOther( vo.id );
		}
		
	}
}