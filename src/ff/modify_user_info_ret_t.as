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


  public class modify_user_info_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("modify_user_info_ret_t");
    private static const FLAG_FIELD_DESC:TField = new TField("flag", TType.BOOL, 1);

    private var _flag:Boolean;
    public static const FLAG:int = 1;

    private var __isset_flag:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[FLAG] = new FieldMetaData("flag", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.BOOL));
    }
    {
      FieldMetaData.addStructMetaDataMap(modify_user_info_ret_t, metaDataMap);
    }

    public function modify_user_info_ret_t() {
      this._flag = 1;
    }

    public function get flag():Boolean {
      return this._flag;
    }

    public function set flag(flag:Boolean):void {
      this._flag = flag;
      this.__isset_flag = true;
    }

    public function unsetFlag():void {
      this.__isset_flag = false;
    }

    // Returns true if field flag is set (has been assigned a value) and false otherwise
    public function isSetFlag():Boolean {
      return this.__isset_flag;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case FLAG:
        if (value == null) {
          unsetFlag();
        } else {
          this.flag = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case FLAG:
        return this.flag;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case FLAG:
        return isSetFlag();
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
          case FLAG:
            if (field.type == TType.BOOL) {
              this.flag = iprot.readBool();
              this.__isset_flag = true;
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
      oprot.writeFieldBegin(FLAG_FIELD_DESC);
      oprot.writeBool(this.flag);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("modify_user_info_ret_t(");
      var first:Boolean = true;

      ret += "flag:";
      ret += this.flag;
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
