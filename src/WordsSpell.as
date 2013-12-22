package
{
	import flash.display.Sprite;
	import flash.display.StageAlign;
	import flash.display.StageScaleMode;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.ui.ContextMenu;
	import flash.ui.ContextMenuBuiltInItems;
	import flash.ui.ContextMenuItem;
	
	import app.AppContext;
	
	import victor.utils.appStage;
	
	[SWF( width = "960", height = "560", frameRate = "60" )]
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-2
	 */
	public class WordsSpell extends Sprite
	{
		public function WordsSpell()
		{
			if ( stage )
				initApp();
			else addEventListener( Event.ADDED_TO_STAGE, initApp );
		}
		
		private function initApp( event:Event = null ):void
		{
			removeEventListener( Event.ADDED_TO_STAGE, initApp );
			
			appStage = stage;
			appStage.align = StageAlign.TOP_LEFT;
			appStage.scaleMode = StageScaleMode.NO_SCALE;
			appStage.color = 0;
			
			new AppContext( this );
			
			myContextMenu = new ContextMenu();
			removeDefaultItems();
			addCustomMenuItems();
			this.contextMenu = myContextMenu;
		}
		
		
		private var myContextMenu:ContextMenu;
		private function removeDefaultItems():void {
			myContextMenu.hideBuiltInItems();
			var defaultItems:ContextMenuBuiltInItems = myContextMenu.builtInItems;
			defaultItems.print = true;
		}
		
		private function addCustomMenuItems():void {
			var item:ContextMenuItem = new ContextMenuItem("victor雨山");
			myContextMenu.customItems.push(item);
		}
		
		
	}
}