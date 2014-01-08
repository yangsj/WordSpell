package app.modules.main.view
{
	import flash.display.Loader;
	import flash.display.Sprite;
	import flash.events.Event;
	import flash.net.URLRequest;
	
	import app.GameConfig;
	
	import victor.core.AnimationClip;
	
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2014-1-8
	 */
	public class ExclamatoryMarkEffect extends Sprite
	{
		/*============================================================================*/
		/* private variables                                                          */
		/*============================================================================*/
		
		private var clip:AnimationClip;
		
		/*============================================================================*/
		/* Constructor                                                                */
		/*============================================================================*/
		public function ExclamatoryMarkEffect()
		{
			var loader:Loader = new Loader();
			loader.contentLoaderInfo.addEventListener(Event.COMPLETE, loaderCompleted );
			loader.load( new URLRequest(GameConfig.deployPath + "assets/png/exclamatory_mark.png"));
			
			function loaderCompleted( event:Event ):void
			{
				
			}
		}
		
		
		private const pngXml:XML = 
			<TextureAtlas imagePath="exclamatory.png">
				<!-- Created with Adobe Flash Professional version 13.0.1.808 -->
				<!-- http://www.adobe.com/products/flash.html -->
				<SubTexture name="1.png" x="0" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="10.png" x="141" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="11.png" x="282" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="12.png" x="423" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="13.png" x="564" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="2.png" x="705" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="3.png" x="846" y="0" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="4.png" x="0" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="5.png" x="141" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="6.png" x="282" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="7.png" x="423" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="8.png" x="564" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
				<SubTexture name="9.png" x="705" y="290" width="141" height="290" pivotX="0" pivotY="0"/>
			</TextureAtlas>
		
		
	}
}