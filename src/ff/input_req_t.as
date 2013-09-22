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


  public class input_req_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("input_req_t");
    private static const INPUT_FIELD_DESC:TField = new TField("input", TType.LIST, 1);
    private static const ITEM_TYPE_FIELD_DESC:TField = new TField("item_type", TType.I32, 2);

    private var _input:Array;
    public static const INPUT:int = 1;
    private var _item_type:int;
    public static const ITEM_TYPE:int = 2;

    private var __isset_item_type:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[INPUT] = new FieldMetaData("input", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new FieldValueMetaData(TType.I32)));
      metaDataMap[ITEM_TYPE] = new FieldMetaData("item_type", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I32));
    }
    {
      FieldMetaData.addStructMetaDataMap(input_req_t, metaDataMap);
    }

    public function input_req_t() {
      this._item_type = 0;
    }

    public function get input():Array {
      return this._input;
    }

    public function set input(input:Array):void {
      this._input = input;
    }

    public function unsetInput():void {
      this.input = null;
    }

    // Returns true if field input is set (has been assigned a value) and false otherwise
    public function isSetInput():Boolean {
      return this.input != null;
    }

    public function get item_type():int {
      return this._item_type;
    }

    public function set item_type(item_type:int):void {
      this._item_type = item_type;
      this.__isset_item_type = true;
    }

    public function unsetItem_type():void {
      this.__isset_item_type = false;
    }

    // Returns true if field item_type is set (has been assigned a value) and false otherwise
    public function isSetItem_type():Boolean {
      return this.__isset_item_type;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case INPUT:
        if (value == null) {
          unsetInput();
        } else {
          this.input = value;
        }
        break;

      case ITEM_TYPE:
        if (value == null) {
          unsetItem_type();
        } else {
          this.item_type = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case INPUT:
        return this.input;
      case ITEM_TYPE:
        return this.item_type;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case INPUT:
        return isSetInput();
      case ITEM_TYPE:
        return isSetItem_type();
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
          case INPUT:
            if (field.type == TType.LIST) {
              {
                var _list140:TList = iprot.readListBegin();
                this.input = new Array();
                for (var _i141:int = 0; _i141 < _list140.size; ++_i141)
                {
                  var _elem142:int;
                  _elem142 = iprot.readI32();
                  this.input.push(_elem142);
                }
                iprot.readListEnd();
              }
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ITEM_TYPE:
            if (field.type == TType.I32) {
              this.item_type = iprot.readI32();
              this.__isset_item_type = true;
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
      if (this.input != null) {
        oprot.writeFieldBegin(INPUT_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.I32, this.input.length));
          for each (var elem143:* in this.input)          {
            oprot.writeI32(elem143);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(ITEM_TYPE_FIELD_DESC);
      oprot.writeI32(this.item_type);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("input_req_t(");
      var first:Boolean = true;

      ret += "input:";
      if (this.input == null) {
        ret += "null";
      } else {
        ret += this.input;
      }
      first = false;
      if (!first) ret +=  ", ";
      ret += "item_type:";
      ret += this.item_type;
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
