package app.modules.panel.personal.view
{
	import victor.framework.core.BasePanel;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-12
	 */
	public class PersonalPanel extends BasePanel
	{
		public function PersonalPanel()
		{
		}
		
		override protected function get resNames():Array
		{
			return ["ui_Personal"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_PersonalViewPanel";
		}
		
	}
}