package app.modules.task.view
{
	import flash.display.Sprite;
	
	import app.modules.task.model.TaskVo;
	
	import victor.core.scroll.GameScrollPanel;
	import victor.framework.core.BasePanel;
	import victor.utils.DisplayUtil;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class TaskView extends BasePanel
	{
		private var listContainer:Sprite;
		private var gameScroll:GameScrollPanel;
		
		public function TaskView()
		{
		}
		
		public function setDataList( list:Vector.<TaskVo> ):void
		{
			if ( list )
			{
				DisplayUtil.removedAll( listContainer );
				var i:int = 0;
				var disty:Number = 43;
				var startx:Number = list.length < 7 ? 5 : 0;
				var pos:Number = isNaN( gameScroll.curPos ) ? 0 : gameScroll.curPos;
				for each ( var vo:TaskVo in list )
				{
					var item:TaskItem = TaskItem.itemInstance;
					item.setData( vo );
					item.x = startx;
					item.y = disty * i;
					listContainer.addChild( item );
					i++;
				}
				gameScroll.updateMainHeight( listContainer.height );
				gameScroll.setPos( pos );
			}
		}
		
		override protected function onceInit():void
		{
			super.onceInit();
			
			listContainer = new Sprite();
			listContainer.graphics.beginFill(0, 0.1 );
			listContainer.graphics.drawRect(0,0,260,288);
			listContainer.graphics.endFill();
			listContainer.x = 23;
			listContainer.y = 46;
			_skin.addChild( listContainer );
			
			gameScroll = new GameScrollPanel();
			gameScroll.setTargetAndHeight( listContainer, listContainer.height, listContainer.width );
		}
		
		override protected function get resNames():Array
		{
			return ["ui_task"];
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_TaskViewPanel";
		}
		
	}
}