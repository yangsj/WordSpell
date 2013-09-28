package app.modules.map.panel
{
	import flash.display.MovieClip;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.modules.map.model.ChapterVo;
	import app.modules.map.model.MapVo;
	import app.modules.map.panel.item.GroupItem;
	
	import victor.framework.components.Reflection;
	import victor.framework.core.BasePanel;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SelectedRoundView extends BasePanel
	{
		private var skinDict:Dictionary = new Dictionary();
		private var vecList:Vector.<GroupItem>;
		
		public var txtName:TextField;
		public var mapVo:MapVo;
		
		public function SelectedRoundView()
		{
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			
			txtName.y =3;
			txtName.text = mapVo.mapName;
			_skin.addChild( txtName );
		}
		
		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler( event );
			clearGroupItems();
		}
		
		override protected function createSkin():void
		{
			_skin = skinDict[ skinName ];
			if ( _skin == null )
			{
				_isInit = false;
				super.createSkin();
				skinDict[ skinName ] = _skin;
			}
			else 
			{
				addChild( _skin );
				Reflection.reflection( this, _skin );
			}
			createGroupItems();
		}
		
		override protected function transitionIn():void
		{
		}
		
		override protected function transitionOut( delay:Number = 0.3 ):void
		{
			super.transitionOut( 0 );
		}
		
		private function clearGroupItems():void
		{
			if ( vecList )
			{
				while ( vecList.length > 0 )
					vecList.pop().dispose();
				vecList = null;
			}
		}
		
		private function createGroupItems():void
		{
			clearGroupItems();
			vecList = new Vector.<GroupItem>();
			var mcGroup:MovieClip;
			var groupItem:GroupItem;
			for (var i:int = 0; i < 10; i++ )
			{
				mcGroup = _skin.getChildByName( "c" + i ) as MovieClip;
				groupItem = new GroupItem( mcGroup );
				vecList.push( groupItem );
			}
		}
		
		public function setData( list:Vector.<ChapterVo> ):void
		{
			mapVo.chapterList = list;
			var groupItem:GroupItem;
			for ( var i:int = 0; i < 10; i++ )
			{
				groupItem = vecList[ i ];
				groupItem.setData( list[ i ] );
			}
		}
		
		override public function set data(value:Object):void
		{
			super.data = value;
			mapVo = value as MapVo;
		}
		
		override protected function get resNames():Array
		{
			return ["map_chapter_" + mapVo.mapId ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MapChapter_" + mapVo.mapId;
		}
		
	}
}