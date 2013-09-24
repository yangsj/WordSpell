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


  public class pack_info_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("pack_info_t");
    private static const ITEM_LIST_FIELD_DESC:TField = new TField("item_list", TType.LIST, 1);

    private var _item_list:Array;
    public static const ITEM_LIST:int = 1;


    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[ITEM_LIST] = new FieldMetaData("item_list", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new StructMetaData(TType.STRUCT, item_t)));
    }
    {
      FieldMetaData.addStructMetaDataMap(pack_info_t, metaDataMap);
    }

    public function pack_info_t() {
    }

    public function get item_list():Array {
      return this._item_list;
    }

    public function set item_list(item_list:Array):void {
      this._item_list = item_list;
    }

    public function unsetItem_list():void {
      this.item_list = null;
    }

    // Returns true if field item_list is set (has been assigned a value) and false otherwise
    public function isSetItem_list():Boolean {
      return this.item_list != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case ITEM_LIST:
        if (value == null) {
          unsetItem_list();
        } else {
          this.item_list = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case ITEM_LIST:
        return this.item_list;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case ITEM_LIST:
        return isSetItem_list();
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
          case ITEM_LIST:
            if (field.type == TType.LIST) {
              {
                var _list40:TList = iprot.readListBegin();
                this.item_list = new Array();
                for (var _i41:int = 0; _i41 < _list40.size; ++_i41)
                {
                  var _elem42:item_t;
                  _elem42 = new item_t();
                  _elem42.read(iprot);
                  this.item_list.push(_elem42);
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
      if (this.item_list != null) {
        oprot.writeFieldBegin(ITEM_LIST_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRUCT, this.item_list.length));
          for each (var elem43:* in this.item_list)          {
            elem43.write(oprot);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("pack_info_t(");
      var first:Boolean = true;

      ret += "item_list:";
      if (this.item_list == null) {
        ret += "null";
      } else {
        ret += this.item_list;
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