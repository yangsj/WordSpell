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


  public class task_info_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("task_info_t");
    private static const TASK_LIST_FIELD_DESC:TField = new TField("task_list", TType.LIST, 1);

    private var _task_list:Array;
    public static const TASK_LIST:int = 1;


    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[TASK_LIST] = new FieldMetaData("task_list", TFieldRequirementType.DEFAULT, 
          new ListMetaData(TType.LIST, 
              new StructMetaData(TType.STRUCT, task_t)));
    }
    {
      FieldMetaData.addStructMetaDataMap(task_info_t, metaDataMap);
    }

    public function task_info_t() {
    }

    public function get task_list():Array {
      return this._task_list;
    }

    public function set task_list(task_list:Array):void {
      this._task_list = task_list;
    }

    public function unsetTask_list():void {
      this.task_list = null;
    }

    // Returns true if field task_list is set (has been assigned a value) and false otherwise
    public function isSetTask_list():Boolean {
      return this.task_list != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case TASK_LIST:
        if (value == null) {
          unsetTask_list();
        } else {
          this.task_list = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case TASK_LIST:
        return this.task_list;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case TASK_LIST:
        return isSetTask_list();
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
          case TASK_LIST:
            if (field.type == TType.LIST) {
              {
                var _list95:TList = iprot.readListBegin();
                this.task_list = new Array();
                for (var _i96:int = 0; _i96 < _list95.size; ++_i96)
                {
                  var _elem97:task_t;
                  _elem97 = new task_t();
                  _elem97.read(iprot);
                  this.task_list.push(_elem97);
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
      if (this.task_list != null) {
        oprot.writeFieldBegin(TASK_LIST_FIELD_DESC);
        {
          oprot.writeListBegin(new TList(TType.STRUCT, this.task_list.length));
          for each (var elem98:* in this.task_list)          {
            elem98.write(oprot);
          }
          oprot.writeListEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("task_info_t(");
      var first:Boolean = true;

      ret += "task_list:";
      if (this.task_list == null) {
        ret += "null";
      } else {
        ret += this.task_list;
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
