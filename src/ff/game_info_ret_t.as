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


  public class game_info_ret_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("game_info_ret_t");
    private static const ALL_CHAPTER_INFO_FIELD_DESC:TField = new TField("all_chapter_info", TType.MAP, 1);

    private var _all_chapter_info:Dictionary;
    public static const ALL_CHAPTER_INFO:int = 1;


    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[ALL_CHAPTER_INFO] = new FieldMetaData("all_chapter_info", TFieldRequirementType.DEFAULT, 
          new MapMetaData(TType.MAP, 
              new FieldValueMetaData(TType.I32), 
              new StructMetaData(TType.STRUCT, chapter_info_t)));
    }
    {
      FieldMetaData.addStructMetaDataMap(game_info_ret_t, metaDataMap);
    }

    public function game_info_ret_t() {
    }

    public function get all_chapter_info():Dictionary {
      return this._all_chapter_info;
    }

    public function set all_chapter_info(all_chapter_info:Dictionary):void {
      this._all_chapter_info = all_chapter_info;
    }

    public function unsetAll_chapter_info():void {
      this.all_chapter_info = null;
    }

    // Returns true if field all_chapter_info is set (has been assigned a value) and false otherwise
    public function isSetAll_chapter_info():Boolean {
      return this.all_chapter_info != null;
    }

    public function setFieldValue(fieldID:int, value:*):void {
      switch (fieldID) {
      case ALL_CHAPTER_INFO:
        if (value == null) {
          unsetAll_chapter_info();
        } else {
          this.all_chapter_info = value;
        }
        break;

      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    public function getFieldValue(fieldID:int):* {
      switch (fieldID) {
      case ALL_CHAPTER_INFO:
        return this.all_chapter_info;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case ALL_CHAPTER_INFO:
        return isSetAll_chapter_info();
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
          case ALL_CHAPTER_INFO:
            if (field.type == TType.MAP) {
              {
                var _map112:TMap = iprot.readMapBegin();
                this.all_chapter_info = new Dictionary();
                for (var _i113:int = 0; _i113 < _map112.size; ++_i113)
                {
                  var _key114:int;
                  var _val115:chapter_info_t;
                  _key114 = iprot.readI32();
                  _val115 = new chapter_info_t();
                  _val115.read(iprot);
                  this.all_chapter_info[_key114] = _val115;
                }
                iprot.readMapEnd();
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
      if (this.all_chapter_info != null) {
        oprot.writeFieldBegin(ALL_CHAPTER_INFO_FIELD_DESC);
        {
          var _sizeCounter117:int = 0;
          for (var _key116:* in this.all_chapter_info) {
            _sizeCounter117++;
          }
          oprot.writeMapBegin(new TMap(TType.I32, TType.STRUCT, _sizeCounter117));
          for (var elem118:* in this.all_chapter_info)          {
            oprot.writeI32(elem118);
            this.all_chapter_info[elem118].write(oprot);
          }
          oprot.writeMapEnd();
        }
        oprot.writeFieldEnd();
      }
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("game_info_ret_t(");
      var first:Boolean = true;

      ret += "all_chapter_info:";
      if (this.all_chapter_info == null) {
        ret += "null";
      } else {
        ret += this.all_chapter_info;
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
