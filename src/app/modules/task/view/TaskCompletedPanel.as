package app.modules.task.view
{
	import flash.display.InteractiveObject;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	
	import app.modules.fight.view.prop.item.PropItem;
	import app.modules.model.vo.ItemVo;
	import app.modules.task.event.TaskEvent;
	import app.modules.task.model.TaskVo;
	
	import victor.framework.core.BasePanel;
	import victor.utils.DisplayUtil;
	import victor.utils.UtilsFilter;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-11-22
	 */
	public class TaskCompletedPanel extends BasePanel
	{
		public var txtExp:TextField;
		public var txtMoney:TextField;
		public var btnTake:InteractiveObject;
		
		private var propListContainer:Sprite;
		
		public function TaskCompletedPanel()
		{
			super();
		}
		
		override protected function openComplete():void
		{
			super.openComplete();
			createPropList();
			addEventListener(Event.ENTER_FRAME, enterFrameHandler );
			btnTake.addEventListener(MouseEvent.CLICK, btnTakeClickHandler );
		}
		
		protected function btnTakeClickHandler(event:MouseEvent):void
		{
			dispatchEvent( new TaskEvent( TaskEvent.TAKE_REWARD, data ));
			btnTake.mouseEnabled = false;
			btnTake.filters = [ UtilsFilter.COLOR_GREW ];
		}
		
		protected function enterFrameHandler(event:Event):void
		{
			if ( parent )
			{
				parent.setChildIndex( this, parent.numChildren - 1 );
			} else{
				removeEventListener(Event.ENTER_FRAME, enterFrameHandler );
			}
		}
		
		private function createPropList():void
		{
			DisplayUtil.removedAll( propListContainer );
			var item:PropItem;
			var taskVo:TaskVo = data as TaskVo;
			btnTake.mouseEnabled = false;
			if ( taskVo )
			{
				var vec:Vector.<ItemVo> = taskVo.propList;
				var length:int = vec.length;
				for ( var i:int = 0; i < length; i++ )
				{
					item = new PropItem();
					item.setData(vec[i]);
					item.x = 80 * i;
					item.mouseChildren = false;
					item.mouseEnabled = false;
					propListContainer.addChild( item );
				}
				txtExp.text = taskVo.rewardExp.toString();
				txtMoney.text = taskVo.rewardMoney.toString();
				btnTake.mouseEnabled = taskVo.isEd;
				btnTake.filters = taskVo.isEd ? [] : [ UtilsFilter.COLOR_GREW ];
			}
//			else
//			{
//				var vo:ItemVo = new ItemVo();
//				vo.type = int(Math.random() * 4) + 1;
//				vo.num = 2;
//				item = new PropItem();
//				item.setData(vo);
//				item.mouseChildren = false;
//				item.mouseEnabled = false;
//				propListContainer.addChild( item );
//			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			propListContainer = new Sprite();
			propListContainer.x = 274;
			propListContainer.y = 140;
			addChild( propListContainer );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_task", "ui_prop_list"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_TaskCompletedPanel";
		}
		
	}
}