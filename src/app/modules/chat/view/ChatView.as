package app.modules.chat.view
{
	
	import com.riaidea.text.RichTextField;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import app.core.Tips;
	import app.managers.LoaderManager;
	import app.modules.chat.ChatChannelType;
	import app.modules.chat.event.ChatEvent;
	import app.modules.chat.model.ChatVo;
	import app.utils.appStage;
	
	import victor.framework.components.TabButtonControl;
	import victor.framework.components.scroll.ScrollBar;
	import victor.framework.core.ViewSprite;
	import victor.framework.core.ViewStruct;
	import victor.framework.utils.StringUitl;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-9-6
	 */
	public class ChatView extends ViewSprite
	{
		
		public var mcBg:Sprite;
		public var chatMc:Sprite;
		public var mcLock:MovieClip;
		public var tabWorld:MovieClip;
		public var tabPrivate:MovieClip;
		public var btnSend:InteractiveObject;
		public var btnWorld:InteractiveObject;
		public var btnPrivate:InteractiveObject;
		public var btnExpression:InteractiveObject;
		
		private var tabControl:TabButtonControl;
		
		private var outputText:RichTextField;
		private var inputText:RichTextField;
		private var emotionPanel:ChatEmotionPanel;
		private var curChannel:uint = 0;
		
		private var _scrollBar:ScrollBar;
		
		private var _isLock:Boolean = false;
		
		public function ChatView()
		{
			super();
			mouseEnabled = false;
		}
		
		////////////// public 
		
		public function selectedWorld():void
		{
			if ( tabControl )
				tabControl.setDefaultTarget( tabWorld );
		}
		
		public function selectedPrivate():void
		{
			if ( tabControl )
				tabControl.setDefaultTarget( tabPrivate );
		}
		
		public function addMsg( chatVo:ChatVo ):void
		{
			var emoticons:Array = chatVo.emoticons;
			var msgIndex:int = chatVo.addIndex;
			for each (var obj:Object in emoticons )
			{
				if ( obj ) obj.index = ( msgIndex + obj.index );
			}
			outputText.append( chatVo.htmlText, emoticons );
			updateBar();
		}
		
		public function setChannelData( list:Vector.<ChatVo> ):void
		{
			outputText.clear();
			for each(var chatVo:ChatVo in list )
			{
				addMsg( chatVo );
			}
		}
		
		/////////////// private 
		
		private function channelChangeHandler( target:MovieClip, data:* = null ):void
		{
			btnWorld.visible = target == tabWorld;
			btnPrivate.visible = target == tabPrivate;
			switch ( target )
			{
				case tabWorld:
					curChannel = ChatChannelType.WORLD;
					break;
				case tabPrivate:
					curChannel = ChatChannelType.PRIVATE;
					break;
			}
			dispatchEvent( new ChatEvent( ChatEvent.CHANGE_CHANNEL, curChannel ));
		}
		
		/**
		 * 初始化滚动条
		 */
		private function initBar() : void {
			var skin : Sprite = LoaderManager.getObj( "ui_scrollBar5" ) as Sprite;
			_scrollBar = new ScrollBar( skin );
			_scrollBar.init(145);
			_scrollBar.x = 7;
			_scrollBar.y = -195;
			_scrollBar.setSpeed(10);
			_scrollBar.onChange = onBarChange;
			_skin.addChild(_scrollBar);
		}
		
		private function onWheelHandler(event : MouseEvent) : void {
			if (_scrollBar) {
				var cur : int = outputText.textfield.scrollV - 1;
				var max : int = outputText.textfield.maxScrollV - 1;
				_scrollBar.pos = max == 0 ? 0 : cur / max;
			}
		}
		
		private function onBarChange(value : Number) : void {
			outputText.textfield.scrollV = value * outputText.textfield.maxScrollV;
		}
		
		private function updateBar() : void {
			var tf : TextField = outputText.textfield;
			var radio : Number ;
			if (tf.maxScrollV == 1) {
				radio = 1;
			} else {
				radio = (tf.numLines - tf.maxScrollV) / tf.numLines;
			}
			_scrollBar.radio = radio;
		}
		
		//////////////// override 
		
		override protected function setSkinWithName(skinName:String):void
		{
			super.setSkinWithName( skinName );
			if ( _skin )
			{
				_skin.x = 0;
				_skin.y = appStage.stageHeight;
			}
		}
		
		override protected function onceInit():void
		{
			tabControl = new TabButtonControl( channelChangeHandler );
			tabControl.addMultiTargets( tabWorld, tabPrivate );
			
			var txtFormat : TextFormat = new TextFormat("宋体", 12, 0xFFFFFF, false, false, false);
			txtFormat.size = 14;
			txtFormat.color = 0x0;
			txtFormat.leading = 2;
			
			outputText = new RichTextField();
			outputText.html = true;
			outputText.setSize(300, 150);
			outputText.defaultTextFormat = txtFormat;
			outputText.autoScroll = true;
			outputText.textfield.selectable = false;
			outputText.name = "output";
			outputText.mouseEnabled = false;
			outputText.lineHeight = 16;
			chatMc.addChild( outputText );
			
			inputText = new RichTextField();
			inputText.x = 40;
			inputText.y = -24;
			inputText.setSize(215, 30);
			inputText.spriteOffsetY(-2);
			inputText.lineHeight = 25;
			inputText.textHeight = 14;
			inputText.type = RichTextField.INPUT;
			inputText.textfield.multiline = false;
			inputText.defaultTextFormat = txtFormat;
			_skin.addChild( inputText );
			
			initBar();
			
			mcLock.mouseChildren = false;
			mcLock.buttonMode = true;
			
			emotionPanel = new ChatEmotionPanel( _skin, 90, -163 );
			
			btnSend.addEventListener(MouseEvent.CLICK, btnSendClickHandler );
			btnExpression.addEventListener(MouseEvent.CLICK, btnExpressionClickHandler );
			emotionPanel.addEventListener( ChatEvent.INPUT_EMOTION, inputEmotionHandler );
			mcLock.addEventListener(MouseEvent.CLICK, mcLockClickHandler );
			outputText.textfield.addEventListener(MouseEvent.MOUSE_WHEEL, onWheelHandler);
			
			selectedWorld();
			
		}
		
		protected function mcLockClickHandler(event:MouseEvent):void
		{
			_isLock = !_isLock;
			mcLock.gotoAndStop( _isLock ? 1 : 2 );
			dispatchEvent( new ChatEvent( ChatEvent.LOCK_CHAT, _isLock ));
		}
		
		protected function btnSendClickHandler(event:MouseEvent):void
		{
			sendChat();
		}

		private function sendChat():void
		{
			if ( inputText.textfield.text.length <= 0 )
			{
				Tips.showMouse( "不能发送空内容" );
			}
			else
			{
				var chatVo:ChatVo = new ChatVo();
				var inData:XML = inputText.exportXML();
				var list:XMLList = inData.sprites.child( "sprite" );
				var arr:Array = [];
				var src:String;
				for each ( var item:XML in list )
				{
					src = String( item.@src );
					src = "ui.chat.emotion_" + src.substr( src.length - 2 );
					arr.push({ src: src, index: int( item.@index )});
				}
				chatVo.channel = curChannel;
				chatVo.msg = StringUitl.formatInput( inData.text[ 0 ]);
				chatVo.emoticons = arr;
				
				dispatchEvent( new ChatEvent( ChatEvent.PUSH_MSG, chatVo ));

				inputText.clear();
			}
		}
		
		protected function inputEmotionHandler( event:ChatEvent ):void
		{
			inputText.insertSprite( event.data.toString(), inputText.caretIndex, true, true );
		}
		
		protected function btnExpressionClickHandler(event:MouseEvent):void
		{
			event.stopPropagation();
			emotionPanel.show();
		}
		
		override public function show():void
		{
			ViewStruct.addChild( this, ViewStruct.CHAT );
		}
		
		override protected function get skinName():String
		{
			return "ui_Skin_ChatView";
		}
		
	}
}