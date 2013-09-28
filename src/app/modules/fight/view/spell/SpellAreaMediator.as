package app.modules.fight.view.spell
{
	import app.modules.fight.events.FightEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.fight.model.LetterBubbleVo;
	import app.modules.fight.service.FightService;
	
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
		public var fightService:FightService;
		
		public function SpellAreaMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 移除字母
			addViewListener( FightEvent.REMOVED_LETTER, removedLetterHandler, FightEvent );
			// 
			addViewListener( SpellEvent.INPUT_OVER, inputOverHandler, SpellEvent );
			
			
			// 更新数据
			addContextListener( FightEvent.UPDATE_WORD, updateWordHandler, FightEvent );
			// 显示答案
			addContextListener( FightEvent.SHOW_ANSWER, showAnswerHandler, FightEvent );
			// 更新下一个
			addContextListener( FightEvent.NOTIFY_NEXT_WORD, nextWordNotify, FightEvent );
			
			nextWordNotify( null );
		}
		
		private function inputOverHandler( event:SpellEvent ):void
		{
			var sequence:Array = [];
			for each ( var vo:LetterBubbleVo in view.inputList )
			{
				sequence.push( vo.id );
			}
			fightService.inputOver( sequence );
		}
		
		private function nextWordNotify( event:FightEvent ):void
		{
			view.setInitData( fightModel.spellVo );
		}
		
		private function showAnswerHandler( event:FightEvent ):void
		{
			view.showAnswer();
		}
		
		private function updateWordHandler( event:FightEvent ):void
		{
			view.setSingleLetter( event.data as LetterBubbleVo );
		}
		
		private function removedLetterHandler( evnt:FightEvent ):void
		{
			
		}
		
	}
}