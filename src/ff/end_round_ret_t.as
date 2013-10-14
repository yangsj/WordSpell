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


  public class end_round_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("end_round_ret_t");
    private static const WIN_FIELD_DESC:TField = new TField("win", TType.BOOL, 1);
    private static const INC_STAR_FIELD_DESC:TField = new TField("inc_star", TType.I32, 2);
    private static const INC_EXP_FIELD_DESC:TField = new TField("inc_exp", TType.I32, 3);
    private static const CUR_LEVEL_FIELD_DESC:TField = new TField("cur_level", TType.I32, 4);
    private static const INC_ITEMS_FIELD_DESC:TField = new TField("inc_items", TType.MAP, 5);
    private static const RIGHT_NUM_FIELD_DESC:TField = new TField("right_num", TType.I16, 6);
    private static const WRONG_WORDS_FIELD_DESC:TField = new TField("wrong_words", TType.LIST, 7);
    private static const INC_COIN_FIELD_DESC:TField = new TField("inc_coin", TType.I32, 8);

    private var _win:Boolean;
    public static const WIN:int = 1;
    private var _inc_star:int;
    public static const INC_STAR:int = 2;
    private var _inc_exp:int;
    public static const INC_EXP:int = 3;
    private var _cur_level:int;
    public static const CUR_LEVEL:int = 4;
    private var _inc_items:Dictionary;
    public static const INC_ITEMS:int = 5;
    private var _right_num:int;
    public static const RIGHT_NUM:int = 6;
    private var _wrong_words:Array;
    public static const WRONG_WORDS:int = 7;
    private var _inc_coin:int;
    public static const INC_COIN:int = 8;

    private var __isset_win:Boolean = false;
    private var __isset_inc_star:Boolean = false;
    private var __isset_inc_exp:Boolean = false;
    private var __isset_cur_level:Boolean = false;
    private var __isset_right_num:Boolean = false;
    private var __isset_inc_coin:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[WIN] = new FieldMetaData("win", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.BOOL));
      metaDataMap[INC_STAR] = new FieldMetaData("inc_star", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[INC_EXP] = new FieldMetaData("inc_exp", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[CUR_LEVEL] = new FieldMetaData("cur_level", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[INC_ITEMS] = new FieldMetaData("inc_items", TFieldRequirementType.DEFAULT, 
          new MapMetaData(TType.MAP, 
              new FieldValueMetaData(TType.I32), 
              new FieldValueMetaData(TType.I32)));
      metaDataMap[RIGHT_NUM] = new FieldMetaData("right_num", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[WRONG_WORDS] = new FieldMetaData("wrong_words", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new FieldValueMetaData(TType.STRING)));
      metaDataMap[INC_COIN] = new FieldMetaData("inc_coin", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
    }
    {
      FieldMetaData.addStructMetaDataMap(end_round_ret_t, metaDataMap);
    }

    public function end_round_ret_t() {
      this._win = 0;
      this._inc_star = 0;
      this._inc_exp = 0;
      this._cur_level = 0;
      this._right_num = 0;
      this._inc_coin = 0;
    }

    public function get win():Boolean {
      return this._win;
    }

    public function set win(win:Boolean):void {
      this._win = win;
      this.__isset_win = true;
    }

    public function unsetWin():void {
      this.__isset_win = false;
    }

    // Returns true if field win is set (has been assigned a value) and false otherwise
    public function isSetWin():Boolean {
      return this.__isset_win;
    }

    public function get inc_star():int {
      return this._inc_star;
    }

    public function set inc_star(inc_star:int):void {
      this._inc_star = inc_star;
      this.__isset_inc_star = true;
    }

    public function unsetInc_star():void {
      this.__isset_inc_star = false;
    }

    // Returns true if field inc_star is set (has been assigned a value) and false otherwise
    public function isSetInc_star():Boolean {
      return this.__isset_inc_star;
    }

    public function get inc_exp():int {
      return this._inc_exp;
    }

    public function set inc_exp(inc_exp:int):void {
      this._inc_exp = inc_exp;
      this.__isset_inc_exp = true;
    }

    public function unsetInc_exp():void {
      this.__isset_inc_exp = false;
    }

    // Returns true if field inc_exp is set (has been assigned a value) and false otherwise
    public function isSetInc_exp():Boolean {
      return this.__isset_inc_exp;
    }

    public function get cur_level():int {
      return this._cur_level;
    }

    public function set cur_level(cur_level:int):void {
      this._cur_level = cur_level;
      this.__isset_cur_level = true;
    }

    public function unsetCur_level():void {
      this.__isset_cur_level = false;
    }

    // Returns true if field cur_level is set (has been assigned a value) and false otherwise
    public function isSetCur_level():Boolean {
      return this.__isset_cur_level;
    }

    public function get inc_items():Dictionary {
      return this._inc_items;
    }

    public function set inc_items(inc_items:Dictionary):void {
      this._inc_items = inc_items;
    }

    public function unsetInc_items():void {
      this.inc_items = null;
    }

    // Returns true if field inc_items is set (has been assigned a value) and false otherwise
    public function isSetInc_items():Boolean {
      return this.inc_items != null;
    }

    public function get right_num():int {
      return this._right_num;
    }

    public function set right_num(right_num:int):void {
      this._right_num = right_num;
      this.__isset_right_num = true;
    }

    public function unsetRight_num():void {
      this.__isset_right_num = false;
    }

    // Returns true if field right_num is set (has been assigned a value) and false otherwise
    public function isSetRight_num():Boolean {
      return this.__isset_right_num;
    }

    public function get wrong_words():Array {
      return this._wrong_words;
    }

    public function set wrong_words(wrong_words:Array):void {
      this._wrong_words = wrong_words;
    }

    public function unsetWrong_words():void {
      this.wrong_words = null;
    }

    // Returns true if field wrong_words is set (has been assigned a value) and false otherwise
    public function isSetWrong_words():Boolean {
      return this.wrong_words != null;
    }

    public function get inc_coin():int {
      return this._inc_coin;
    }

    public function set inc_coin(inc_coin:int):void {
      this._inc_coin = inc_coin;
      this.__isset_inc_coin = true;
    }

    public function unsetInc_coin():void {
      this.__isset_inc_coin = false;
    }

    // Returns true if field inc_coin is set (has been assigned a value) and false otherwise
    public function isSetInc_coin():Boolean {
      return this.__isset_inc_coin;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case WIN:
        if (value == null) {
          unsetWin();
        } else {
          this.win = value;
        }
        break;

      case INC_STAR:
        if (value == null) {
          unsetInc_star();
        } else {
          this.inc_star = value;
        }
        break;

      case INC_EXP:
        if (value == null) {
          unsetInc_exp();
        } else {
          this.inc_exp = value;
        }
        break;

      case CUR_LEVEL:
        if (value == null) {
          unsetCur_level();
        } else {
          this.cur_level = value;
        }
        break;

      case INC_ITEMS:
        if (value == null) {
          unsetInc_items();
        } else {
          this.inc_items = value;
        }
        break;

      case RIGHT_NUM:
        if (value == null) {
          unsetRight_num();
        } else {
          this.right_num = value;
        }
        break;

      case WRONG_WORDS:
        if (value == null) {
          unsetWrong_words();
        } else {
          this.wrong_words = value;
        }
        break;

      case INC_COIN:
        if (value == null) {
          unsetInc_coin();
        } else {
          this.inc_coin = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case WIN:
        return this.win;
      case INC_STAR:
        return this.inc_star;
      case INC_EXP:
        return this.inc_exp;
      case CUR_LEVEL:
        return this.cur_level;
      case INC_ITEMS:
        return this.inc_items;
      case RIGHT_NUM:
        return this.right_num;
      case WRONG_WORDS:
        return this.wrong_words;
      case INC_COIN:
        return this.inc_coin;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case WIN:
        return isSetWin();
      case INC_STAR:
        return isSetInc_star();
      case INC_EXP:
        return isSetInc_exp();
      case CUR_LEVEL:
        return isSetCur_level();
      case INC_ITEMS:
        return isSetInc_items();
      case RIGHT_NUM:
        return isSetRight_num();
      case WRONG_WORDS:
        return isSetWrong_words();
      case INC_COIN:
        return isSetInc_coin();
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
          case WIN:
            if (field.type == TType.BOOL) {
              this.win = iprot.readBool();
              this.__isset_win = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case INC_STAR:
            if (field.type == TType.I32) {
              this.inc_star = iprot.readI32();
              this.__isset_inc_star = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case INC_EXP:
            if (field.type == TType.I32) {
              this.inc_exp = iprot.readI32();
              this.__isset_inc_exp = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case CUR_LEVEL:
            if (field.type == TType.I32) {
              this.cur_level = iprot.readI32();
              this.__isset_cur_level = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case INC_ITEMS:
            if (field.type == TType.MAP) {
              {
                var _map200:TMap = iprot.readMapBegin();
                this.inc_items = new Dictionary();
                for (var _i201:int = 0; _i201 < _map200.size; ++_i201)
                {
                  var _key202:int;
                  var _val203:int;
                  _key202 = iprot.readI32();
                  _val203 = iprot.readI32();
                  this.inc_items[_key202] = _val203;
                }
                iprot.readMapEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case RIGHT_NUM:
            if (field.type == TType.I16) {
              this.right_num = iprot.readI16();
              this.__isset_right_num = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case WRONG_WORDS:
            if (field.type == TType.LIST) {
              {
                var _list204:TList = iprot.readListBegin();
                this.wrong_words = new Array();
                for (var _i205:int = 0; _i205 < _list204.size; ++_i205)
                {
                  var _elem206:String;
                  _elem206 = iprot.readString();
                  this.wrong_words.push(_elem206);
                }
                iprot.readListEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case INC_COIN:
            if (field.type == TType.I32) {
              this.inc_coin = iprot.readI32();
              this.__isset_inc_coin = true;
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
      oprot.writeFieldBegin(WIN_FIELD_DESC);
      oprot.writeBool(this.win);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(INC_STAR_FIELD_DESC);
      oprot.writeI32(this.inc_star);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(INC_EXP_FIELD_DESC);
      oprot.writeI32(this.inc_exp);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(CUR_LEVEL_FIELD_DESC);
      oprot.writeI32(this.cur_level);
      oprot.writeFieldEnd();
      if (this.inc_items != null) {
        oprot.writeFieldBegin(INC_ITEMS_FIELD_DESC);
        {
          var _sizeCounter208:int = 0;
          for (var _key207:* in this.inc_items) {
            _sizeCounter208++;
          }
          oprot.writeMapBegin(new TMap(TType.I32, TType.I32, _sizeCounter208));
          for (var elem209:* in this.inc_items)          {
            oprot.writeI32(elem209);
            oprot.writeI32(this.inc_items[elem209]);
          }
          oprot.writeMapEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(RIGHT_NUM_FIELD_DESC);
      oprot.writeI16(this.right_num);
      oprot.writeFieldEnd();
      if (this.wrong_words != null) {
        oprot.writeFieldBegin(WRONG_WORDS_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRING, this.wrong_words.length));
          for each (var elem210:* in this.wrong_words)          {
            oprot.writeString(elem210);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(INC_COIN_FIELD_DESC);
      oprot.writeI32(this.inc_coin);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("end_round_ret_t(");
      var first:Boolean = true;

      ret += "win:";
      ret += this.win;
      first = false;
      if (!first) ret +=  ", ";
      ret += "inc_star:";
      ret += this.inc_star;
      first = false;
      if (!first) ret +=  ", ";
      ret += "inc_exp:";
      ret += this.inc_exp;
      first = false;
      if (!first) ret +=  ", ";
      ret += "cur_level:";
      ret += this.cur_level;
      first = false;
      if (!first) ret +=  ", ";
      ret += "inc_items:";
      if (this.inc_items == null) {
        ret += "null";
      } else {
        ret += this.inc_items;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "right_num:";
      ret += this.right_num;
      first = false;
      if (!first) ret +=  ", ";
      ret += "wrong_words:";
      if (this.wrong_words == null) {
        ret += "null";
      } else {
        ret += this.wrong_words;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "inc_coin:";
      ret += this.inc_coin;
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
