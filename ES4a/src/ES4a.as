
/*
  The contents of this file are subject to the Mozilla Public License Version
  1.1 (the "License"); you may not use this file except in compliance with
  the License. You may obtain a copy of the License at 
  http://www.mozilla.org/MPL/ 
  
  Software distributed under the License is distributed on an "AS IS" basis,
  WITHOUT WARRANTY OF ANY KIND, either express or implied. See the License
  for the specific language governing rights and limitations under the License. 
  
  The Original Code is [ES4a: ECMAScript 4 MaasHaack framework].
  
  The Initial Developer of the Original Code is
  Zwetan Kjukov <zwetan@gmail.com>.
  Portions created by the Initial Developer are Copyright (C) 2006-2007
  the Initial Developer. All Rights Reserved.
  
  Contributor(s):
*/

package
    {
    import flash.display.Sprite;
    
    public class ES4a extends Sprite
        {
        
        public function ES4a()
            {
            /*
            import system.*;
            
            Serializer.prettyPrinting = true;
            system.info( true, true );
            
            import buRRRn.eden.info;
            buRRRn.eden.info( true );
            
            import buRRRn.ASTUce.tests.AllTests;
            import tests.ES4a.AllTests;
            import tests.eden.AllTests;
            import buRRRn.ASTUce.Runner;
            
            import buRRRn.ASTUce.config;
            buRRRn.ASTUce.config.showConstructorList = true;
            
            Runner.main( tests.ES4a.AllTests.suite() );
            */
            /*
            Runner.main( buRRRn.ASTUce.tests.AllTests.suite(),
                         tests.ES4a.AllTests.suite(),
                         tests.eden.AllTests.suite() );
            */
            
            //TODO: add some tests for system.drawing
            //playing with bitmap data
            import system.drawing.RGB;
            import system.drawing.ARGB;
            import system.drawing.Color;
            import system.drawing.Colors;
            
            //var c:ARGB = new ARGB(255,0,128,255);
            var c:Color = Colors.beige;
                //c.inverse();
                //c.alphaPercent = 0.25;
            trace( c );
            //trace( c.alpha );
            //trace( c.alphaPercent );
            }
        
        
        }
    
    }

