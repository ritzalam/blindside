package model.component
{
	public class Ellipse extends DrawObject
	{
		public function Ellipse(segment:Array, color:uint, thickness:uint)
		{
			super();
			this.type = DrawObject.ELLIPSE;
			this.shape = segment;
			this.color = color;
			this.thickness = thickness;
			optimize();
		}
		
		/**
		 * Gets rid of the unnecessary data in the segment array, so that the object can be more easily passed to
		 * the server 
		 * 
		 */		
		private function optimize():void{
			var x1:Number = this.shape[0];
			var y1:Number = this.shape[1];
			var x2:Number = this.shape[this.shape.length - 2];
			var y2:Number = this.shape[this.shape.length - 1];
			
			this.shape = new Array();
			this.shape.push(x1);
			this.shape.push(y1);
			this.shape.push(x2);
			this.shape.push(y2);
		}
		
	}
}