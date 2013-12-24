package app.modules.fight.view.prop.item
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.core.Tips;
	import app.events.PackEvent;
	import app.modules.model.vo.ItemVo;
	
	import victor.core.Reflection;
	import victor.framework.manager.LoaderManager;
	import victor.framework.manager.TickManager;
	import victor.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class PropItem extends Sprite
	{
		public static const POS_LEFT:int = 0;
		public static const POS_RIGHT:int = 1;
		public static const POS_DOWN:int = 2;
		
		private var _data:ItemVo;
		private var _isCanClick:Boolean = true;
		private var _timeNum:int= 0;
		
		private var _skin:Sprite;
		
		// 物品剩余数量
		public var txtNum:TextField;
		// 使用cd间隔时间显示
		public var txtTime:TextField;
		// 花费金币价钱
		public var txtCost:TextField;
		// 
		public var tips:MovieClip;
		//
		public var bgArea:MovieClip;
		
		private var itemTips:PropItemTips;
		
		public function PropItem()
		{
			super();
			addEventListener( MouseEvent.CLICK, onClickHandler );
			itemTips = new PropItemTips( this );
		}
		
		protected function onClickHandler( event:MouseEvent ):void
		{
			if ( _isCanClick )
				dispatchEvent( new PackEvent( PackEvent.USE_ITEM, data, true ));
			else Tips.showMouse( "您的节奏有点太快了" );
		}
		
		//////////////////////////////////
		
		private function setText():void
		{
			txtTime.visible = false;
			txtCost.visible = _data.num == 0;
			txtNum.visible = _data.num != 0;
			
			txtCost.text = _data.contMoney.toString();
			txtNum.text = "x" + _data.num.toString();
		}
		
		private function doInterval():void
		{
			if ( _timeNum <= 0 )
			{
				clearTimeout();
				setText();
			}
			else
			{
				txtTime.text = _timeNum + "s";
				_timeNum--;
			}
		}
		
		///////////////////////////////////
		
		public function setPosType( type:int = POS_DOWN ):void
		{
			if ( tips )
			{
				switch ( type )
				{
					case POS_LEFT:
						tips.x = -38;
						tips.y = 13;
						break;
					case POS_RIGHT:
						tips.x = 50;
						tips.y = 13;
						break;
					case POS_DOWN:
					default:
						tips.x = 6;
						tips.y = 51;
				}
			}
		}
		
		public function displayOnlyNum():void 
		{
			txtTime.visible = false;
			txtCost.visible = false;
			txtNum.visible =  true;
		}
		
		public function setData( itemVo:ItemVo ):void
		{
			if ( _data == null || _data.type != itemVo.type )
			{
				DisplayUtil.removedFromParent( _skin );
				_skin = LoaderManager.getObj( itemVo.skinId ) as Sprite;
				addChildAt( _skin, 0 );
				Reflection.reflection( this, _skin );
				tips.mouseEnabled = false;
				tips.mouseChildren = false;
				txtTime = tips.txtTime as TextField;
				txtNum  = tips.txtNum as TextField;
				txtCost = tips.txtCost as TextField;
				setPosType();
			}
			_data = itemVo;
			clearTimeout();
			setText();
			
			itemTips.setVo( itemVo );
		}
		
		/**
		 * 更新数据
		 * @param propVo
		 */
		public function update( itemVo:ItemVo ):void
		{
			if ( _data && _data.num == 0 )
			{
				clearTimeout();
				
				txtCost.visible = txtNum.visible = false;
				txtTime.visible = true;
				
				_data = itemVo;
				_isCanClick = false;
				_timeNum = itemVo.intervalTime;
				TickManager.doInterval( doInterval, 1000 );
				doInterval();
			}
			else
			{
				setData( itemVo );
			}
		}
		
		public function clearTimeout():void
		{
			_timeNum = 0;
			_isCanClick = true;
			TickManager.clearDoTime( doInterval );
		}
		
		public function get data():ItemVo
		{
			return _data;
		}
		
		
		
		
	}
}