package app.modules.panel.error_list.view
{
	import flash.display.Bitmap;
	import flash.display.BitmapData;
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	import flash.utils.ByteArray;
	
	import app.core.Tips;
	import app.modules.panel.error_list.model.ErrorListVo;
	
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-30
	 */
	public class ErrorListView extends BasePanel
	{
		/**
		 * listContainer
		 */
		public var listContainer:MovieClip;
		/**
		 * btnExport
		 */
		public var btnExport:SimpleButton;
		
		private var txtStr:TextField;
		private var fileReference:FileReference;
		private var gameScroll:GameScrollPanel;
		private var listStr:String = "";
		private var englishBitmap:Bitmap;
		private var chineseBitmap:Bitmap;
		private var listWidth:Number = 100;
		
		public function ErrorListView()
		{
			super();
		}
		
		public function setArrayList( list:Array ):void
		{
			if ( list )
			{
				var english:String = "";
				var chinese:String = "";
				createScroll();
				txtStr.text = "";
				listStr = "";
				for each ( var val:String in list )
				{
					if ( listStr == "" ) {
						listStr = val + ",中文";
						english = val;
						chinese = "中文";
					}
					else {
						listStr += "\t\n" + val + ",中文";
						english += "\n" + val;
						chinese += "\n中文";
					}
				}
				var bitx:Number = txtStr.x;
				var bity:Number = txtStr.y;
				var tarw:Number = 0;
				
				DisplayUtil.removedFromParent( englishBitmap );
				englishBitmap = getTextBitmap( english );
				englishBitmap.x = bitx;
				englishBitmap.y = bity;
				listContainer.addChild( englishBitmap );
				tarw = bitx + englishBitmap.width;
				
				DisplayUtil.removedFromParent( chineseBitmap );
				chineseBitmap = getTextBitmap( chinese );
				chineseBitmap.x = tarw + ( (listWidth - tarw) - chineseBitmap.width ) * 0.5;
				chineseBitmap.y = bity;
				listContainer.addChild( chineseBitmap );
				
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		private function getTextBitmap( msg:String ):Bitmap
		{
			txtStr.text = msg;
			txtStr.width = txtStr.textWidth + 30;
			txtStr.height = txtStr.textHeight + 20;
			
			var bitmap:Bitmap = new Bitmap( new BitmapData( txtStr.width, txtStr.height, true, 0), "auto", true );
			bitmap.bitmapData.draw( txtStr );
			return bitmap;
		}
		
		public function setVo( list:Vector.<ErrorListVo> ):void
		{
//			if ( list )
//			{
//				createScroll();
//				
//				listStr = "";
//				for ( var i:int = 0; i < 20; i++ )
//				{
//					var val:String = "第" + i + "行:";
//					if ( listStr == "" ) {
//						listStr = val + ",中文";
//						txtStr.appendText( val );
//					}
//					else {
//						listStr += "\n\r" + val;
//						txtStr.appendText( "\n" + val );
//					}
//				}
//				txtStr.height = txtStr.textHeight + 15;
//				
//				gameScroll.updateMainHeight( listContainer.height );
//				gameScroll.setPos( 0 );
//			}
		}
		
		private function createScroll():void
		{
			if ( gameScroll == null )
			{
				gameScroll = new GameScrollPanel();
				gameScroll.setTargetAndHeight( listContainer, listContainer.height, listWidth );
				
				DisplayUtil.removedAll( listContainer );
				listContainer.addChild( txtStr );
				txtStr.height = txtStr.textHeight;
				
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			txtStr = listContainer.getChildByName( "txtStr" ) as TextField;
			txtStr ||= new TextField();
			txtStr.mouseEnabled = false;
			txtStr.text = "";
			txtStr.visible = false;
			
			listWidth = listContainer.width;
			
			btnExport.visible = false;
			btnExport.addEventListener(MouseEvent.CLICK, btnExportClickHandler );
		}
		
		protected function btnExportClickHandler(event:MouseEvent):void
		{
			if ( listStr ) {
				
				var byte:ByteArray = new ByteArray();
				byte.writeUTFBytes( listStr );
				
				fileReference = new FileReference();
				fileReference.addEventListener(Event.COMPLETE, saveCompleteHandler );
				fileReference.addEventListener(Event.SELECT, selectedDirHandler );
				fileReference.save( byte, "error_list.txt" );//txt|doc|csv|rtf
			} else {
				Tips.showMouse( "没有需要保存的内容！" );
			}
		}
		
		protected function selectedDirHandler(event:Event):void
		{
		}
		
		protected function saveCompleteHandler(event:Event):void
		{
			Tips.showCenter( "保存成功！" );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_ErrorWordsListPanel";
		}
		
		override protected function get resNames():Array
		{
			return [ "ui_Personal" ];
		}
		
	}
}