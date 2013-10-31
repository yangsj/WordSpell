package app.modules.fight.view.item
{
	import flash.display.MovieClip;
	import flash.geom.Point;
	
	import app.core.SpriteClip;
	import app.modules.TempleteSprite;
	
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.MovieClipUtil;
	
	
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
			
//			spriteClip = new SpriteClip("ui_Skin_BubbleRemoveEffect", 1, loopComplete );
			addChild( new SpriteClip("ui_Skin_BubbleRemoveEffect", 1, loopComplete ) );
			
//			setSkinWithName( "ui_Skin_BubbleRemoveEffect" );
			
			ViewStruct.addChild( this, ViewStruct.EFFECT );

//			MovieClipUtil.playMovieClip( _skin as MovieClip, playComplete );
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