package app.modules.fight.view.panel
{
	import flash.display.MovieClip;
	import flash.display.SimpleButton;
	import flash.events.MouseEvent;
	import flash.text.TextField;

	import app.modules.fight.model.FightEndVo;

	import victor.framework.core.BasePanel;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-28
	 */
	public class FightResultBasePanel extends BasePanel
	{
		/**
		 * 练习本关 按钮
		 */
		public var btnPractice:SimpleButton;
		/**
		 * 下一关 按钮
		 */
		public var btnNext:SimpleButton;
		/**
		 * 再次挑战 按钮
		 */
		public var btnAgain:SimpleButton;
		/**
		 * txtExp
		 */
		public var txtExp:TextField;
		/**
		 * txtMoney
		 */
		public var txtMoney:TextField;
		/**
		 * 星级评分mc， 包含3帧
		 */
		public var mcStar:MovieClip;

		public function FightResultBasePanel()
		{
			super();
		}

		override protected function onceInit():void
		{
			super.onceInit();
			btnAgain.addEventListener( MouseEvent.CLICK, btnAgainHandler );
			btnNext.addEventListener( MouseEvent.CLICK, btnNextHandler );
			btnPractice.addEventListener( MouseEvent.CLICK, btnPracticeHandler );
			if ( btnClose )
				btnClose.addEventListener( MouseEvent.CLICK, btnCloseHandler );
		}

		protected function btnCloseHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.CLOSE ));
		}

		protected function btnPracticeHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.PRACTICE ));
		}

		protected function btnNextHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.NEXT ));
		}

		protected function btnAgainHandler( event:MouseEvent ):void
		{
			dispatchEvent( new FightResultEvent( FightResultEvent.AGAIN ));
		}

		public function setData( endVo:FightEndVo ):void
		{
			txtExp.text = endVo.addExp.toString();
			txtMoney.text = endVo.addMoney.toString();
			txtExp.mouseEnabled = false;
			txtMoney.mouseEnabled = false;
		}
	}
}
