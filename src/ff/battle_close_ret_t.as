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


  public class battle_close_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("battle_close_ret_t");
    private static const WIN_FIELD_DESC:TField = new TField("win", TType.BOOL, 1);

    private var _win:Boolean;
    public static const WIN:int = 1;

    private var __isset_win:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[WIN] = new FieldMetaData("win", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.BOOL));
    }
    {
      FieldMetaData.addStructMetaDataMap(battle_close_ret_t, metaDataMap);
    }

    public function battle_close_ret_t() {
      this._win = 0;
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

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case WIN:
        if (value == null) {
          unsetWin();
        } else {
          this.win = value;
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
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case WIN:
        return isSetWin();
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
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("battle_close_ret_t(");
      var first:Boolean = true;

      ret += "win:";
      ret += this.win;
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