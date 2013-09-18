package app.modules.friend.view.rightMenu
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.managers.LoaderManager;
	
	import victor.framework.components.Reflection;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-18
	 */
	public class RightMenuItem extends Sprite
	{
		// ui skin
		private var skin:Sprite;
		public var txtLabel:TextField;
		public var itemBg:MovieClip;
		
		// vars
		private var data:Array;
		
		public function RightMenuItem()
		{
			super();
			
			skin = LoaderManager.getObj( "ui_Skin_RightMenuItem" ) as Sprite;
			addChild( skin );
			Reflection.reflection( this, skin );
			mouseChildren = false;
			buttonMode = true;
		}
		
		public function setVo( ary:Array ):void
		{
			addListeners();
			itemBg.gotoAndStop( MouseEvent.MOUSE_OUT );
			txtLabel.text = ary[0];
			data = ary;
		}
		
		private function removeListeners():void
		{
			removeEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			removeEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			removeEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			removeEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		private function addListeners():void
		{
			addEventListener( Event.REMOVED_FROM_STAGE, removedFromStageHandler );
			addEventListener( MouseEvent.MOUSE_OVER, mouseHandler );
			addEventListener( MouseEvent.MOUSE_OUT, mouseHandler );
			addEventListener( MouseEvent.CLICK, mouseHandler );
		}
		
		protected function mouseHandler( event:MouseEvent ):void
		{
			var type:String = event.type;
			if ( type == MouseEvent.CLICK )
				dispatchEvent( new RightMenuEvent( RightMenuEvent.SELECTED, data[1], true ) );
			else itemBg.gotoAndStop( type );
		}
		
		protected function removedFromStageHandler(event:Event):void
		{
			removeListeners();
		}
		
	}
}