package app.modules.fight.view.prop.item
{
	import flash.display.DisplayObject;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.geom.Point;
	import flash.text.TextField;
	import flash.text.TextFormatAlign;
	
	import app.modules.model.vo.ItemVo;
	
	import victor.framework.core.ViewStruct;
	import victor.framework.interfaces.IDisposable;
	import victor.framework.utils.MathUtil;
	import victor.framework.utils.TextFiledUtil;
	import victor.framework.utils.appStage;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-12-5
	 */
	public class PropItemTips extends Sprite implements IDisposable
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		private var target:DisplayObject;
		private var txtLine:TextField;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function PropItemTips( target:DisplayObject )
		{
			txtLine = TextFiledUtil.create( "微软雅黑 Bold", 14, 0xFFFFFF, TextFormatAlign.CENTER );
			txtLine.text = "   ";
			txtLine.height = txtLine.textHeight + 2;
			txtLine.y = 2;
			addChild( txtLine );
			this.target = target;
			if ( target )
			{
				target.addEventListener(MouseEvent.ROLL_OVER, mouseHandler );
				target.addEventListener(MouseEvent.ROLL_OUT , mouseHandler );
			}
		}
		
		protected function mouseHandler( event:MouseEvent ):void
		{
			if ( target && target.stage )
			{
				if ( event.type == MouseEvent.ROLL_OVER )
				{
					ViewStruct.addChild( this, ViewStruct.TIPS );
					var point:Point = target.localToGlobal( new Point( - width >> 1 ));
					x = MathUtil.range( point.x, 10, appStage.stageWidth - ( width ) - 10 );
					y = point.y - height;
					
					var startx:Number = ( width >> 1 ) + Math.abs( x - point.x );
					this.graphics.clear();
					this.graphics.beginFill( 0, 0.6 );
					this.graphics.drawRoundRect(0,0,txtLine.width, txtLine.height, 5 );
					this.graphics.endFill();
					
					this.graphics.beginFill( 0, 0.6 );
					this.graphics.moveTo( startx - 10, txtLine.height );
					this.graphics.lineTo( startx + 10, txtLine.height );
					this.graphics.lineTo( startx, txtLine.height + 15 );
					this.graphics.lineTo( startx - 10, txtLine.height );
					this.graphics.endFill();
				}
				else if ( event.type == MouseEvent.ROLL_OUT )
				{
					ViewStruct.removeChild( this );
				}
			}
		}
		
		/*============================================================================*/
		/* public functions                                                           */
		/*============================================================================*/
		
		public function dispose():void
		{
			
		}
		
		public function setVo( itemVo:ItemVo ):void
		{
			txtLine.text = itemVo.desc;
			txtLine.width = txtLine.textWidth + 20;
			this.graphics.clear();
			this.graphics.beginFill( 0, 0.6 );
			this.graphics.drawRoundRect(0,0,txtLine.width, txtLine.height, 5 );
			this.graphics.endFill();
		}
		
	}
}