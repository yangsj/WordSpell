package app.modules.login.preloader
{
	import com.greensock.TweenMax;
	
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	
	import victor.framework.core.BaseScene;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.TextFiledUtil;
	import victor.framework.utils.appStage;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class PreloaderView extends BaseScene
	{
		public var mcProgressBar:MovieClip;
		public var txtProgressValue:TextField;
		
		private var rollWord:PreloaderRollWordLine;
		private var stopFrame:int = 0;
		
		public function PreloaderView()
		{
			super();
			
			// 引用资源
			ui_Skin_Preloader;
			
			this.graphics.beginFill( 0 );
			this.graphics.drawRect( 0, 0, appStage.stageWidth, appStage.stageHeight);
			this.graphics.endFill();
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtProgressValue ||= TextFiledUtil.create( "", 45, 0xffffff );
			addChild( txtProgressValue );
		}
		
		override public function dispose():void
		{
			super.dispose();
			
			if ( rollWord )
			{
				DisplayUtil.removedFromParent( rollWord );
				rollWord.dispose();
				rollWord = null;
			}
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.LOADING );
			mcProgressBar.gotoAndStop( 1 );
			if ( rollWord == null )
			{
				rollWord = new PreloaderRollWordLine();
				rollWord.x = ( appStage.stageWidth - rollWord.width ) >> 1;
				rollWord.y = txtProgressValue.y + txtProgressValue.height + 10;
				addChild( rollWord );
			} else {
				rollWord.clear();
			}
			rollWord.initialize();
			mcProgressBar.addEventListener(Event.ENTER_FRAME, barEnterFrameHandler );
		}
		
		protected function barEnterFrameHandler(event:Event):void
		{
			if ( mcProgressBar.currentFrame < stopFrame ) {
				mcProgressBar.nextFrame();
				txtProgressValue.text = (mcProgressBar.currentFrame + Number(Math.random().toFixed(2))) + "%";
			}
		}
		
		public function setProgressValue( value:Number ):void
		{
			stopFrame = int(value * 100);
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_Preloader";
		}
		
	}
}