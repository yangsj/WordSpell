/**
 * Autogenerated by Thrift Compiler (0.9.1)
 *
 * DO NOT EDIT UNLESS YOU ARE SURE THAT YOU KNOW WHAT YOU ARE DOING
 *  @generated
 */
package ff 
{
import org.apache.thrift.Set;
import flash.utils.Dictionary;
  public class error_code_e   {
    public static const OK:int = 0;
    public static const SERVER_ERROR:int = 1;
    public static const INPUT_ERROR:int = 2;
    public static const SERVER_BUSY:int = 3;
    public static const USER_TAKEN:int = 4;
    public static const USER_INVALID:int = 5;
    public static const PASS_INVALID:int = 6;

    public static const VALID_VALUES:Set = new Set(OK, SERVER_ERROR, INPUT_ERROR, SERVER_BUSY, USER_TAKEN, USER_INVALID, PASS_INVALID);
    public static const VALUES_TO_NAMES:Dictionary = new Dictionary();
    {
      VALUES_TO_NAMES[OK] = "OK";
      VALUES_TO_NAMES[SERVER_ERROR] = "SERVER_ERROR";
      VALUES_TO_NAMES[INPUT_ERROR] = "INPUT_ERROR";
      VALUES_TO_NAMES[SERVER_BUSY] = "SERVER_BUSY";
      VALUES_TO_NAMES[USER_TAKEN] = "USER_TAKEN";
      VALUES_TO_NAMES[USER_INVALID] = "USER_INVALID";
      VALUES_TO_NAMES[PASS_INVALID] = "PASS_INVALID";

    }
  }
}
