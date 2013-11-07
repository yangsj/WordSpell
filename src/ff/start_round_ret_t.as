/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
package ff {

import org.apache.thrift.Set;
import flash.utils.ByteArray;
import flash.utils.Dictionary;

import org.apache.thrift.*;
import org.apache.thrift.meta_data.*;
import org.apache.thrift.protocol.*;


  public class start_round_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("start_round_ret_t");
    private static const MODE_FIELD_DESC:TField = new TField("mode", TType.I16, 1);
    private static const CHINESE_WORDS_FIELD_DESC:TField = new TField("chinese_words", TType.LIST, 2);
    private static const BLANK_FIELD_DESC:TField = new TField("blank", TType.LIST, 3);
    private static const BUBBLE_INFO_FIELD_DESC:TField = new TField("bubble_info", TType.LIST, 4);
    private static const BUBBLE_ITEM_FIELD_DESC:TField = new TField("bubble_item", TType.MAP, 5);
    private static const ROUND_TYPE_FIELD_DESC:TField = new TField("round_type", TType.I16, 6);

    private var _mode:int;
    public static const MODE:int = 1;
    private var _chinese_words:Array;
    public static const CHINESE_WORDS:int = 2;
    private var _blank:Array;
    public static const BLANK:int = 3;
    private var _bubble_info:Array;
    public static const BUBBLE_INFO:int = 4;
    private var _bubble_item:Dictionary;
    public static const BUBBLE_ITEM:int = 5;
    private var _round_type:int;
    public static const ROUND_TYPE:int = 6;

    private var __isset_mode:Boolean = false;
    private var __isset_round_type:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[MODE] = new FieldMetaData("mode", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[CHINESE_WORDS] = new FieldMetaData("chinese_words", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new FieldValueMetaData(TType.STRING)));
      metaDataMap[BLANK] = new FieldMetaData("blank", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new FieldValueMetaData(TType.I32)));
      metaDataMap[BUBBLE_INFO] = new FieldMetaData("bubble_info", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new StructMetaData(TType.STRUCT, bubble_info_t)));
      metaDataMap[BUBBLE_ITEM] = new FieldMetaData("bubble_item", TFieldRequirementType.DEFAULT, 
          new MapMetaData(TType.MAP, 
              new FieldValueMetaData(TType.I16), 
              new ListMetaData(TType.LIST, 
                  new StructMetaData(TType.STRUCT, bubble_info_t))));
      metaDataMap[ROUND_TYPE] = new FieldMetaData("round_type", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
    }
    {
      FieldMetaData.addStructMetaDataMap(start_round_ret_t, metaDataMap);
    }

    public function start_round_ret_t() {
      this._mode = 0;
      this._round_type = -1;
    }

    public function get mode():int {
      return this._mode;
    }

    public function set mode(mode:int):void {
      this._mode = mode;
      this.__isset_mode = true;
    }

    public function unsetMode():void {
      this.__isset_mode = false;
    }

    // Returns true if field mode is set (has been assigned a value) and false otherwise
    public function isSetMode():Boolean {
      return this.__isset_mode;
    }

    public function get chinese_words():Array {
      return this._chinese_words;
    }

    public function set chinese_words(chinese_words:Array):void {
      this._chinese_words = chinese_words;
    }

    public function unsetChinese_words():void {
      this.chinese_words = null;
    }

    // Returns true if field chinese_words is set (has been assigned a value) and false otherwise
    public function isSetChinese_words():Boolean {
      return this.chinese_words != null;
    }

    public function get blank():Array {
      return this._blank;
    }

    public function set blank(blank:Array):void {
      this._blank = blank;
    }

    public function unsetBlank():void {
      this.blank = null;
    }

    // Returns true if field blank is set (has been assigned a value) and false otherwise
    public function isSetBlank():Boolean {
      return this.blank != null;
    }

    public function get bubble_info():Array {
      return this._bubble_info;
    }

    public function set bubble_info(bubble_info:Array):void {
      this._bubble_info = bubble_info;
    }

    public function unsetBubble_info():void {
      this.bubble_info = null;
    }

    // Returns true if field bubble_info is set (has been assigned a value) and false otherwise
    public function isSetBubble_info():Boolean {
      return this.bubble_info != null;
    }

    public function get bubble_item():Dictionary {
      return this._bubble_item;
    }

    public function set bubble_item(bubble_item:Dictionary):void {
      this._bubble_item = bubble_item;
    }

    public function unsetBubble_item():void {
      this.bubble_item = null;
    }

    // Returns true if field bubble_item is set (has been assigned a value) and false otherwise
    public function isSetBubble_item():Boolean {
      return this.bubble_item != null;
    }

    public function get round_type():int {
      return this._round_type;
    }

    public function set round_type(round_type:int):void {
      this._round_type = round_type;
      this.__isset_round_type = true;
    }

    public function unsetRound_type():void {
      this.__isset_round_type = false;
    }

    // Returns true if field round_type is set (has been assigned a value) and false otherwise
    public function isSetRound_type():Boolean {
      return this.__isset_round_type;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case MODE:
        if (value == null) {
          unsetMode();
        } else {
          this.mode = value;
        }
        break;

      case CHINESE_WORDS:
        if (value == null) {
          unsetChinese_words();
        } else {
          this.chinese_words = value;
        }
        break;

      case BLANK:
        if (value == null) {
          unsetBlank();
        } else {
          this.blank = value;
        }
        break;

      case BUBBLE_INFO:
        if (value == null) {
          unsetBubble_info();
        } else {
          this.bubble_info = value;
        }
        break;

      case BUBBLE_ITEM:
        if (value == null) {
          unsetBubble_item();
        } else {
          this.bubble_item = value;
        }
        break;

      case ROUND_TYPE:
        if (value == null) {
          unsetRound_type();
        } else {
          this.round_type = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case MODE:
        return this.mode;
      case CHINESE_WORDS:
        return this.chinese_words;
      case BLANK:
        return this.blank;
      case BUBBLE_INFO:
        return this.bubble_info;
      case BUBBLE_ITEM:
        return this.bubble_item;
      case ROUND_TYPE:
        return this.round_type;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case MODE:
        return isSetMode();
      case CHINESE_WORDS:
        return isSetChinese_words();
      case BLANK:
        return isSetBlank();
      case BUBBLE_INFO:
        return isSetBubble_info();
      case BUBBLE_ITEM:
        return isSetBubble_item();
      case ROUND_TYPE:
        return isSetRound_type();
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function read(iprot:TProtocol):void {
      var field:TField;
      iprot.readStructBegin();
      while (true)
      {
        field = iprot.readFieldBegin();
        if (field.type == TType.STOP) { 
          break;
        }
        switch (field.id)
        {
          case MODE:
            if (field.type == TType.I16) {
              this.mode = iprot.readI16();
              this.__isset_mode = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case CHINESE_WORDS:
            if (field.type == TType.LIST) {
              {
                var _list162:TList = iprot.readListBegin();
                this.chinese_words = new Array();
                for (var _i163:int = 0; _i163 < _list162.size; ++_i163)
                {
                  var _elem164:String;
                  _elem164 = iprot.readString();
                  this.chinese_words.push(_elem164);
                }
                iprot.readListEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case BLANK:
            if (field.type == TType.LIST) {
              {
                var _list165:TList = iprot.readListBegin();
                this.blank = new Array();
                for (var _i166:int = 0; _i166 < _list165.size; ++_i166)
                {
                  var _elem167:int;
                  _elem167 = iprot.readI32();
                  this.blank.push(_elem167);
                }
                iprot.readListEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case BUBBLE_INFO:
            if (field.type == TType.LIST) {
              {
                var _list168:TList = iprot.readListBegin();
                this.bubble_info = new Array();
                for (var _i169:int = 0; _i169 < _list168.size; ++_i169)
                {
                  var _elem170:bubble_info_t;
                  _elem170 = new bubble_info_t();
                  _elem170.read(iprot);
                  this.bubble_info.push(_elem170);
                }
                iprot.readListEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case BUBBLE_ITEM:
            if (field.type == TType.MAP) {
              {
                var _map171:TMap = iprot.readMapBegin();
                this.bubble_item = new Dictionary();
                for (var _i172:int = 0; _i172 < _map171.size; ++_i172)
                {
                  var _key173:int;
                  var _val174:Array;
                  _key173 = iprot.readI16();
                  {
                    var _list175:TList = iprot.readListBegin();
                    _val174 = new Array();
                    for (var _i176:int = 0; _i176 < _list175.size; ++_i176)
                    {
                      var _elem177:bubble_info_t;
                      _elem177 = new bubble_info_t();
                      _elem177.read(iprot);
                      _val174.push(_elem177);
                    }
                    iprot.readListEnd();
                  }
                  this.bubble_item[_key173] = _val174;
                }
                iprot.readMapEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ROUND_TYPE:
            if (field.type == TType.I16) {
              this.round_type = iprot.readI16();
              this.__isset_round_type = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          default:
            TProtocolUtil.skip(iprot, field.type);
            break;
        }
        iprot.readFieldEnd();
      }
      iprot.readStructEnd();


      // check for required fields of primitive type, which can't be checked in the validate method
      validate();
    }

    public function write(oprot:TProtocol):void {
      validate();

      oprot.writeStructBegin(STRUCT_DESC);
      oprot.writeFieldBegin(MODE_FIELD_DESC);
      oprot.writeI16(this.mode);
      oprot.writeFieldEnd();
      if (this.chinese_words != null) {
        oprot.writeFieldBegin(CHINESE_WORDS_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRING, this.chinese_words.length));
          for each (var elem178:* in this.chinese_words)          {
            oprot.writeString(elem178);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      if (this.blank != null) {
        oprot.writeFieldBegin(BLANK_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.I32, this.blank.length));
          for each (var elem179:* in this.blank)          {
            oprot.writeI32(elem179);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      if (this.bubble_info != null) {
        oprot.writeFieldBegin(BUBBLE_INFO_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRUCT, this.bubble_info.length));
          for each (var elem180:* in this.bubble_info)          {
            elem180.write(oprot);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      if (this.bubble_item != null) {
        oprot.writeFieldBegin(BUBBLE_ITEM_FIELD_DESC);
        {
          var _sizeCounter182:int = 0;
          for (var _key181:* in this.bubble_item) {
            _sizeCounter182++;
          }
          oprot.writeMapBegin(new TMap(TType.I16, TType.LIST, _sizeCounter182));
          for (var elem183:* in this.bubble_item)          {
            oprot.writeI16(elem183);
            {
              oprot.writeListBegin(new TList(TType.STRUCT, this.bubble_item[elem183].length));
              for each (var elem184:* in this.bubble_item[elem183])              {
                elem184.write(oprot);
              }
              oprot.writeListEnd();
            }
          }
          oprot.writeMapEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(ROUND_TYPE_FIELD_DESC);
      oprot.writeI16(this.round_type);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("start_round_ret_t(");
      var first:Boolean = true;

      ret += "mode:";
      ret += this.mode;
      first = false;
      if (!first) ret +=  ", ";
      ret += "chinese_words:";
      if (this.chinese_words == null) {
        ret += "null";
      } else {
        ret += this.chinese_words;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "blank:";
      if (this.blank == null) {
        ret += "null";
      } else {
        ret += this.blank;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "bubble_info:";
      if (this.bubble_info == null) {
        ret += "null";
      } else {
        ret += this.bubble_info;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "bubble_item:";
      if (this.bubble_item == null) {
        ret += "null";
      } else {
        ret += this.bubble_item;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "round_type:";
      ret += this.round_type;
      first = false;
      ret += ")";
      return ret;
    }

    public function validate():void {
      // check for required fields
      // check that fields of type enum have valid values
    }

  }

}
