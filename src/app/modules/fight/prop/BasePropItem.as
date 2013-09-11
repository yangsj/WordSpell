package app.modules.fight.prop
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class BasePropItem extends Sprite
	{
		public function BasePropItem()
		{
			super();
			this.mouseChildren = false;
			addEventListener( MouseEvent.CLICK, onClickHandler );
		}
		
		protected function onClickHandler( event:MouseEvent ):void
		{
			dispatchEvent( new PropEvent( PropEvent.USE_PROP ));
		}
		
		/**
		 * 更新数据
		 * @param propVo
		 */
		public function update( propVo:PropVo ):void
		{
		}
		
		
		
	}
}