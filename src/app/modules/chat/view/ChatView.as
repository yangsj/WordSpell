package app.modules.chat.view
{
	import com.riaidea.text.RichTextField;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextFormat;
	
	import app.core.Tips;
	import app.modules.chat.ChatChannelType;
	import app.modules.chat.event.ChatEvent;
	import app.modules.chat.model.ChatVo;
	import app.utils.appStage;
	
	import victor.framework.components.TabButtonControl;
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
			var msgIndex:int = chatVo.msgIndex;
			trace( msgIndex, chatVo.msgIndex );
			for each (var obj:Object in emoticons )
			{
				if ( obj )
				{
					obj.index = ( msgIndex + obj.index );
				}
			}
			outputText.append( chatVo.htmlText, emoticons );
			
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
			
			mcLock.mouseChildren = false;
			mcLock.buttonMode = true;
			
			emotionPanel = new ChatEmotionPanel( _skin, 90, -163 );
			
			btnSend.addEventListener(MouseEvent.CLICK, btnSendClickHandler );
			btnExpression.addEventListener(MouseEvent.CLICK, btnExpressionClickHandler );
			emotionPanel.addEventListener( ChatEvent.INPUT_EMOTION, inputEmotionHandler );
			mcLock.addEventListener(MouseEvent.CLICK, mcLockClickHandler );
			
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
			var chatVo:ChatVo = new ChatVo();
			if ( inputText.textfield.text.length <= 0 )
			{
				Tips.showMouse( "不能发送空内容" );
			}
			else
			{
				var inData:XML = inputText.exportXML();
				chatVo.channel = curChannel;
				chatVo.msg = StringUitl.formatInput( inData.text[ 0 ]);
				var len:int = inputText.contentLength;
				var list:XMLList = inData.sprites.child( "sprite" );
				var arr:Array = [];
				for each ( var item:XML in list )
				{
					var src:String = String( item.@src );
					src = "ui.chat.emotion_" + src.substr( src.length - 2 );
					arr.push({ src: src, index: int( item.@index )});
				}
				chatVo.emoticons = arr;
				len += arr.length;

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