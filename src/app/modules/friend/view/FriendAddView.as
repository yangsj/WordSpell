package app.modules.friend.view
{
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.friend.event.FriendEvent;
	
	import victor.framework.core.BasePanel;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-23
	 */
	public class FriendAddView extends BasePanel
	{
		public var txtInput:TextField;
		public var btnAdd:SimpleButton;
		
		public function FriendAddView()
		{
			isPenetrate = true;
			super();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			txtInput.text = "";
			btnAdd.addEventListener( MouseEvent.CLICK, btnAddHandler );
		}
		
		protected function btnAddHandler(event:MouseEvent):void
		{
			dispatchEvent( new FriendEvent( FriendEvent.ADD_FRIEND ));
		}
		
		override protected function get resNames():Array
		{
			return ["ui_friend"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_FriendAddView";
		}
	}
}