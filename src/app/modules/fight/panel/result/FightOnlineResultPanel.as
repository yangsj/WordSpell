package app.modules.fight.panel.result
{
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.events.FightOnlineEvent;
	import app.modules.fight.model.FightEndVo;
	
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
		
		override protected function onceInit():void
		{
			super.onceInit();
			btnCancel.addEventListener( MouseEvent.CLICK, btnCancelHandler );
			btnAgain.addEventListener( MouseEvent.CLICK, btnAgainHandler );
		}
		
		protected function btnAgainHandler(event:MouseEvent):void
		{
			dispatchEvent( new Event( FightOnlineEvent.AGAIN_BATTLE ));
		}
		
		protected function btnCancelHandler(event:MouseEvent):void
		{
			btnClose.dispatchEvent( new MouseEvent( MouseEvent.CLICK ));
		}
		
		public function setPlayer( winName:String, loseName:String ):void
		{
			txtPlayerName1.text = winName;
			txtPlayerName2.text = loseName;
		}
		
		public function setData( winVo:FightEndVo, loseVo:FightEndVo ):void
		{
			txtExp1.text = winVo.addExp + "";
			txtMoney1.text = winVo.addMoney + "";
			txtItems1.text = "";
			
			txtExp2.text = loseVo.addExp + "";
			txtMoney2.text = loseVo.addMoney + "";
			txtItems2.text = "";
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