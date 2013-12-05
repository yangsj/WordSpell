package app.modules.task.view
{
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;
	import app.modules.task.service.TaskService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskMediator extends BaseMediator
	{
		[Inject]
		public var view:TaskView;
		[Inject]
		public var taskService:TaskService;
		[Inject]
		public var taskModel:TaskModel;
		
		public function TaskMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			addContextListener( TaskEvent.UPDATE_LIST, taskListNotify, TaskEvent );
			
			addViewListener( TaskEvent.TAKE_REWARD, takeRewardHandler, TaskEvent );
			
			taskService.pullTaskList();
		}
		
		private function takeRewardHandler( event:TaskEvent ):void
		{
			var taskVo:TaskVo = event.data as TaskVo;
			taskService.takeReward( taskVo.id );
		}
		
		private function taskListNotify( event:TaskEvent ):void
		{
			view.setDataList( taskModel.taskList );
		}		
		
	}
}