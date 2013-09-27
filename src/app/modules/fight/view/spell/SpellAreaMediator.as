package app.modules.fight.view.spell
{
	import app.modules.fight.events.FightEvent;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class SpellAreaMediator extends BaseMediator
	{
		public function SpellAreaMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 移除字母
			addViewListener( FightEvent.REMOVED_LETTER, removedLetterHandler, FightEvent );
			
			// 更新数据
			addContextListener( FightEvent.UPDATE_WORD, updateWordHandler, FightEvent );
			// 显示答案
			addContextListener( FightEvent.SHOW_ANSWER, showAnswerHandler, FightEvent );
		}
		
		private function showAnswerHandler( event:FightEvent ):void
		{
			
		}
		
		private function updateWordHandler( evnt:FightEvent ):void
		{
			
		}
		
		private function removedLetterHandler( evnt:FightEvent ):void
		{
			
		}
		
	}
}