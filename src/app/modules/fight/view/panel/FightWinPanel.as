package app.modules.fight.view.panel
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class FightWinPanel extends BasePanel
	{
		/**
		 * 获得的经验 文本显示
		 */
		public var txtExp:TextField;
		/**
		 * 获得的宝石 显示文本
		 */
		public var txtMoney:TextField;
		/**
		 * 星级评分mc， 包含3帧
		 */
		public var mcStar:MovieClip;
		/**
		 * 练习本关 按钮
		 */
		public var btnPractice:SimpleButton;
		
		public function FightWinPanel()
		{
			super();
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_Round_WinMainPanel";
		}
		override protected function get resNames():Array
		{
			return [ "ui_round_winPanel" ];
		}
		
	}
}