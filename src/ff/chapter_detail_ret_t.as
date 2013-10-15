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


  public class chapter_detail_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("chapter_detail_ret_t");
    private static const CHAPTER_TYPE_FIELD_DESC:TField = new TField("chapter_type", TType.I32, 1);
    private static const ROUND_GROUP_INFO_FIELD_DESC:TField = new TField("round_group_info", TType.LIST, 2);

    private var _chapter_type:int;
    public static const CHAPTER_TYPE:int = 1;
    private var _round_group_info:Array;
    public static const ROUND_GROUP_INFO:int = 2;

    private var __isset_chapter_type:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[CHAPTER_TYPE] = new FieldMetaData("chapter_type", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[ROUND_GROUP_INFO] = new FieldMetaData("round_group_info", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new StructMetaData(TType.STRUCT, round_group_info_t)));
    }
    {
      FieldMetaData.addStructMetaDataMap(chapter_detail_ret_t, metaDataMap);
    }

    public function chapter_detail_ret_t() {
      this._chapter_type = 0;
    }

    public function get chapter_type():int {
      return this._chapter_type;
    }

    public function set chapter_type(chapter_type:int):void {
      this._chapter_type = chapter_type;
      this.__isset_chapter_type = true;
    }

    public function unsetChapter_type():void {
      this.__isset_chapter_type = false;
    }

    // Returns true if field chapter_type is set (has been assigned a value) and false otherwise
    public function isSetChapter_type():Boolean {
      return this.__isset_chapter_type;
    }

    public function get round_group_info():Array {
      return this._round_group_info;
    }

    public function set round_group_info(round_group_info:Array):void {
      this._round_group_info = round_group_info;
    }

    public function unsetRound_group_info():void {
      this.round_group_info = null;
    }

    // Returns true if field round_group_info is set (has been assigned a value) and false otherwise
    public function isSetRound_group_info():Boolean {
      return this.round_group_info != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case CHAPTER_TYPE:
        if (value == null) {
          unsetChapter_type();
        } else {
          this.chapter_type = value;
        }
        break;

      case ROUND_GROUP_INFO:
        if (value == null) {
          unsetRound_group_info();
        } else {
          this.round_group_info = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case CHAPTER_TYPE:
        return this.chapter_type;
      case ROUND_GROUP_INFO:
        return this.round_group_info;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case CHAPTER_TYPE:
        return isSetChapter_type();
      case ROUND_GROUP_INFO:
        return isSetRound_group_info();
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
          case CHAPTER_TYPE:
            if (field.type == TType.I32) {
              this.chapter_type = iprot.readI32();
              this.__isset_chapter_type = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ROUND_GROUP_INFO:
            if (field.type == TType.LIST) {
              {
                var _list126:TList = iprot.readListBegin();
                this.round_group_info = new Array();
                for (var _i127:int = 0; _i127 < _list126.size; ++_i127)
                {
                  var _elem128:round_group_info_t;
                  _elem128 = new round_group_info_t();
                  _elem128.read(iprot);
                  this.round_group_info.push(_elem128);
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
      oprot.writeFieldBegin(CHAPTER_TYPE_FIELD_DESC);
      oprot.writeI32(this.chapter_type);
      oprot.writeFieldEnd();
      if (this.round_group_info != null) {
        oprot.writeFieldBegin(ROUND_GROUP_INFO_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRUCT, this.round_group_info.length));
          for each (var elem129:* in this.round_group_info)          {
            elem129.write(oprot);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("chapter_detail_ret_t(");
      var first:Boolean = true;

      ret += "chapter_type:";
      ret += this.chapter_type;
      first = false;
      if (!first) ret +=  ", ";
      ret += "round_group_info:";
      if (this.round_group_info == null) {
        ret += "null";
      } else {
        ret += this.round_group_info;
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
