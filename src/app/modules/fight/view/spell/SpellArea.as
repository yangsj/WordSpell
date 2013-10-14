package app.modules.fight.view.spell
{
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.text.TextField;
	
	import app.managers.LoaderManager;
	import app.modules.fight.model.LetterBubbleVo;
	
	import victor.framework.manager.TickManager;


	/**
	 * ……
	 * @author 	yangsj
	 * 			2013-9-27
	 */
	public class SpellArea extends Sprite
	{
		private const MAX:int = 10;

		private var _skin:Sprite;

		public var txtChinese:TextField;

		private var _inputList:Vector.<LetterBubbleVo>;
		private var _spellVo:SpellVo;
		private var _spellItems:Vector.<SpellItem>;
		private var _inputNum:int = 0;

		public function SpellArea()
		{
			super();
			createSkin();
			createSpellItems();
		}

		private function createSkin():void
		{
			_skin = LoaderManager.getObj( "ui_Skin_Round_SpellArea" ) as Sprite;
			addChild( _skin );
			txtChinese = _skin.getChildByName( "txtChinese" ) as TextField;
		}

		private function createSpellItems():void
		{
			_spellItems = new Vector.<SpellItem>( MAX );
			for ( var i:int = 0; i < MAX; i++ )
				_spellItems[ i ] = ( new SpellItem( _skin.getChildByName( "pos" + i ) as MovieClip ));
		}

		public function setInitData( spellVo:SpellVo ):void
		{
			_spellVo = spellVo;
			_inputList = new Vector.<LetterBubbleVo>();
			_inputNum = 0;

			txtChinese.text = spellVo.chinese;

			// 初始化字母显示格子
			for ( var i:int = 0; i < MAX; i++ )
			{
				var item:SpellItem = _spellItems[ i ];
				item.initialize();
				item.visible = i < _spellVo.charsLength;
			}
			
			// 计时
//			TickManager.instance.clearDoTime( inputOver );
//			TickManager.instance.doTimeout( inputOver, 10000 );
		}

		/**
		 * 设置单个字母显示
		 * @param index 位置
		 * @param letter 字母
		 */
		public function setSingleLetter( letterBubbleVo:LetterBubbleVo ):void
		{
			if ( _inputList && _spellVo )
			{
				if ( _inputNum == letterBubbleVo.id )
				{
					var item:SpellItem = _spellItems[ _inputNum ];
					item.setData( letterBubbleVo );
					_inputList.push( letterBubbleVo );
					_inputNum++;
					if ( _inputNum >= _spellVo.charsLength )
						inputOver();
				}
				else
				{
					inputOver();
				}
			}
			else
			{
				throw new Error( "setSingleLetter没有初始化" );
			}
		}

		public function get inputList():Vector.<LetterBubbleVo>
		{
			return _inputList;
		}

		private function inputOver():void
		{
			TickManager.instance.clearDoTime( inputOver );
			dispatchEvent( new SpellEvent( SpellEvent.INPUT_OVER ));
		}

		public function clear():void
		{
			TickManager.instance.clearDoTime( inputOver );
		}

		public function showAnswer():void
		{
			var item:SpellItem;
			var leng:int = Math.min(_spellVo.items.length, MAX );
			for ( var i:int = 0; i < leng; i++ )
			{
				item = _spellItems[ i ];
				item.setData( _spellVo.items[ i ] );
			}
		}

	}
}
