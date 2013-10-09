package app.modules.map.panel.item
{
	import flash.display.MovieClip;
	import flash.events.MouseEvent;
	
	import app.core.Tips;
	import app.modules.map.main.item.MapItemBase;
	import app.modules.map.model.RoundVo;
	import app.modules.map.panel.event.SelectedRoundEvent;
	
	import victor.framework.components.Reflection;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-25
	 */
	public class RoundItem extends MapItemBase
	{
		private var roundVo:RoundVo;
		
		public var mcStar:MovieClip;
		public var mcTarget:MovieClip;
		
		public function RoundItem( skin:MovieClip )
		{
			super( skin );
			Reflection.reflection( this, skin );
			mcStar.stop();
			mcTarget.stop();
		}
		
		override protected function onClickHandler(event:MouseEvent):void
		{
			if ( roundVo.isOpen )
				skin.dispatchEvent( new SelectedRoundEvent( SelectedRoundEvent.SELECTED_ROUND, roundVo, true ));
			else Tips.showMouse( "未开启！" );
		}
		
		public function setData( roundVo:RoundVo ):void
		{
			this.roundVo = roundVo;
			
			if ( roundVo.starNum == 0 || !roundVo.isOpen)
				mcStar.visible = false;
			else
			{
				mcStar.visible = true;
				mcStar.gotoAndStop( roundVo.starNum );
			}
			
			mcTarget.gotoAndStop( roundVo.isOpen ? 1 : 2 );
			
		}
		
		override public function dispose():void
		{
			super.dispose();
			roundVo = null;
			mcStar = null;
			mcTarget = null;
		}
		
	}
}