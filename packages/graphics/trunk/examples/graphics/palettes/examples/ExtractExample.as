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
  Portions created by the Initial Developers are Copyright (C) 2006-2012
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

package examples 
{
    import graphics.display.palettes.extract;
    
    import flash.display.Bitmap;
    import flash.display.Shape;
    import flash.display.Sprite;
    import flash.display.StageAlign;
    import flash.display.StageScaleMode;
    
    public class ExtractExample extends Sprite 
    {
        public function ExtractExample()
        {
            ////////
            
            stage.align     = StageAlign.TOP_LEFT ;
            stage.scaleMode = StageScaleMode.NO_SCALE ;
            
            ////////
            
            canvas = new Bitmap() ;
            
            canvas.x = 20 ;
            canvas.y = 20 ;
            
            ////////
            
            container = new Sprite() ;
            
            ////////
            
            canvas.bitmapData = new Joconde().bitmapData ;
            
            addChild( canvas ) ;
            addChild( container ) ;
            
            ////////
            
            createPalette() ;
        }
        
        public var canvas:Bitmap ;
        
        public var container:Sprite ;
        
        protected function createPalette():void
        {
            ////////
            
            container.x = canvas.x + canvas.width + 10 ;
            container.y = canvas.y ;
            
            ////////
            
            var len:int = container.numChildren ;
            while(--len > -1)
            {
                container.removeChildAt( len ) ; 
            }
            
            ////////
            
            var color:uint ;
            
            var palette:Vector.<uint> = extract( canvas.bitmapData , 100 , 0.005 ) ;
            
            var row:int;
            var col:int;
            var box:Shape;
            
            len = palette.length ;
            
            for each( color in palette ) 
            {
                trace( '0x' + color.toString(16) );
                
                box = new Shape();
                
                box.x = col * 25;
                box.y = row * 25;
                
                box.graphics.beginFill( color );
                box.graphics.drawRect( 0, 0, 24, 24 );
                box.graphics.endFill();
                
                container.addChild( box );
                
                if ( row++ == 16 )
                {
                    row = 0;
                    col++;
                }
            }
        }
    }
}
