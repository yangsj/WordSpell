package app.modules.fight.panel.result
{
	import flash.display.SimpleButton;
	import flash.text.TextField;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-17
	 */
	public class FightOnlineResultPanel extends BasePanel
	{/**
		* btnAgain
		*/
		public var btnAgain:SimpleButton;
		/**
		 * btnCancel
		 */
		public var btnCancel:SimpleButton;
		/**
		 * txtPlayerName1
		 */
		public var txtPlayerName1:TextField;
		/**
		 * txtExp2
		 */
		public var txtExp2:TextField;
		/**
		 * txtExp1
		 */
		public var txtExp1:TextField;
		/**
		 * txtMoney1
		 */
		public var txtMoney1:TextField;
		/**
		 * txtItems1
		 */
		public var txtItems1:TextField;
		/**
		 * txtPlayerName2
		 */
		public var txtPlayerName2:TextField;
		/**
		 * txtMoney2
		 */
		public var txtMoney2:TextField;
		/**
		 * txtItems2
		 */
		public var txtItems2:TextField;
		
		public function FightOnlineResultPanel()
		{
			super();
		}
		
		public function setData():void
		{
			
		}
		
		override protected function get resNames():Array
		{
			return ["ui_fight_online_result"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FightOnlineResultPanel";
		}
		
	}
}