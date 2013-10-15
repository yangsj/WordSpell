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


  public class round_group_info_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("round_group_info_t");
    private static const ROUND_ID_FIELD_DESC:TField = new TField("round_id", TType.I32, 1);
    private static const STATUS_FIELD_DESC:TField = new TField("status", TType.I16, 3);
    private static const ROUND_INFO_FIELD_DESC:TField = new TField("round_info", TType.LIST, 4);

    private var _round_id:int;
    public static const ROUND_ID:int = 1;
    private var _status:int;
    public static const STATUS:int = 3;
    private var _round_info:Array;
    public static const ROUND_INFO:int = 4;

    private var __isset_round_id:Boolean = false;
    private var __isset_status:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[ROUND_ID] = new FieldMetaData("round_id", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[STATUS] = new FieldMetaData("status", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[ROUND_INFO] = new FieldMetaData("round_info", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new StructMetaData(TType.STRUCT, round_info_t)));
    }
    {
      FieldMetaData.addStructMetaDataMap(round_group_info_t, metaDataMap);
    }

    public function round_group_info_t() {
      this._round_id = 0;
      this._status = 0;
    }

    public function get round_id():int {
      return this._round_id;
    }

    public function set round_id(round_id:int):void {
      this._round_id = round_id;
      this.__isset_round_id = true;
    }

    public function unsetRound_id():void {
      this.__isset_round_id = false;
    }

    // Returns true if field round_id is set (has been assigned a value) and false otherwise
    public function isSetRound_id():Boolean {
      return this.__isset_round_id;
    }

    public function get status():int {
      return this._status;
    }

    public function set status(status:int):void {
      this._status = status;
      this.__isset_status = true;
    }

    public function unsetStatus():void {
      this.__isset_status = false;
    }

    // Returns true if field status is set (has been assigned a value) and false otherwise
    public function isSetStatus():Boolean {
      return this.__isset_status;
    }

    public function get round_info():Array {
      return this._round_info;
    }

    public function set round_info(round_info:Array):void {
      this._round_info = round_info;
    }

    public function unsetRound_info():void {
      this.round_info = null;
    }

    // Returns true if field round_info is set (has been assigned a value) and false otherwise
    public function isSetRound_info():Boolean {
      return this.round_info != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case ROUND_ID:
        if (value == null) {
          unsetRound_id();
        } else {
          this.round_id = value;
        }
        break;

      case STATUS:
        if (value == null) {
          unsetStatus();
        } else {
          this.status = value;
        }
        break;

      case ROUND_INFO:
        if (value == null) {
          unsetRound_info();
        } else {
          this.round_info = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case ROUND_ID:
        return this.round_id;
      case STATUS:
        return this.status;
      case ROUND_INFO:
        return this.round_info;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case ROUND_ID:
        return isSetRound_id();
      case STATUS:
        return isSetStatus();
      case ROUND_INFO:
        return isSetRound_info();
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
          case ROUND_ID:
            if (field.type == TType.I32) {
              this.round_id = iprot.readI32();
              this.__isset_round_id = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case STATUS:
            if (field.type == TType.I16) {
              this.status = iprot.readI16();
              this.__isset_status = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ROUND_INFO:
            if (field.type == TType.LIST) {
              {
                var _list120:TList = iprot.readListBegin();
                this.round_info = new Array();
                for (var _i121:int = 0; _i121 < _list120.size; ++_i121)
                {
                  var _elem122:round_info_t;
                  _elem122 = new round_info_t();
                  _elem122.read(iprot);
                  this.round_info.push(_elem122);
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
      oprot.writeFieldBegin(ROUND_ID_FIELD_DESC);
      oprot.writeI32(this.round_id);
      oprot.writeFieldEnd();
      oprot.writeFieldBegin(STATUS_FIELD_DESC);
      oprot.writeI16(this.status);
      oprot.writeFieldEnd();
      if (this.round_info != null) {
        oprot.writeFieldBegin(ROUND_INFO_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRUCT, this.round_info.length));
          for each (var elem123:* in this.round_info)          {
            elem123.write(oprot);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("round_group_info_t(");
      var first:Boolean = true;

      ret += "round_id:";
      ret += this.round_id;
      first = false;
      if (!first) ret +=  ", ";
      ret += "status:";
      ret += this.status;
      first = false;
      if (!first) ret +=  ", ";
      ret += "round_info:";
      if (this.round_info == null) {
        ret += "null";
      } else {
        ret += this.round_info;
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
