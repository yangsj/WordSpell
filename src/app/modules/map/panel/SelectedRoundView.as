package app.modules.map.panel
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.utils.Dictionary;
	
	import app.core.ButtonSkin;
	import app.modules.map.model.ChapterVo;
	import app.modules.map.model.MapVo;
	import app.modules.map.panel.item.GroupItem;
	
	import victor.core.Reflection;
	import app.base.BasePanel;
	import victor.utils.DisplayUtil;
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SelectedRoundView extends BasePanel
	{
		private var skinDict:Dictionary = new Dictionary();
		private var vecList:Vector.<GroupItem>;
		private var bgSkin:Sprite;
		
		public var mapVo:MapVo;
		public var mcTitleName:MovieClip;
		
		public function SelectedRoundView()
		{
		}
		
		override protected function onceInit():void
		{
			DisplayUtil.removedFromParent( btnClose );
			btnClose = ButtonSkin.buttonExit;
			_skin.addChild( btnClose );
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			mcTitleName.gotoAndStop( mapVo.mapId + 1 );
		}
		
		override protected function removedFromStageHandler(event:Event):void
		{
			super.removedFromStageHandler( event );
			clearGroupItems();
		}
		
		override protected function createSkin():void
		{
			DisplayUtil.removedAll( this );
			// 
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
			
			// 创建背景
			bgSkin = skinDict[ bgSkinName ];
			if ( bgSkin == null )
			{
				bgSkin = getObj( bgSkinName ) as Sprite;
				skinDict[ bgSkinName ] = bgSkin;
			}
			addChildAt( bgSkin, 0 );
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
				groupItem = new GroupItem( mcGroup, i );
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
			return ["map_chapter_bg", "map_chapter_list" ];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MapChapterRoundList";
		}
		
		protected function get bgSkinName():String
		{
			return "ui_Skin_MapChapterBg_" + mapVo.mapId;
		}
		
	}
}