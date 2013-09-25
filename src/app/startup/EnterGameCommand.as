package app.startup
{
	import app.data.GameData;
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.friend.model.FriendModel;
	import app.modules.main.model.MainModel;
	import app.modules.map.model.MapModel;
	import app.modules.model.PackModel;
	import app.modules.task.model.TaskModel;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class EnterGameCommand extends BaseCommand
	{
		[Inject]
		public var friendModel:FriendModel;
		[Inject]
		public var taskModel:TaskModel;
		[Inject]
		public var mapModel:MapModel;
		[Inject]
		public var gameDb:GameData;
		[Inject]
		public var packModel:PackModel;
		[Inject]
		public var mainModel:MainModel;
		
		public function EnterGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			if　( mainModel.hasEnterGame )
				return ;
			
			// 主资源是否加载完成|是否有玩家数据|是否有地图数据|是否有好友数据|是否有任务数据|是否有背包数据
			if ( mainModel.hasLoadCompleted && gameDb.hasSelfVo && mapModel.hasMapList )
			{
				mainModel.hasEnterGame = true;
				enterGame();
			}
		}
		
		private function enterGame():void
		{
			var displayView:Array = [ ViewName.MainUI, ViewName.MapWorld, ViewName.Chat ];
			
			for each (var viewName:String in displayView )
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, viewName ));
			
			// 关闭Preloader
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.Preloader ));
		}
		
	}
}