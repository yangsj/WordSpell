package app.modules.fight.view.prop
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.main.event.MainUIEvent;
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
			// 物品更新
			addContextListener( PackEvent.UPDATE_ITEMS, updatePackItemsHandler, MainUIEvent );
			
			setData();
		}
		
		private function setData():void
		{
			view.setData( packModel.itemList );
		}
		
		// 物品使用
		private function useItemHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			if ( itemVo.num > 0 || itemVo.contMoney <= GameData.instance.selfVo.money )
				packService.useItem( itemVo.type );
			else Tips.showMouse( "钻石不足！" );
		}
		
		// 物品使用成功
		private function useItemSuccessHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			view.refreshItem( itemVo );
		}
		
		private function updatePackItemsHandler( event:PackEvent ):void
		{
			setData();
		}
		
	}
}