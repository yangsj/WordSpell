package app.modules.fight.view.spell
{
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightAloneService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class SpellAreaMediator extends BaseMediator
	{
		[Inject]
		public var view:SpellArea;
		[Inject]
		public var fightModel:FightModel;
		[Inject]
		public var fightService:FightAloneService;
		
		public function SpellAreaMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 移除字母
			addViewListener( FightAloneEvent.REMOVED_LETTER, removedLetterHandler, FightAloneEvent );
			// 输入结束
			addViewListener( SpellEvent.INPUT_OVER, inputOverHandler, SpellEvent );
			
			// 
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, nextWordNotify, FightAloneEvent );
			// 更新数据
			addContextListener( FightAloneEvent.UPDATE_WORD, updateWordHandler, FightAloneEvent );
			// 显示答案
			addContextListener( FightAloneEvent.SHOW_ANSWER, showAnswerHandler, FightAloneEvent );
			// 更新下一个
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordNotify, FightAloneEvent );
			
			if ( fightModel.modeType == 5 )
				view.setInitData( fightModel.spellVo );
			
		}
		
		private function inputOverHandler( event:SpellEvent ):void
		{
			var sequence:Array = [];
			for each ( var vo:LetterBubbleVo in view.inputList )
			{
				if ( vo == null )
					break;
				sequence.push( vo.id );
			}
			fightService.inputOver( sequence );
		}
		
		private function nextWordNotify( event:* ):void
		{
			view.setInitData( fightModel.spellVo );
		}
		
		private function showAnswerHandler( event:FightAloneEvent ):void
		{
			view.showAnswer();
		}
		
		private function updateWordHandler( event:FightAloneEvent ):void
		{
			view.setSingleLetter( event.data as LetterBubbleVo );
		}
		
		private function removedLetterHandler( evnt:FightAloneEvent ):void
		{
		}
		
	}
}