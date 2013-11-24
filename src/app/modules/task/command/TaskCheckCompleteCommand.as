package app.modules.task.command
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.task.model.TaskModel;
	import app.modules.task.model.TaskVo;

	import victor.framework.core.BaseCommand;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-11-24
	 */
	public class TaskCheckCompleteCommand extends BaseCommand
	{
		[Inject]
		public var taskModel:TaskModel;


		public function TaskCheckCompleteCommand()
		{
			super();
		}

		override public function execute():void
		{
			var cacheCompleteTask:Vector.<TaskVo> = taskModel.cacheCompleteTask;
			if ( cacheCompleteTask && cacheCompleteTask.length > 0 )
			{
				var taskVo:TaskVo = cacheCompleteTask.shift();
				dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.TaskCompleted, taskVo ));
			}
		}

	}
}
