package app.managers
{
	
	/**
	 * ……
	 * @author 	yangsj 
	 * 			2013-10-9
	 */
	public class FontManager
	{
		[Embed(systemFont="assets/DFPHaiBaoW12-GB.ttf", fontName="MyFont", unicodeRange="U+4e2d,U+6587,U+5b57,U+578b", mimeType="application/x-font")]
		public static var MyClass : Class;
		
		public function FontManager()
		{
		}
		
		
	}
}