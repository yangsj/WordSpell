package app.modules.task.view
{
	import app.modules.task.event.TaskEvent;
	
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
		}
		
	}
}