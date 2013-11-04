package app.modules.fight.view.item
{
	import flash.geom.Point;
	
	import app.core.SpriteClip;
	import app.modules.TempleteSprite;
	
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-30
	 */
	public class BubbleRemovedEffect extends TempleteSprite
	{
		private var spriteClip:SpriteClip;
		
		public function BubbleRemovedEffect( point:Point )
		{
			x = point.x;
			y = point.y;
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			addChild( new SpriteClip("ui_Skin_BubbleRemoveEffect", 1, loopComplete ) );
			ViewStruct.addChild( this, ViewStruct.EFFECT );
		}
		
		private function loopComplete():void
		{
			playComplete();
		}
		
		private function playComplete():void
		{
			DisplayUtil.removedAll( this );
			DisplayUtil.removedFromParent( this );
		}
	}
}