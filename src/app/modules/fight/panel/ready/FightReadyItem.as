package app.modules.fight.panel.ready
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import victor.framework.components.Reflection;
	import victor.framework.interfaces.IDisposable;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-19
	 */
	public class FightReadyItem implements IDisposable
	{
		/**
		 * btnReadyed
		 */
		public var btnReadyed:SimpleButton;
		/**
		 * btnReadying
		 */
		public var btnReadying:SimpleButton;
		/**
		 * mcSex
		 */
		public var mcSex:MovieClip;
		/**
		 * txtPlayer
		 */
		public var txtPlayer:TextField;
		/**
		 * txtGrade
		 */
		public var txtGrade:TextField;
		/**
		 * txtLevel
		 */
		public var txtLevel:TextField;
		/**
		 * mcBg
		 */
		public var mcBg:MovieClip;
		
		public function FightReadyItem( skin:Sprite )
		{
			Reflection.reflection( this, skin );
			setSex( 0 );
			btnReadying.addEventListener(MouseEvent.CLICK, onBtnReadingHandler );
		}
		
		protected function onBtnReadingHandler(event:MouseEvent):void
		{
			btnReadying.dispatchEvent( new FightReadyEvent( FightReadyEvent.READY, null, true ));
		}
		
		public function dispose():void
		{
			
			btnReadyed = null;
			btnReadying = null;
			mcSex = null;
			txtPlayer = null;
			txtGrade = null;
			txtLevel = null;
			mcBg = null;
		}
		
		public function setData():void
		{
			
		}
		
		private function setSex( sex:int ):void
		{
			mcBg.gotoAndStop( sex + 1 );
			mcSex.gotoAndStop( sex + 1 );
		}
		
	}
}