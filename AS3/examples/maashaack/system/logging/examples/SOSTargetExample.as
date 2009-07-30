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
Portions created by the Initial Developers are Copyright (C) 2006-2009
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
    import system.logging.Log;
    import system.logging.Logger;
    import system.logging.LoggerLevel;
    import system.logging.targets.SOSTarget;
    
    import flash.display.Sprite;
    import flash.events.KeyboardEvent;
    import flash.ui.Keyboard;
    
    /**
     * Test the SOSTarget class with the SOS Max Console.
     * <p>Thanks <b>PowerFlasher</b> and the free <a href='http://sos.powerflasher.de/'>SOS Max Console</a></p>
     */
    public class SOSTargetExample extends Sprite 
    {
        public function SOSTargetExample()
        {
            target = new SOSTarget( "SOS console test", 0xFFFFE6 ) ;
            
            target.includeDate    = true ;
            target.includeTime    = true ;
            target.includeLevel   = true ;
            target.includeChannel = true ;
            target.includeLines   = true ;
            
            target.filters        = [ "examples.*" ] ;
            target.level          = LoggerLevel.ALL ;
            
            target.sendFoldLevelMessage("Test a fold message", "Here the description of the fold message with a specific level" , LoggerLevel.INFO ) ;
            
            logger = Log.getLogger( "examples.SOSTarget" ) ;
            
            logger.log   ( "Here is some myDebug info : {0} and {1}", 2.25 , true ) ;
            logger.debug ( "Here is some debug message." ) ;
            logger.info  ( "Here is some info message." ) ;
            logger.warn  ( "Here is some warn message." ) ;
            logger.error ( "Here is some error message." ) ;
            logger.fatal ( "Here is some fatal error..." ) ;
            
            target.includeDate    = false ;
            target.includeTime    = false ;
            target.includeChannel = false ;
            
            logger.info( "test : [{0}, {1}, {2}]", 2, 4, 6 ) ;
            
            ////////
            
            stage.addEventListener( KeyboardEvent.KEY_DOWN , keyDown ) ;
        }
        
        public var logger:Logger ;
        
        public var target:SOSTarget ;
        
        public function keyDown( e:KeyboardEvent ):void
        {
            var code:int = e.keyCode ;
            switch( code )
            {
                case Keyboard.SPACE :
                {
                    target.clear() ;
                    break ;
                }
                default :
                {
                    logger.log( "log message" ) ;
                }
            }
        }
    }
}
