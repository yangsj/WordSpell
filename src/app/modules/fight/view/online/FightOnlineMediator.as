package app.modules.fight.view.online
{
	import app.data.GameData;
	import app.modules.ViewName;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightOnlineService;
	import app.modules.fight.view.FightBaseMediator;
	import app.modules.fight.view.spell.SpellVo;
	
	import victor.framework.debug.Debug;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class FightOnlineMediator extends FightBaseMediator
	{
		[Inject]
		public var view:FightOnlineView;
		[Inject]
		public var onlineService:FightOnlineService;
		
		public function FightOnlineMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			view.isAlone = false;
			isAlone = false;
			maxCount = 15;
			
			super.onRegister();
			
			// 若是结果显示面板已打开则关闭
			closeView( ViewName.FightOnlineResultPanel );
			
			// 结束通知
			addContextListener( FightOnlineEvent.BATTLE_END, endBattleNotify, FightOnlineEvent );
			// 删除对手屏幕中的泡泡
			addContextListener( FightOnlineEvent.DEL_DEST_BUBLLE, delDestBubbleHandler, FightOnlineEvent );
			// 对手更新下一个单词
			addContextListener( FightOnlineEvent.DEST_UPDATE_NEXT, destUpdateNextNotify, FightOnlineEvent );
			
			initData();
		}
		
		// 删除对手屏幕中的泡泡
		private function delDestBubbleHandler( event:FightOnlineEvent ):void
		{
			var letterVo:LetterBubbleVo = event.data as LetterBubbleVo;
			view.delBubbleByIdForOther( letterVo.id );
		}
		
		private function destUpdateNextNotify( event:FightOnlineEvent ):void
		{
			view.answerResult( Boolean( event.data ), false );
			setOtherLetters();
		}
		
		// 结束通知
		private function endBattleNotify( event:FightOnlineEvent ):void
		{
			view.clear();
			openView( ViewName.FightOnlineResultPanel );
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
				var spellVo:SpellVo = fightModel.spellCopyVo;
				var items:Vector.<LetterBubbleVo> = spellVo.items.slice();
				var length:int = fightModel.allLetterListCopy.length;
				var index:int = 0;
				items[0].isUpperCase = true;
				Debug.debug( "对手的单词：" + spellVo.chinese );
//				for ( index = 0; index < maxCount; index++ )
//				{
//					if ( index < length ) items.push( fightModel.allLetterListCopy[ index ] );
//					else break;
//					if ( items.length > maxCount )
//						break;
//				}
				
//				maxCount = Math.min( int( Math.random() * 3 + 3 ), length );
				maxCount = Math.min( getOnlineAddCaseNumber( items.length ), length );
				for ( index = 0; index < maxCount; index++ ) {
					items.push( fightModel.allLetterListCopy[ index ] );
				}
				
				view.setLettersPool( items, false );
				
				var array:Array = fightModel.dictPropPos[ fightModel.currentDestIndex ] as Array;
				if ( array ) {
					var letterVo:LetterBubbleVo;
					for each ( letterVo in array )
						view.addPropItem( letterVo, false );
				}
				view.displayPropItem( false );
			}
		}
		
		override protected function nextWordUpdateNotify( event:FightAloneEvent ):void
		{
			view.answerResult( Boolean( event.data ), true );
			super.nextWordUpdateNotify( event );
		}
		
		// 选择泡泡通知对方
		override protected function selectedBubble(vo:LetterBubbleVo):void
		{
			onlineService.selectedBubble( vo );
		}
		
	}
}