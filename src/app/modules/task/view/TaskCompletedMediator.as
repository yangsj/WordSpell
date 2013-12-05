package app.modules.task.view
{
	import app.modules.task.event.TaskEvent;
	import app.sound.SoundManager;
	import app.sound.SoundType;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-22
	 */
	public class TaskCompletedMediator extends BaseMediator
	{
		public function TaskCompletedMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRemove();
			
			dispatch( new TaskEvent( TaskEvent.TASK_CHECK_COMPLETED ));
			
			// 
			SoundManager.playEffectMusic( SoundType.REWARD_DIAMOND );
		}
		
	}
}