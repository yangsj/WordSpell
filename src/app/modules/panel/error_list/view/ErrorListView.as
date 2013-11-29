package app.modules.panel.error_list.view
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.net.FileReference;
	import flash.text.TextField;
	
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
		
		public function ErrorListView()
		{
			super();
		}
		
		public function setVo( list:Vector.<ErrorListVo> ):void
		{
			if ( list )
			{
				createScroll();
				
				listStr = "";
				for ( var i:int = 0; i < 20; i++ )
				{
					var val:String = "第" + i + "行:";
					if ( listStr == "" ) {
						listStr = val;
						txtStr.appendText( val );
					}
					else {
						listStr += "\n\r" + val;
						txtStr.appendText( "\n" + val );
					}
				}
				txtStr.height = txtStr.textHeight + 15;
				
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		private function createScroll():void
		{
			if ( gameScroll == null )
			{
				gameScroll = new GameScrollPanel();
				gameScroll.setTargetAndHeight( listContainer, listContainer.height, listContainer.width );
				
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
			
			setVo( null );
			
			btnExport.addEventListener(MouseEvent.CLICK, btnExportClickHandler );
		}
		
		protected function btnExportClickHandler(event:MouseEvent):void
		{
			if ( listStr ) {
				fileReference = new FileReference();
				fileReference.addEventListener(Event.COMPLETE, saveCompleteHandler );
				fileReference.save( listStr, "error_list.txt" );
			} else {
				Tips.showMouse( "没有需要保存的内容！" );
			}
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