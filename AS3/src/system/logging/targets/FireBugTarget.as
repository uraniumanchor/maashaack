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

package system.logging.targets 
{
    import system.logging.LoggerLevel;
    import system.logging.targets.LineFormattedTarget;
    
    import flash.external.ExternalInterface;
    import flash.net.URLRequest;
    import flash.net.navigateToURL;
    
    /**
     * Provides a logger target that uses the FireBug console extension in Firefox to output log messages. 
     * You can download the FireBug and test this target : <a href="https://addons.mozilla.org/fr/firefox/addon/1843">https://addons.mozilla.org/fr/firefox/addon/1843</a>.
     * You must launch this example in FireFox with the FireBug console enabled. 
     */
    public class FireBugTarget extends LineFormattedTarget 
    {
        /**
         * Creates a new FireBugTarget instance.
         */
        public function FireBugTarget()
        {
            super();
        }
        
        /**
         * Descendants of this class should override this method to direct the specified message to the desired output.
         * @param message String containing preprocessed log message which may include time, date, channel, etc. 
         * based on property settings, such as <code class="prettyprint">includeDate</code>, <code class="prettyprint">includeChannel</code>, etc.
         */
        public override function internalLog( message:* , level:LoggerLevel ):void
        {
            var methodName:String ;
            switch (level)
            {
                case LoggerLevel.ALL :
                {
                    methodName = "console.log" ;
                    break ; 
                }
                case LoggerLevel.ERROR :
                {
                    methodName = "console.error" ;
                    break ; 
                }
                case LoggerLevel.FATAL :
                {
                    methodName = "console.error" ;
                    break ; 
                }
                case LoggerLevel.INFO :
                {
                    methodName = "console.info" ;
                    break ; 
                }
                case LoggerLevel.WARN :
                {
                    methodName = "console.warn" ;
                    break ; 
                }
                case LoggerLevel.DEBUG :
                default :
                {
                    methodName = "console.debug" ;
                    break ; 
                }
            }
            if ( ExternalInterface.available )
            {
                ExternalInterface.call( methodName, [message] ) ;
            }
            else
            {
                navigateToURL( new URLRequest("javascript:" + methodName + "('"+ message +"');") );  
            }
        }
    }
}
