package app.startup
{
	import app.events.ViewEvent;
	import app.modules.ViewName;
	import app.modules.scene.event.SceneEvent;
	
	import victor.framework.core.BaseCommand;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class EnterGameCommand extends BaseCommand
	{
		public function EnterGameCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			// 显示场景
			dispatch( new SceneEvent( SceneEvent.SHOW ));
			// 显示聊天窗口
			dispatch( new ViewEvent( ViewEvent.SHOW_VIEW, ViewName.Chat ));
			// 关闭Preloader
			dispatch( new ViewEvent( ViewEvent.HIDE_VIEW, ViewName.Preloader ));
		}
		
	}
}