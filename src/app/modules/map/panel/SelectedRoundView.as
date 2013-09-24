package app.modules.map.panel
{
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.text.TextField;
	import flash.utils.Dictionary;
	
	import app.modules.map.model.MapVo;
	
	import victor.framework.components.Reflection;
	import victor.framework.core.BasePanel;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-22
	 */
	public class SelectedRoundView extends BasePanel
	{
		private static const names:Array = ["加拿大大熊湖Great Bear Lake","西澳大利亚沙漠（Western Desert）","澳大利亚凯恩斯热带雨林","美国雷尼尔山Mt. Rainier","埃尔斯米尔岛","Ellesmere Island 天空"];
		
		private var mapVo:MapVo;
		
		private var skinDict:Dictionary = new Dictionary();
		
		public var txtName:TextField;
		
		public function SelectedRoundView()
		{
		}
		
		override protected function addedToStageHandler(event:Event):void
		{
			super.addedToStageHandler( event );
			
			txtName.y =3;
			txtName.text = names[ mapVo.mapId ];
			_skin.addChild( txtName );
		}
		
		override protected function loadComplete():void
		{
			DisplayUtil.removedAll( this, false );
			_skin = skinDict[ skinName ];
			if ( _skin == null )
			{
				_isInit = false;
			}
			else
			{
				Reflection.reflection( this, _skin );
				addChild( _skin );
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