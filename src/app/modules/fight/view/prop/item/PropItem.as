package app.modules.fight.view.prop.item
{
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.filters.GlowFilter;
	import flash.text.TextField;
	
	import app.core.Tips;
	import app.events.PackEvent;
	import app.managers.LoaderManager;
	import app.modules.model.vo.ItemVo;
	import app.utils.TextUtil;
	
	import victor.framework.manager.TickManager;
	import victor.framework.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-11
	 */
	public class PropItem extends Sprite
	{
		private var _itemVo:ItemVo;
		private var _isCanClick:Boolean = true;
		private var _timeNum:int= 0;
		
		private var _skin:Sprite;
		
		// 物品剩余数量
		public var txtNum:TextField;
		// 使用cd间隔时间显示
		public var txtTime:TextField;
		// 花费金币价钱
		public var txtCost:TextField;
		
		public function PropItem()
		{
			super();
			createTexts();
			addEventListener( MouseEvent.CLICK, onClickHandler );
			scaleX = scaleY = 0.8;
		}
		
		protected function onClickHandler( event:MouseEvent ):void
		{
			if ( _isCanClick )
				dispatchEvent( new PackEvent( PackEvent.USE_ITEM, itemVo, true ));
			else Tips.showMouse( "您的节奏有点太快了" );
		}
		
		private function createTexts():void
		{
			var array:Array = [new GlowFilter(0,1,2,2,3,3)];
			
			txtCost = TextUtil.getText(25, 0xffff00,-10, 60, 80, 35);
			txtNum = TextUtil.getText(25, 0xffff00,5, 60, 60, 35);
			txtTime = TextUtil.getText(25, 0xffff00,-10, 60, 80, 35);
			
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
			txtCost.visible = _itemVo.num == 0;
			txtNum.visible = _itemVo.num != 0;
			
			txtCost.text = _itemVo.contMoney.toString();
			txtNum.text = "x" + _itemVo.num.toString();
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
		
		public function setData( itemVo:ItemVo ):void
		{
			if ( _itemVo == null || _itemVo.type != itemVo.type )
			{
				DisplayUtil.removedFromParent( _skin );
				_skin = LoaderManager.getObj( itemVo.skinId ) as Sprite;
				addChildAt( _skin, 0 );
//				Reflection.reflection( this, _skin );
			}
			_itemVo = itemVo;
			clearTimeout();
			setText();
		}
		
		/**
		 * 更新数据
		 * @param propVo
		 */
		public function update( itemVo:ItemVo ):void
		{
			if ( _itemVo && _itemVo.num == 0 )
			{
				clearTimeout();
				
				txtCost.visible = txtNum.visible = false;
				txtTime.visible = true;
				
				_itemVo = itemVo;
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
		
		public function get itemVo():ItemVo
		{
			return _itemVo;
		}
		
		
		
		
	}
}