import ff.chat_msg_t;
import ff.FFUtil;


mc_page0.visible = true;
mc_page1.visible = false;

Security.loadPolicyFile("xmlsocket://121.199.21.238:10242");

var socket:Socket = new Socket();
var isConn:Boolean = false;
//socket init 
//socket.endian = Endian.LITTLE_ENDIAN;
//连接、发送按钮消息
mc_page0.btn_connect.addEventListener(MouseEvent.CLICK, onConnectClicked);
mc_page1.send_btn.addEventListener(MouseEvent.CLICK, onSendClicked);
mc_page1.addEventListener(KeyboardEvent.KEY_DOWN, queren_btn);
function queren_btn(evt:KeyboardEvent)
{
    if(evt.keyCode ==Keyboard.ENTER)
          SendMsg();
}

//functions
function onConnectClicked(evt:Event)
{//点击连接
	socket.addEventListener(Event.CONNECT,onConn);
	socket.addEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.addEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	
	var address:String=mc_page0.txt_address.text;
	var port:int=parseInt(mc_page0.txt_port.text,10);
	socket.connect(address, port);
}

function onConn(e:Event):void 
{//连接成功
	socket.removeEventListener(Event.CONNECT,onConn);
	socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	
	socket.addEventListener(Event.CLOSE,onClose);
	socket.addEventListener(ProgressEvent.SOCKET_DATA,onReceiveData);
	isConn = true;
//界面切换
	mc_page0.visible = false;
	mc_page1.visible = true;
//发送消息
	sendMsg(0, mc_page0.txt_name.text);
}

function onError(e:IOErrorEvent):void
{//IO error
	socket.removeEventListener(Event.CONNECT,onConn);
	socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	isConn = false;
	trace("IOError");
}

function onSecurity(e:SecurityErrorEvent):void 
{//SecurityError
	socket.removeEventListener(SecurityErrorEvent.SECURITY_ERROR,onSecurity);
	socket.removeEventListener(Event.CONNECT,onConn);
	socket.removeEventListener(IOErrorEvent.IO_ERROR,onError);
	socket.close();
	isConn=false;
	trace("SecurityError");
}

function onClose(e:Event):void {
	socket.removeEventListener(Event.CLOSE,onClose);
	isConn=false;
}


function sendBytesData( cmd:int, byteArray:ByteArray):void 
{//发送消息
/*
	var ss1:chat_msg_t = new chat_msg_t();
	ss1.value = 'HelloWorld';
	var ba:ByteArray = new ByteArray();
	FFUtil.EncodeMsg(ss1, ba);
	trace("OhNice1:" + ba.length);
	var ss2:chat_msg_t = new chat_msg_t();
	ba.position = 0;
	FFUtil.DecodeMsg(ss2, ba);
	trace("OhNice:" + ss1.value);
	*/
	//MsgToByteArray(SharedStruct);
	if (isConn) 
	{
		//head
		socket.writeInt(byteArray.length);
		socket.writeShort(cmd);
		socket.writeShort(0);
		//body
		socket.writeBytes(byteArray, 0, byteArray.length); 
		socket.flush();
	}
	else 
	{
		mc_page1.incomingChat_txt.htmlText += "<font color='#ff0000' face='宋体' size='20'>你已断开连接，请重新连接！！！</font>"; 
		trace("没有连接上啊啊啊！！！");
	}
}

function sendMsg( cmd:int, msg:String):void 
{//发送消息
	if (isConn) 
	{
		if (cmd == 0)//! login msg
		{
			var thisStringBytsLength :ByteArray = new ByteArray();
	    	thisStringBytsLength.writeMultiByte(msg,"utf-8");
			sendBytesData(cmd, thisStringBytsLength);
    		trace( msg + " sendMsg长度： " + GetStringLength(msg) + " cmd:" + cmd);
		}
		else
		{
			var chat_msg:chat_msg_t = new chat_msg_t();
			chat_msg.value = msg;
			var ba:ByteArray = new ByteArray();
			FFUtil.EncodeMsg(chat_msg, ba);
			ba.position = 0;
			sendBytesData(cmd, ba);
			trace( msg + " sendffMsg长度： " + ba.length + " cmd:" + cmd);
		}
	}
	else 
	{
		mc_page1.incomingChat_txt.htmlText += "<font color='#ff0000' face='宋体' size='20'>你已断开连接，请重新连接！！！</font>"; 
		trace("没有连接上啊啊啊！！！");
	}
}
function onReceiveData(e:ProgressEvent):void
{//收到消息
	while (socket.bytesAvailable) 
	{
		var body_len:int = socket.readInt();
		var command:int =  socket.readShort();
		var reversed:int = socket.readShort();
		
		trace("接受到的cmd:"+command);
		if (command == 2)
		{
			var ba:ByteArray = new ByteArray();
			socket.readBytes(ba, 0, body_len);
			var chat_msg:chat_msg_t = new chat_msg_t();
			FFUtil.DecodeMsg(chat_msg, ba);
			mc_page1.incomingChat_txt.htmlText += chat_msg.value; 
		}
		else
		{
			var msg:String = socket.readUTFBytes(body_len);
			mc_page1.incomingChat_txt.htmlText += msg; 
		}
	}
}

function SendMsg()
{
	if (mc_page1.sendChat_txt.text.length>0) 
	{
		sendMsg(1, mc_page1.sendChat_txt.text);
	}
	mc_page1.sendChat_txt.text="";
}

function onSendClicked(evt:Event) 
{
	SendMsg();
}

function GetStringLength(thisString : String) : Number
{
     var thisStringBytsLength :ByteArray = new ByteArray();
     thisStringBytsLength.writeMultiByte(thisString,"utf-8");
     return thisStringBytsLength.length;
}