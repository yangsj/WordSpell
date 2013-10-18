package app.modules.fight.panel.matching
{
	import flash.text.TextField;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightMatchingPanel extends BasePanel
	{
		public var txtPlayerSelf:TextField;
		
		public function FightMatchingPanel()
		{
			super();
		}
		
		override protected function get resNames():Array
		{
			return ["ui_matching" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightMatchingPanel";
		}
		
	}
}