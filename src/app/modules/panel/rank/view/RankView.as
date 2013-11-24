package app.modules.panel.rank.view
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	
	import app.modules.panel.rank.model.RankVo;
	
	import victor.framework.components.TabButtonControl;
	import victor.framework.components.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	import victor.framework.utils.DisplayUtil;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-28
	 */
	public class RankView extends BasePanel
	{
		private var tabName:Array = ["周实力榜", "月实力榜", "综合实力榜", "财富榜", "丰收榜"];
		private var tabControl:TabButtonControl;
		private var gameScroll:GameScrollPanel;
		
		public var listContainer:Sprite;
		
		public function RankView()
		{
		}
		
		public function createList(list:Vector.<RankVo>):void
		{
			if ( list )
			{
				DisplayUtil.removedAll( listContainer );
				var i:int = 0;
				var disty:Number = 40;
				var item:RankItem;
				for each ( var vo:RankVo in list )
				{
					item = RankItem.instance;
					item.setData( vo );
					item.y = disty * i;
					listContainer.addChild( item );
					i++;
				}
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( 0 );
			}
		}
		
		private function createTabButton():void
		{
			tabControl = new TabButtonControl( tabControlHandler );
			
			var mc:MovieClip;
			for ( var i:int = 0; i < 5; i++ )
			{
				mc = _skin.getChildByName( "tab" + i ) as MovieClip;
				mc.setName( tabName[i] );
				tabControl.addTarget( mc, i );
			}
		}
		
		private function tabControlHandler( clickTarget:MovieClip, data:Object ):void
		{
			var list:Vector.<RankVo> = new Vector.<RankVo>();
			var typeName:String = "";
			switch ( data )
			{
				case 0:
					typeName = tabName[data];
					break;
				case 1:
					typeName = tabName[data];
					break;
				case 2:
					typeName = tabName[data];
					break;
				case 3:
					typeName = tabName[data];
					break;
				case 4:
					typeName = tabName[data];
					break;
			}
			if ( typeName )
			{
				var vo:RankVo;
				for ( var i:int = 0; i < 20; i ++ )
				{
					vo = new RankVo();
					vo.honor = "荣誉";
					vo.rank = i+1;
					vo.name = typeName + i;
					vo.level = 2 + int(Math.random() * 20);
					vo.validity = "无限延长";
					list.push( vo );
				}
				createList( list );
			}
		}
		
		override protected function  onceInit():void
		{
			super.onceInit();
			
			gameScroll = new GameScrollPanel();
			gameScroll.setTargetAndHeight( listContainer, 205, 652 );
			
			createTabButton();
		}
		
		override protected function get resNames():Array
		{
			return ["ui_Ranking"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_RankingViewPanel";
		}
		
	}
}