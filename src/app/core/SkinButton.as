package app.core
{
	import flash.display.InteractiveObject;
	
	import app.managers.LoaderManager;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-31
	 */
	public class SkinButton
	{
		public function SkinButton()
		{
		}
		
		/**
		 * 主界面退出按钮
		 * @return 
		 * 
		 */
		public static function get buttonExit():InteractiveObject
		{
			var skin:InteractiveObject = LoaderManager.getObj( "ui_Skin_ButtonExit" ) as InteractiveObject;
			skin.x = 883.25;
			skin.y = 6.85;
			return skin;
		}
		
		
	}
}