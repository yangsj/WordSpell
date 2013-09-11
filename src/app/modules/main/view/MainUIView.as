package app.modules.main.view
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	
	import app.events.ViewEvent;
	
	import victor.framework.core.ViewSprite;
	import victor.framework.core.ViewStruct;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class MainUIView extends ViewSprite
	{
		public var friendPanel:InteractiveObject;
		public var taskPanel:InteractiveObject;
		
		public function MainUIView()
		{
		}
		
		override protected function onceInit():void
		{
			var list:Array = FunctionBtnConfig.functionBtnsList;
			for each (var btnName:String in list )
			{
				var dis:InteractiveObject = this[ btnName ] as Sprite;
				if ( dis )
				{
					if ( dis.hasOwnProperty("mouseChildren"))
						dis["mouseChildren"] = false;
					if ( dis.hasOwnProperty("buttonMode"))
						dis["buttonMode"] = true;
					
					dis.addEventListener(MouseEvent.CLICK, onClickFunsBtnHandler );
				}
			}
		}
		
		protected function onClickFunsBtnHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, event.target.name ));
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.MAIN );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MainMenu";
		}
		
	}
}