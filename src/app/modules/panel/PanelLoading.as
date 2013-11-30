package app.modules.panel
{
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import victor.framework.utils.appStage;
	
	import victor.framework.core.ViewSprite;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.TextFiledUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-8-28
	 */
	public class PanelLoading extends ViewSprite
	{
		private var txtProgress:TextField;
		
		public function PanelLoading()
		{
			this.graphics.beginFill( 0, 0.6 );
			this.graphics.drawRoundRect( 0, 0, 200, 200, 15 );
			this.graphics.endFill();
			
			var txt:TextField = TextFiledUtil.create("_sans", 25, 0xffffff, TextFormatAlign.CENTER );
			txt.text = "已加载";
			txt.width = 104;
			txt.height = 33;
			addChild( txt );
			
			txtProgress = TextFiledUtil.create( "Verdana", 35, 0xffffff, TextFormatAlign.CENTER );
			txtProgress.width = 191;
			txtProgress.height = 46;
			addChild( txtProgress );
			
			txt.x = ( width - txt.width ) >> 1;
			txt.y = ( height - ( txt.height + txtProgress.height )) >> 1;
			txtProgress.x = ( width - txtProgress.width ) >> 1;
			txtProgress.y = txt.y + txt.height;
			
			x = ( appStage.stageWidth - width ) >> 1;
			y = ( appStage.stageHeight -height ) >> 1;
		}
		
		public function setProgressValue( perent:Number ):void
		{
			txtProgress.text = (perent * 100).toFixed( 2 ) + "%";
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.LOADING );
			
			appStage.mouseChildren = false;
		}

		override public function hide():void
		{
			super.hide();
			
			appStage.mouseChildren = true;
		}
		
		
		
		private static var _instance:PanelLoading;
		
		public static function get instance():PanelLoading
		{
			return _instance ||= new PanelLoading();
		}
		
		
	}
}