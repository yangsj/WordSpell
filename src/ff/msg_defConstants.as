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

  public class msg_defConstants {

    public static const error_code_desc:Dictionary = new Dictionary();
    {
      new function():void {
        error_code_desc[0] = "OK";
        error_code_desc[1] = "系统错误";
        error_code_desc[2] = "输入错误";
        error_code_desc[3] = "系统忙";
        error_code_desc[4] = "此账号已被占用";
        error_code_desc[5] = "此账号无效";
        error_code_desc[6] = "无此用户或密码输入错误";
        error_code_desc[7] = "CD时间未到，您操作太过频繁";
      }();
    }

  }
}
