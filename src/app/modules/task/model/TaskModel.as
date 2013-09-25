package app.modules.task.model
{
	import org.robotlegs.mvcs.Actor;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskModel extends Actor
	{
		/**
		 * 是否获得任务列表数据
		 */
		public var hasTaskList:Boolean;
		
		private var _taskList:Vector.<TaskVo>;
		
		public function TaskModel()
		{
			super();
		}
		
		
		
		/**
		 * 更新任务数据
		 * @param taskVo
		 */
		public function updateTask( taskVo:TaskVo ):void
		{
			var index:int = getIndexById( taskVo.id );
			if ( index != -1 )
				taskList[ index ] = taskVo;
		}
		
		/**
		 * 通过任务id获取任务排序号。若没有当前指定任务，则返回-1。
		 * @param id
		 * @return 
		 */
		public function getIndexById( id:int ):int
		{
			var taskVo:TaskVo;
			for ( var key:String in taskList )
			{
				taskVo = taskList[key];
				if ( taskVo && taskVo.id == id )
					return int( key );
			}
			return -1;
		}
		
		/**
		 * 任务列表
		 * @return 
		 */
		public function get taskList():Vector.<TaskVo>
		{
			return _taskList ||= new Vector.<TaskVo>();
		}

	}
}