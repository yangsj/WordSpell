package app.modules.fight.view.item
{
	import flash.geom.Point;
	
	import victor.core.AnimationClip;
	import victor.framework.core.BaseSprite;
	
	import victor.framework.core.ViewStruct;
	import victor.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-30
	 */
	public class BubbleRemovedEffect extends BaseSprite
	{
		private var clip:AnimationClip;
		
		public function BubbleRemovedEffect( point:Point )
		{
			x = point.x;
			y = point.y;
			
			this.mouseChildren = false;
			this.mouseEnabled = false;
			
			addChild( new AnimationClip("ui_Skin_BubbleRemoveEffect", 1, loopComplete ) );
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