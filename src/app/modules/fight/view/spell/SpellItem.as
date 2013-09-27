package app.modules.fight.view.spell
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.events.FightEvent;
	
	import victor.framework.components.Reflection;
	import victor.framework.interfaces.IDisposable;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class SpellItem implements IDisposable
	{
		private const FRAME_OPEN:String = "frame_open";
		private const FRAME_CLOSE:String = "frame_close";
		
		private var skin:MovieClip;
		public var txtLetter:TextField;
		
		private var _data:SpellItemVo;
		private var _isOpen:Boolean = false;
		
		public function SpellItem( skin:MovieClip )
		{
			this.skin = skin;
			this.skin.mouseChildren = false;
			this.skin.buttonMode = true;
			this.skin.stop();
			this.skin.addEventListener( MouseEvent.CLICK, onClickHandler );
			Reflection.reflection( this, skin );
		}
		
		protected function onClickHandler(event:MouseEvent):void
		{
			if ( _data )
				this.skin.dispatchEvent( new FightEvent( FightEvent.REMOVED_LETTER, _data ));
		}
		
		private function setStatus():void
		{
			this.skin.mouseEnabled = _isOpen;
			this.skin.gotoAndStop( _isOpen ? FRAME_OPEN : FRAME_CLOSE );
			this.txtLetter.visible = _isOpen;
		}
		
		public function setData( itemVo:SpellItemVo ):void
		{
			_data = itemVo;
			
			if ( _data ) txtLetter.text = _data.letter;
			this.skin.mouseEnabled = _isOpen && _data;
		}
		
		public function dispose():void
		{
			if ( skin )
				skin.removeEventListener( MouseEvent.CLICK, onClickHandler );
			skin = null;
			_data = null;
		}
		
		public function get data():SpellItemVo
		{
			return _data;
		}

		/**
		 * 是否开启状态
		 */
		public function get isOpen():Boolean
		{
			return _isOpen;
		}

		/**
		 * @private
		 */
		public function set isOpen(value:Boolean):void
		{
			_isOpen = value;
			setStatus();
		}

	}
}