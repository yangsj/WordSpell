package app.modules.map.panel.item
{
	import flash.display.MovieClip;
	
	import app.modules.map.main.item.MapItemBase;
	import app.modules.map.model.ChapterVo;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-25
	 */
	public class GroupItem extends MapItemBase
	{
		private var vecListItem:Vector.<RoundItem>;
		private var chapterVo:ChapterVo;
		
		public function GroupItem( skin:MovieClip )
		{
			super( skin );
			skin.mouseChildren = true;
			skin.buttonMode = false;
			skin.mouseEnabled = false;
			createItems();
		}
		
		override public function dispose():void
		{
			super.dispose();
			clearItems();
			chapterVo = null;
		}
		
		private function clearItems():void
		{
			if ( vecListItem )
			{
				while ( vecListItem.length > 0 )
					vecListItem.pop().dispose();
			}
			vecListItem = null;
		}
		
		private function createItems():void
		{
			var item:RoundItem;
			vecListItem ||= new Vector.<RoundItem>();
			for ( var i:int = 0; i < 5; i++ )
			{
				item = new RoundItem( skin.getChildByName( "r" + i ) as MovieClip );
				vecListItem.push( item );
			}
		}
		
		public function setData( chapterVo:ChapterVo ):void
		{
			this.chapterVo = chapterVo;
			var item:RoundItem;
			for ( var i:int = 0; i < 5; i++ )
			{
				item = vecListItem[ i ];
				item.setData( chapterVo.roundList[ i ] );
			}
		}
	}
}