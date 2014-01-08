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


  public class get_wrong_history_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("get_wrong_history_ret_t");
    private static const WRONG_WORDS_FIELD_DESC:TField = new TField("wrong_words", TType.LIST, 1);
    private static const CHINESE_FIELD_DESC:TField = new TField("chinese", TType.LIST, 2);

    private var _wrong_words:Array;
    public static const WRONG_WORDS:int = 1;
    private var _chinese:Array;
    public static const CHINESE:int = 2;


    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[WRONG_WORDS] = new FieldMetaData("wrong_words", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new FieldValueMetaData(TType.STRING)));
      metaDataMap[CHINESE] = new FieldMetaData("chinese", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new FieldValueMetaData(TType.STRING)));
    }
    {
      FieldMetaData.addStructMetaDataMap(get_wrong_history_ret_t, metaDataMap);
    }

    public function get_wrong_history_ret_t() {
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

    public function get chinese():Array {
      return this._chinese;
    }

    public function set chinese(chinese:Array):void {
      this._chinese = chinese;
    }

    public function unsetChinese():void {
      this.chinese = null;
    }

    // Returns true if field chinese is set (has been assigned a value) and false otherwise
    public function isSetChinese():Boolean {
      return this.chinese != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case WRONG_WORDS:
        if (value == null) {
          unsetWrong_words();
        } else {
          this.wrong_words = value;
        }
        break;

      case CHINESE:
        if (value == null) {
          unsetChinese();
        } else {
          this.chinese = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case WRONG_WORDS:
        return this.wrong_words;
      case CHINESE:
        return this.chinese;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case WRONG_WORDS:
        return isSetWrong_words();
      case CHINESE:
        return isSetChinese();
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
          case WRONG_WORDS:
            if (field.type == TType.LIST) {
              {
                var _list291:TList = iprot.readListBegin();
                this.wrong_words = new Array();
                for (var _i292:int = 0; _i292 < _list291.size; ++_i292)
                {
                  var _elem293:String;
                  _elem293 = iprot.readString();
                  this.wrong_words.push(_elem293);
                }
                iprot.readListEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case CHINESE:
            if (field.type == TType.LIST) {
              {
                var _list294:TList = iprot.readListBegin();
                this.chinese = new Array();
                for (var _i295:int = 0; _i295 < _list294.size; ++_i295)
                {
                  var _elem296:String;
                  _elem296 = iprot.readString();
                  this.chinese.push(_elem296);
                }
                iprot.readListEnd();
              }
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
      if (this.wrong_words != null) {
        oprot.writeFieldBegin(WRONG_WORDS_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRING, this.wrong_words.length));
          for each (var elem297:* in this.wrong_words)          {
            oprot.writeString(elem297);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      if (this.chinese != null) {
        oprot.writeFieldBegin(CHINESE_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRING, this.chinese.length));
          for each (var elem298:* in this.chinese)          {
            oprot.writeString(elem298);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("get_wrong_history_ret_t(");
      var first:Boolean = true;

      ret += "wrong_words:";
      if (this.wrong_words == null) {
        ret += "null";
      } else {
        ret += this.wrong_words;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "chinese:";
      if (this.chinese == null) {
        ret += "null";
      } else {
        ret += this.chinese;
      }
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
