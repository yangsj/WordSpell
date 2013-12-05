package app.modules.login.preloader
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import victor.framework.utils.appStage;
	
	import victor.framework.core.BaseScene;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.TextFiledUtil;
	
	
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
			
			if ( this.data == null )
			{
				if ( rollWord == null )
				{
					rollWord = new PreloaderRollWordLine();
					rollWord.x = ( width - rollWord.width ) >> 1;
					rollWord.y = txtProgressValue.y + txtProgressValue.height + 10;
				}
				addChild( rollWord );
				rollWord.initialize();
			}
		}
		
		public function setProgressValue( value:Number ):void
		{
			txtProgressValue.text = ( value * 100 ).toFixed( 2 ) + "%";
//			mcProgressBar.scaleX = Math.min( value, 1 );
			mcProgressBar.gotoAndStop( int(value * 100) );
			addChild( txtProgressValue );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_Preloader";
		}
		
	}
}