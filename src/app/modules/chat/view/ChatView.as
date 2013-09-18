package app.modules.chat.view
{

	import com.riaidea.text.RichTextField;
	
	import flash.display.InteractiveObject;
	import flash.display.MovieClip;
	import flash.display.Sprite;
	import flash.events.MouseEvent;
	import flash.text.TextField;
	import flash.text.TextFormat;
	
	import app.Language;
	import app.core.Tips;
	import app.data.GameData;
	import app.data.PlayerBaseVo;
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
		//底图
		public var mcBg:Sprite;
		//容器
		public var chatMc:Sprite;
		//锁频
		public var mcLock:MovieClip;
		//世界
		public var tabWorld:MovieClip;
		//私聊
		public var tabPrivate:MovieClip;
		//发送
		public var btnSend:InteractiveObject;
		//世界
		public var btnWorld:InteractiveObject;
		//私聊
		public var btnPrivate:InteractiveObject;
		//表情
		public var btnExpression:InteractiveObject;
		//隐藏展开
		public var btnExpandHide:InteractiveObject;

		private var tabControl:TabButtonControl;

		private var txtOutput:RichTextField;
		private var txtInput:RichTextField;
		private var txtFriendName:TextField;
		private var emotionPanel:ChatEmotionPanel;
		private var curChannel:uint = 0;
		private var chatFriendVo:PlayerBaseVo;

		private var _isExpand:Boolean = true;
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
			if ( _isExpand )
			{
				var emoticons:Array = chatVo.emoticons;
				var msgIndex:int = chatVo.addIndex;
				for each ( var obj:Object in emoticons )
				{
					if ( obj )
						obj.index = ( msgIndex + obj.index );
				}
				txtOutput.append( chatVo.htmlText, emoticons );
				updateBar();
			}
		}

		public function setChannelData( list:Vector.<ChatVo> ):void
		{
			if ( _isExpand )
			{
				txtOutput.clear();
				for each ( var chatVo:ChatVo in list )
				addMsg( chatVo );
			}
		}

		/**
		 * 设置频道状态
		 * @param isPrivateChatChannel 是否是私聊频道
		 * @param chatFriendVo 私聊数据
		 */
		public function setChannelStatus( isPrivateChatChannel:Boolean, chatFriendVo:PlayerBaseVo ):void
		{
			if ( isPrivateChatChannel )
			{
				this.chatFriendVo = chatFriendVo;
				txtInput.clear();
				txtFriendName.text = "/" + ( chatFriendVo ? chatFriendVo.name : " " ) + " ";
				txtInput.x = txtFriendName.x + txtFriendName.textWidth;
				txtInput.setSize( 215 - txtFriendName.textWidth, 30 );
			}
			else
			{
				this.chatFriendVo = null;
				txtInput.x = txtFriendName.x;
				txtInput.setSize( 215, 30 );
			}
		}

		/////////////// private 

		private function channelChangeHandler( target:MovieClip, data:* = null ):void
		{
			btnWorld.visible = target == tabWorld;
			btnPrivate.visible = target == tabPrivate;
			txtFriendName.visible = btnPrivate.visible;
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
		private function initBar():void
		{
			var skin:Sprite = LoaderManager.getObj( "ui_scrollBar5" ) as Sprite;
			_scrollBar = new ScrollBar( skin );
			_scrollBar.init( 145 );
			_scrollBar.x = 7;
			_scrollBar.y = -195;
			_scrollBar.setSpeed( 10 );
			_scrollBar.onChange = onBarChange;
			_skin.addChild( _scrollBar );
		}

		private function onWheelHandler( event:MouseEvent ):void
		{
			if ( _scrollBar )
			{
				var cur:int = txtOutput.textfield.scrollV - 1;
				var max:int = txtOutput.textfield.maxScrollV - 1;
				_scrollBar.pos = max == 0 ? 0 : cur / max;
			}
		}

		private function onBarChange( value:Number ):void
		{
			txtOutput.textfield.scrollV = value * txtOutput.textfield.maxScrollV;
		}

		private function updateBar():void
		{
			var tf:TextField = txtOutput.textfield;
			var radio:Number;
			if ( tf.maxScrollV == 1 )
				radio = 1;
			else radio = ( tf.numLines - tf.maxScrollV ) / tf.numLines;
			
			_scrollBar.radio = radio;
		}
		
		private function setExpandHide():void
		{
			_isExpand = !_isExpand;
			if ( _isExpand )
			{
				mcBg.y = -mcBg.height;
			}
			else
			{
				mcBg.y = mcBg.height * 0.25;
			}
			chatMc.visible = _isExpand;
			mcLock.visible = _isExpand;
			_scrollBar.visible = _isExpand;
		}

		//////////////// override 

		override protected function setSkinWithName( skinName:String ):void
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

			var txtFormat:TextFormat = new TextFormat( "宋体", 12, 0xFFFFFF, false, false, false );
			txtFormat.size = 14;
			txtFormat.color = 0x0;
			txtFormat.leading = 2;

			txtOutput = new RichTextField();
			txtOutput.html = true;
			txtOutput.setSize( 300, 150 );
			txtOutput.defaultTextFormat = txtFormat;
			txtOutput.autoScroll = true;
			txtOutput.textfield.selectable = false;
			txtOutput.name = "output";
			txtOutput.mouseEnabled = false;
			txtOutput.lineHeight = 16;
			chatMc.addChild( txtOutput );

			txtInput = new RichTextField();
			txtInput.x = 40;
			txtInput.y = -24;
			txtInput.setSize( 215, 30 );
			txtInput.spriteOffsetY( -2 );
			txtInput.lineHeight = 25;
			txtInput.textHeight = 14;
			txtInput.type = RichTextField.INPUT;
			txtInput.textfield.multiline = false;
			txtInput.defaultTextFormat = txtFormat;
			_skin.addChild( txtInput );

			txtFormat.size = 12;
			txtFriendName = new TextField();
			txtFriendName.defaultTextFormat = txtFormat;
			txtFriendName.mouseEnabled = false;
			txtFriendName.x = 40;
			txtFriendName.y = -24;
			_skin.addChild( txtFriendName );

			initBar();

			mcLock.mouseChildren = false;
			mcLock.buttonMode = true;

			emotionPanel = new ChatEmotionPanel( _skin, 90, -163 );

			btnSend.addEventListener( MouseEvent.CLICK, btnSendClickHandler );
			btnExpression.addEventListener( MouseEvent.CLICK, btnExpressionClickHandler );
			emotionPanel.addEventListener( ChatEvent.INPUT_EMOTION, inputEmotionHandler );
			mcLock.addEventListener( MouseEvent.CLICK, mcLockClickHandler );
			txtOutput.textfield.addEventListener( MouseEvent.MOUSE_WHEEL, onWheelHandler );
			btnExpandHide.addEventListener(MouseEvent.CLICK, btnExpandHideClickHandler );

			selectedWorld();

		}
		
		protected function btnExpandHideClickHandler(event:MouseEvent):void
		{
			setExpandHide();
		}
		
		protected function mcLockClickHandler( event:MouseEvent ):void
		{
			_isLock = !_isLock;
			mcLock.gotoAndStop( _isLock ? 1 : 2 );
			dispatchEvent( new ChatEvent( ChatEvent.LOCK_CHAT, _isLock ));
		}

		protected function btnSendClickHandler( event:MouseEvent ):void
		{
			sendChat();
		}

		private function sendChat():void
		{
			if ( txtInput.textfield.text.length <= 0 )
			{
				Tips.showMouse( Language.lang( Language.ChatView_0 ));
			}
			else
			{
				var chatVo:ChatVo = new ChatVo();
				if ( curChannel == ChatChannelType.PRIVATE )
				{
					if ( chatFriendVo == null )
					{
						Tips.showMouse( Language.lang( Language.ChatView_1 ));
						return;
					}
					else
					{
						chatVo.playerName = chatFriendVo.name;
						chatVo.playerUid = chatFriendVo.uid;
					}
				}
				else
				{
					chatVo.playerName = GameData.instance.selfVo.name;
					chatVo.playerUid = GameData.instance.selfVo.uid;
				}

				var inData:XML = txtInput.exportXML();
				var list:XMLList = inData.sprites.child( "sprite" );
				var arr:Array = [];
				var src:String;
				for each ( var item:XML in list )
				{
					src = String( item.@src );
					src = src.substr( src.length - 2 );
					arr.push({ src: src, index: int( item.@index )});
				}
				chatVo.channel = curChannel;
				chatVo.msg = StringUitl.formatInput( inData.text[ 0 ]);
				chatVo.emoticons = arr;

				dispatchEvent( new ChatEvent( ChatEvent.PUSH_MSG, chatVo ));

				txtInput.clear();
			}
		}

		protected function inputEmotionHandler( event:ChatEvent ):void
		{
			txtInput.insertSprite( event.data.toString(), txtInput.caretIndex, true, true );
		}

		protected function btnExpressionClickHandler( event:MouseEvent ):void
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
