package victor.framework.manager {
    /**
     * @author fireyang
     */
    public interface ITickManager {
        function init(frameRate : int) : void;

        function doTimeout(func : Function, delay : int = 20, ... args) : void;

        function doInterval(func : Function, delay : int = 20, ... args) : void;

        function clearDoTime(func : Function) : void;
    }
}
