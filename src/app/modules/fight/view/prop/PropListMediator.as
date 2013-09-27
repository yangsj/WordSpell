package app.modules.fight.view.prop
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemVo;
	import app.modules.serivce.PackService;
	
	import victor.framework.core.BaseMediator;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-27
	 */
	public class PropListMediator extends BaseMediator
	{
		[Inject]
		public var view:PropList;
		[Inject]
		public var packModel:PackModel;
		[Inject]
		public var packService:PackService;
		
		
		public function PropListMediator()
		{
			super();
		}
		
		override public function onRegister():void
		{
			super.onRegister();
			
			// 使用道具
			addViewListener( PackEvent.USE_ITEM, useItemHandler, PackEvent );
			
			// 物品使用成功
			addContextListener( PackEvent.USE_SUCCESS, useItemSuccessHandler, PackEvent );
			
			setData();
		}
		
		private function setData():void
		{
//			view.setData( packModel.itemList );
			
			var _itemList:Vector.<ItemVo> = new Vector.<ItemVo>();1
			var itemVo:ItemVo;
			for (var i:int = 1; i < 5; i++ )
			{
				itemVo = new ItemVo();
				itemVo.id = i;
				itemVo.num = 0;
				_itemList.push( itemVo );
			}
			view.setData( _itemList );
		}
		
		// 物品使用
		private function useItemHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
//			if ( itemVo.num > 0 || itemVo.contMoney <= GameData.instance.selfVo.money )
//				packService.useItem( itemVo.id );
//			else Tips.showMouse( "钻石不足！" );
			
			//test
			view.refreshItem( itemVo );
		}
		
		// 物品使用成功
		private function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			view.refreshItem( itemVo );
		}
		
	}
}