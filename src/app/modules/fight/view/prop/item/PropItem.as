package app.modules.fight.view.prop.item
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	import app.core.Text;
	import app.core.Tips;
	import app.events.PackEvent;
	import victor.framework.manager.LoaderManager;
	import app.modules.model.vo.ItemVo;
	
	import victor.framework.manager.TickManager;
	import victor.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class PropItem extends Sprite
	{
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
		
		private var tips:PropItemTips;
		
		public function PropItem()
		{
			super();
			createTexts();
			addEventListener( MouseEvent.CLICK, onClickHandler );
			scaleX = scaleY = 0.8;
			
			tips = new PropItemTips( this );
		}
		
		protected function onClickHandler( event:MouseEvent ):void
		{
			if ( _isCanClick )
				dispatchEvent( new PackEvent( PackEvent.USE_ITEM, data, true ));
			else Tips.showMouse( "您的节奏有点太快了" );
		}
		
		private function createTexts():void
		{
			var array:Array = [new GlowFilter(0,1,2,2,3,3)];
			
			txtCost = Text.getText(25, 0xffff00,"", -10, 60, 80, 35);
			txtNum = Text.getText(25, 0xffff00, "", 5, 60, 60, 35);
			txtTime = Text.getText(25, 0xffff00, "", -10, 60, 80, 35);
			
			txtCost.filters = array;
			txtNum.filters = array;
			txtTime.filters = array;
			
			txtCost.mouseEnabled = false;
			txtNum.mouseEnabled = false;
			txtTime.mouseEnabled = false;
			
			txtCost.visible = false;
			txtNum.visible = false;
			txtTime.visible = false;
			
			addChild( txtCost );
			addChild( txtNum );
			addChild( txtTime );
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
//				Reflection.reflection( this, _skin );
			}
			_data = itemVo;
			clearTimeout();
			setText();
			
			tips.setVo( itemVo );
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