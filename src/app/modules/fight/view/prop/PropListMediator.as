package app.modules.fight.view.prop
{
	import app.core.Tips;
	import app.data.GameData;
	import app.events.PackEvent;
	import app.modules.fight.events.FightAloneEvent;
	import app.modules.fight.model.FightModel;
	import app.modules.model.PackModel;
	import app.modules.model.vo.ItemType;
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
		[Inject]
		public var fightModel:FightModel;
		
		
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
			addContextListener( PackEvent.UPDATE_ITEMS, updatePackItemsHandler, PackEvent );
			// start
			addContextListener( FightAloneEvent.NOTIFY_START_ROUND, nextWordNotify, FightAloneEvent );
			
			setData();
		}
		
		private function setData():void
		{
			view.setData( packModel.itemList );
		}
		
		private function nextWordNotify( event:FightAloneEvent ):void
		{
			view.visible = !fightModel.isPractice;
		}
		
		// 物品使用
		private function useItemHandler( event:PackEvent ):void
		{
			var itemVo:ItemVo = event.data as ItemVo;
			switch ( itemVo.type )
			{
				case ItemType.BOMB:
					if ( fightModel.isHasDisturbForSelf == false ) {
						Tips.showMouse( "当前屏幕中没有需要清楚的干扰因素！！！" );
						return ;
					}
					break;
			}
			
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