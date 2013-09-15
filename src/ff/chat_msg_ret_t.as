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


  public class chat_msg_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("chat_msg_ret_t");
    private static const FROM_UID_FIELD_DESC:TField = new TField("from_uid", TType.I32, 1);
    private static const VALUE_FIELD_DESC:TField = new TField("value", TType.STRING, 2);

    private var _from_uid:int;
    public static const FROM_UID:int = 1;
    private var _value:String;
    public static const VALUE:int = 2;

    private var __isset_from_uid:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[FROM_UID] = new FieldMetaData("from_uid", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
      metaDataMap[VALUE] = new FieldMetaData("value", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
    }
    {
      FieldMetaData.addStructMetaDataMap(chat_msg_ret_t, metaDataMap);
    }

    public function chat_msg_ret_t() {
      this._from_uid = 0;
    }

    public function get from_uid():int {
      return this._from_uid;
    }

    public function set from_uid(from_uid:int):void {
      this._from_uid = from_uid;
      this.__isset_from_uid = true;
    }

    public function unsetFrom_uid():void {
      this.__isset_from_uid = false;
    }

    // Returns true if field from_uid is set (has been assigned a value) and false otherwise
    public function isSetFrom_uid():Boolean {
      return this.__isset_from_uid;
    }

    public function get value():String {
      return this._value;
    }

    public function set value(value:String):void {
      this._value = value;
    }

    public function unsetValue():void {
      this.value = null;
    }

    // Returns true if field value is set (has been assigned a value) and false otherwise
    public function isSetValue():Boolean {
      return this.value != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case FROM_UID:
        if (value == null) {
          unsetFrom_uid();
        } else {
          this.from_uid = value;
        }
        break;

      case VALUE:
        if (value == null) {
          unsetValue();
        } else {
          this.value = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case FROM_UID:
        return this.from_uid;
      case VALUE:
        return this.value;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case FROM_UID:
        return isSetFrom_uid();
      case VALUE:
        return isSetValue();
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
          case FROM_UID:
            if (field.type == TType.I32) {
              this.from_uid = iprot.readI32();
              this.__isset_from_uid = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case VALUE:
            if (field.type == TType.STRING) {
              this.value = iprot.readString();
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
      oprot.writeFieldBegin(FROM_UID_FIELD_DESC);
      oprot.writeI32(this.from_uid);
      oprot.writeFieldEnd();
      if (this.value != null) {
        oprot.writeFieldBegin(VALUE_FIELD_DESC);
        oprot.writeString(this.value);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("chat_msg_ret_t(");
      var first:Boolean = true;

      ret += "from_uid:";
      ret += this.from_uid;
      first = false;
      if (!first) ret +=  ", ";
      ret += "value:";
      if (this.value == null) {
        ret += "null";
      } else {
        ret += this.value;
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