package app.modules.main.view
{
	import flash.display.Bitmap;
	import flash.display.DisplayObject;
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Shape;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	
	import app.data.BaseConfig;
	import app.data.vo.LevelExpItemVo;
	import app.events.ViewEvent;
	import app.managers.LoaderManager;
	import app.utils.NumCreate;
	
	import victor.framework.core.ViewSprite;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.DisplayUtil;
	import victor.framework.utils.MathUtil;
	import app.modules.main.FunctionBtnConfig;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-10
	 */
	public class MainUIView extends ViewSprite
	{
		// 等级数字显示容器
		public var levelContainer:Sprite;
		// 经验条
		public var expBar:MovieClip;
		
		// 上一次更新的经验值
		private var expCache:int = -1;
		// 上一次更新的等级
		private var levelCache:int = -1;
		
		private var levelNumCreate:NumCreate;
		private var levelNumSprite:Shape;
		
		public function MainUIView()
		{
		}
		
		public function updateLevelExp( level:int, exp:int ):void
		{
			if ( expCache != exp )
			{
				expCache = exp;
				var levelExpItemVo:LevelExpItemVo = BaseConfig.levelExp.getItemByExp( exp );
				var curExp:int = levelExpItemVo.curExp;
				var nextExp:int = levelExpItemVo.nextExp;
				var percent:int;
				if ( !MathUtil.isRange( exp, curExp, nextExp ))
					percent = 100;
				else
				{
					percent = int(((exp - curExp )/(nextExp - curExp)) * 100);
				}
				expBar.gotoAndStop( percent );
			}
			if ( level != levelCache )
			{
				levelCache = level;
				levelNumCreate ||= new NumCreate(LoaderManager.getObj( "ui_Skin_LevelNumber" ) as MovieClip);
				levelNumSprite = levelNumCreate.creatNumber( level );
				levelNumSprite.x = -levelNumSprite.width >> 1;
				DisplayUtil.removedAll( levelContainer );
				levelContainer.addChild( levelNumSprite );
			}
		}
		
		override protected function onceInit():void
		{
			var list:Array = FunctionBtnConfig.functionBtnsList;
			for each (var btnName:String in list )
			{
				var dis:DisplayObject = _skin[ btnName ] as DisplayObject;
				if ( dis )
				{
					if ( dis.hasOwnProperty("mouseChildren"))
						dis["mouseChildren"] = false;
					if ( dis.hasOwnProperty("buttonMode"))
						dis["buttonMode"] = true;
					
					dis.addEventListener(MouseEvent.CLICK, onClickFunsBtnHandler );
				}
			}
		}
		
		protected function onClickFunsBtnHandler(event:MouseEvent):void
		{
			dispatchEvent( new ViewEvent( ViewEvent.SHOW_VIEW, event.target.name ));
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.MAIN );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_MainMenu";
		}
		
	}
}