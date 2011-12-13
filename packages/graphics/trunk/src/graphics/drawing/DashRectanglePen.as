﻿/*
  Version: MPL 1.1/GPL 2.0/LGPL 2.1
 
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at
  http://www.mozilla.org/MPL/
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the
  License.
  
  The Original Code is [maashaack framework].
  
  The Initial Developers of the Original Code are
  Zwetan Kjukov <zwetan@gmail.com> and Marc Alcaraz <ekameleon@gmail.com>.
  Portions created by the Initial Developers are Copyright (C) 2006-2011
  the Initial Developers. All Rights Reserved.
  
  Contributor(s):
  
  Alternatively, the contents of this file may be used under the terms of
  either the GNU General Public License Version 2 or later (the "GPL"), or
  the GNU Lesser General Public License Version 2.1 or later (the "LGPL"),
  in which case the provisions of the GPL or the LGPL are applicable instead
  of those above. If you wish to allow use of your version of this file only
  under the terms of either the GPL or the LGPL, and not to allow others to
  use your version of this file under the terms of the MPL, indicate your
  decision by deleting the provisions above and replace them with the notice
  and other provisions required by the LGPL or the GPL. If you do not delete
  the provisions above, a recipient may use your version of this file under
  the terms of any one of the MPL, the GPL or the LGPL.
*/
package graphics.drawing 
{
    import system.hack;
    
    /**
     * This pen draw a dashed rectangle shape with a Graphics object.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import graphics.Align ;
     * import graphics.FillStyle ;
     * import graphics.LineStyle ;
     * 
     * import graphics.drawing.DashRectanglePen ;
     * 
     * import flash.display.Shape ;
     * 
     * var shape:Shape = new Shape() ;
     * shape.x = 740 / 2 ;
     * shape.y = 420 / 2 ;
     * 
     * addChild( shape ) ;
     * 
     * var pen:DashRectanglePen = new DashRectanglePen( shape.graphics , 0, 0, 200, 200,  Align.CENTER ) ;
     * 
     * pen.fill    = new FillStyle( 0xEDC798 , 0.8 ) ;
     * pen.line    = new LineStyle( 2, 0xFFFFFF , 1 ) ;
     * pen.length  = 4 ;
     * pen.spacing = 6 ;
     * 
     * pen.draw() ;
     * </pre>
     */
    public dynamic class DashRectanglePen extends RectanglePen 
    {
        use namespace hack ;
        
        /**
         * Creates a new DashRectanglePen instance.
         * @param graphic The Graphics reference to control with this helper. You can passed-in a Shape or Sprite/MovieClip reference in argument.
         * @param x (optional) The x position of the pen. (default 0)
         * @param y (optional) The y position of the pen. (default 0)
         * @param width (optional) The width of the pen. (default 0)
         * @param height (optional) The height of the pen. (default 0)
         * @param align (optional) The align value of the pen. (default Align.TOP_LEFT)
         */
        public function DashRectanglePen( graphic:* = null , x:Number = 0 , y:Number = 0 , width:Number = 0 , height:Number = 0 , align:uint = 10 , length:Number = 2 , spacing:Number = 2 )
        {
            super( graphic , x, y , width, height, align);
            
            _dashline.useClear   = false ;
            _dashline.useEndFill = false ;
            
            this.length  = length ;
            this.spacing = spacing ;
        }
        
        /**
         * @private
         */
        public override function set graphics( value:* ):void
        {
            super.graphics = value ;
            _dashline.graphics = _graphics ;
        }
        
        /**
         * Determinates the length of a dash in the line.
         */
        public function get length():Number 
        {
            return _dashline.length ;
        }
        
        /**
         * @private
         */
        public function set length( value:Number):void 
        {
            _dashline.length = value ;
        }
        
        /**
         * Determinates the spacing value between two dashs in this line.
         */
        public function get spacing():Number 
        {
            return _dashline.spacing ;
        }
        
        /**
         * @private
         */
        public function set spacing( value:Number ):void 
        {
            _dashline.spacing = value ;
        }
        
        /**
         * This method contains the basic drawing shape algorithm.
         */
        public override function drawShape():void
        {
            if( _dashline.length > 0 && _dashline.spacing > 0 )
            {
                _refreshAlign() ;
                
                _graphics.clear() ;
                
                if ( _fillStyle != null )
                {
                    _fillStyle.apply( _graphics ) ;
                }
                
                _graphics.drawRect( _x , _y , width , height ) ;
                _graphics.endFill() ;
                
                if ( _lineStyle != null )
                {
                    _lineStyle.apply( _graphics ) ;
                }
                
                _dashline.start.x = _x ; 
                _dashline.start.y = _y ; 
                _dashline.end.x   = _x + width ; 
                _dashline.end.y   = _y ;
                
                _dashline.draw() ;
                
                _dashline.start.x = _dashline.end.x ; 
                _dashline.start.y = _dashline.end.y ; 
                _dashline.end.x   = _dashline.end.x ; 
                _dashline.end.y   = _dashline.end.y + height ;
                
                _dashline.draw() ;
                
                _dashline.start.x = _dashline.end.x ; 
                _dashline.start.y = _dashline.end.y ; 
                _dashline.end.x   = _x ; 
                _dashline.end.y   = _dashline.end.y ;
                
                _dashline.draw() ;
                
                _dashline.start.x = _dashline.end.x ; 
                _dashline.start.y = _dashline.end.y ; 
                _dashline.end.x   = _x ; 
                _dashline.end.y   = _y ;
                
                _dashline.draw() ;
                
                _dashline.start.x = 0 ; 
                _dashline.start.y = 0 ; 
                _dashline.end.x   = 0 ; 
                _dashline.end.y   = 0 ;
            }
            else
            {
                super.drawShape() ;
            }
        }
        
        /**
         * Sets the shape options to defined all values to draw the shape.
         * @param x (optional) The x position of the pen.
         * @param y (optional) The y position of the pen.
         * @param width (optional) The width of the pen.
         * @param height (optional) The height of the pen.
         * @param align (optional) The align value of the pen.
         * @param length (optional) The length of a dash in the line.
         * @param spacing (optional) The spacing value between two dashs in this line.
         */
        public override function setPen( ...args:Array  ):void 
        {
            super.setPen( args[0], args[1], args[2], args[3], args[4] ) ;
            if ( args[5] != null && args[4] is Number )
            {
                this.length = isNaN( args[4] ) ? 0 : args[4] ;
            }
            if ( args[6] != null && args[5] is Number )
            {
                this.spacing = isNaN( args[5] ) ? 0 : args[5] ;
            }
        }
        
        /**
         * @private
         */
        protected const _dashline:DashLinePen = new DashLinePen() ;
    }
}
