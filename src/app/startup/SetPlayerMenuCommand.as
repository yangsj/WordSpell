package app.startup
{
	import app.GameConfig;
	import app.managers.ExternalManager;
	
	import victor.core.ContextMenuDefine;
	import victor.framework.core.BaseCommand;
	import victor.framework.debug.Debug;
	
	
	/**
	 * …… 设置菜单
	 * @author 	yangsj 
	 * 			2013-12-23
	 */
	public class SetPlayerMenuCommand extends BaseCommand
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function SetPlayerMenuCommand()
		{
			super();
		}
		
		override public function execute():void
		{
			Debug.debug( "to set flash player system menu" );
			var vec:Vector.<Array> = new Vector.<Array>();
			vec.push( ["重载游戏", ExternalManager.reload, true] );
			vec.push( ["最后更新：" + GameConfig.VERSION, null, false] );
			new ContextMenuDefine( contextView, vec, true );
		}
		
		
	}
}