package app.modules.fight.panel.search
{
	import flash.text.TextField;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightSearchPanel extends FightSearchBasePanel
	{
		public var txtSearch:TextField;
		
		public function FightSearchPanel()
		{
			super();
		}
		
		override protected function beforeRender():void
		{
			super.beforeRender();
			createScroll( 264, 290 );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightSearchPanel";
		}
		
	}
}