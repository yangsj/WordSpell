package app.modules.fight.view.panel
{
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class FightLosePanel extends BasePanel
	{
		/**
		 * 练习本关 按钮
		 */
		public var btnPractice:SimpleButton;
		/**
		 * 下一关 按钮
		 */
		public var btnNext:SimpleButton;
		/**
		 * 再次挑战 按钮
		 */
		public var btnAgain:SimpleButton;
		/**
		 * txtExp
		 */
		public var txtExp:TextField;
		/**
		 * txtMoney
		 */
		public var txtMoney:TextField;
		
		public function FightLosePanel()
		{
			super();
		}
		
		
		override protected function get skinName():String
		{
			return "ui_Skin_Round_LoseMainPanel";
		}
		override protected function get resNames():Array
		{
			return [ "ui_round_losePanel" ];
		}
	}
}