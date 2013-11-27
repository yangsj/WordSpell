package app.modules.fight.view.spell
{
	import app.modules.fight.events.FightAloneEvent;
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
		
		private var isSendInput:Boolean = false;
		
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
			// 显示答案
			addViewListener( SpellEvent.SHOW_ANSWER, showAnswerHandler, SpellEvent );
			
			// start
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, nextWordNotify, FightAloneEvent );
			// 更新数据
			addContextListener( FightAloneEvent.UPDATE_WORD, updateWordHandler, FightAloneEvent );
			// 更新下一个
			addContextListener( FightAloneEvent.NOTIFY_NEXT_WORD, nextWordNotify, FightAloneEvent );
			// 字母拼写正确,增加金币
			addViewListener( FightAloneEvent.ADD_MONEY_EFFECT, addMoneyEffectHandler, FightAloneEvent );
			
			isSendInput = false;
			if ( fightModel.modeType == 5 )
				view.setInitData( fightModel.spellVo );
			
		}
		
		private function showAnswerHandler( event:SpellEvent ):void
		{
			dispatch( new FightAloneEvent( FightAloneEvent.SHOW_ANSWER_ING ));
		}
		
		private function addMoneyEffectHandler( event:FightAloneEvent ):void
		{
			dispatch( new FightAloneEvent(FightAloneEvent.ADD_MONEY_EFFECT, [ true, 1 ] ));
		}
		
		private function inputOverHandler( event:SpellEvent ):void
		{
			if ( isSendInput == false )
			{
				var sequence:Array = [];
				for each ( var vo:LetterBubbleVo in view.inputList ) {
					if ( vo == null ) break;
					sequence.push( vo.id );
				}
				isSendInput = true;
				fightService.inputOver( sequence );
				
				dispatch( new SpellEvent( SpellEvent.ONE_WORD_OVER ));
			}
		}
		
		private function nextWordNotify( event:FightAloneEvent ):void
		{
			isSendInput = false;
			view.setInitData( fightModel.spellVo );
			view.setPos( fightModel.isPractice );
			
			if ( view.btnShowAnswer ) {
				view.btnShowAnswer.visible = fightModel.isPractice;
			}
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