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


  public class bubble_info_t implements TBase   {
    private static const STRUCT_DESC:TStruct = new TStruct("bubble_info_t");
    private static const BUBBLE_ID_FIELD_DESC:TField = new TField("bubble_id", TType.I16, 1);
    private static const WORD_FIELD_DESC:TField = new TField("word", TType.STRING, 2);
    private static const ITEM_TYPE_FIELD_DESC:TField = new TField("item_type", TType.I16, 3);

    private var _bubble_id:int;
    public static const BUBBLE_ID:int = 1;
    private var _word:String;
    public static const WORD:int = 2;
    private var _item_type:int;
    public static const ITEM_TYPE:int = 3;

    private var __isset_bubble_id:Boolean = false;
    private var __isset_item_type:Boolean = false;

    public static const metaDataMap:Dictionary = new Dictionary();
    {
      metaDataMap[BUBBLE_ID] = new FieldMetaData("bubble_id", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
      metaDataMap[WORD] = new FieldMetaData("word", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.STRING));
      metaDataMap[ITEM_TYPE] = new FieldMetaData("item_type", TFieldRequirementType.DEFAULT, 
          new FieldValueMetaData(TType.I16));
    }
    {
      FieldMetaData.addStructMetaDataMap(bubble_info_t, metaDataMap);
    }

    public function bubble_info_t() {
      this._bubble_id = 0;
      this._item_type = 0;
    }

    public function get bubble_id():int {
      return this._bubble_id;
    }

    public function set bubble_id(bubble_id:int):void {
      this._bubble_id = bubble_id;
      this.__isset_bubble_id = true;
    }

    public function unsetBubble_id():void {
      this.__isset_bubble_id = false;
    }

    // Returns true if field bubble_id is set (has been assigned a value) and false otherwise
    public function isSetBubble_id():Boolean {
      return this.__isset_bubble_id;
    }

    public function get word():String {
      return this._word;
    }

    public function set word(word:String):void {
      this._word = word;
    }

    public function unsetWord():void {
      this.word = null;
    }

    // Returns true if field word is set (has been assigned a value) and false otherwise
    public function isSetWord():Boolean {
      return this.word != null;
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
      case BUBBLE_ID:
        if (value == null) {
          unsetBubble_id();
        } else {
          this.bubble_id = value;
        }
        break;

      case WORD:
        if (value == null) {
          unsetWord();
        } else {
          this.word = value;
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
      case BUBBLE_ID:
        return this.bubble_id;
      case WORD:
        return this.word;
      case ITEM_TYPE:
        return this.item_type;
      default:
        throw new ArgumentError("Field " + fieldID + " doesn't exist!");
      }
    }

    // Returns true if field corresponding to fieldID is set (has been assigned a value) and false otherwise
    public function isSet(fieldID:int):Boolean {
      switch (fieldID) {
      case BUBBLE_ID:
        return isSetBubble_id();
      case WORD:
        return isSetWord();
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
          case BUBBLE_ID:
            if (field.type == TType.I16) {
              this.bubble_id = iprot.readI16();
              this.__isset_bubble_id = true;
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case WORD:
            if (field.type == TType.STRING) {
              this.word = iprot.readString();
            } else { 
              TProtocolUtil.skip(iprot, field.type);
            }
            break;
          case ITEM_TYPE:
            if (field.type == TType.I16) {
              this.item_type = iprot.readI16();
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
      oprot.writeFieldBegin(BUBBLE_ID_FIELD_DESC);
      oprot.writeI16(this.bubble_id);
      oprot.writeFieldEnd();
      if (this.word != null) {
        oprot.writeFieldBegin(WORD_FIELD_DESC);
        oprot.writeString(this.word);
        oprot.writeFieldEnd();
      }
      oprot.writeFieldBegin(ITEM_TYPE_FIELD_DESC);
      oprot.writeI16(this.item_type);
      oprot.writeFieldEnd();
      oprot.writeFieldStop();
      oprot.writeStructEnd();
    }

    public function toString():String {
      var ret:String = new String("bubble_info_t(");
      var first:Boolean = true;

      ret += "bubble_id:";
      ret += this.bubble_id;
      first = false;
      if (!first) ret +=  ", ";
      ret += "word:";
      if (this.word == null) {
        ret += "null";
      } else {
        ret += this.word;
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
