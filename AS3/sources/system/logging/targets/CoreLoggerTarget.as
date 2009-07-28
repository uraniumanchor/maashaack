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
	import system.logging.LoggerTarget;
	import system.logging.LoggerStrings;
	import system.logging.Logger;
	import system.logging.LoggerLevel;
	import system.logging.Log;
    import system.Strings;
    import system.errors.InvalidFilterError;
    import system.events.LoggerEvent;
    
    import flash.events.EventDispatcher;
    
    /**
     * This class provides the basic functionality required by the logging framework for a target implementation. 
     * It handles the validation of filter expressions and provides a default level property. 
     * No implementation of the logEvent() method is provided.
     */
    public class CoreLoggerTarget extends EventDispatcher implements LoggerTarget
    {
        /**
         * Creates a new CoreLoggerTarget instance.
         */
        public function CoreLoggerTarget()
        {
            //
        }
        
        /**
         * Indicates the filters array representation of this target.
         */
        public function get filters():Array
        {
            return _filters ;
        }
        
        /**
         * @private
         */
        public function set filters( value:Array ):void
        {
            if (value != null && value.length > 0)
            {
                var filter:String ;
                var index:int ;
                var len:int = value.length ;
                for ( var i:int ; i<len ; i++ )
                {
                    filter = value[i] ;
                    if ( Log.hasIllegalCharacters(filter) )
                    {
                         throw new InvalidFilterError( Strings.format( LoggerStrings.ERROR_FILTER , filter ) + LoggerStrings.CHARS_INVALID ) ;
                    }
                    index = filter.indexOf("*") ;
                    if ((index >= 0) && (index != (filter.length -1)))
                    {
                        throw new InvalidFilterError( Strings.format( LoggerStrings.ERROR_FILTER , filter) + LoggerStrings.CHAR_PLACEMENT ) ;
                    }
                }
            }
            else
            {
                value = ["*"] ;
            }
            if ( _count > 0 )
            {
                Log.removeTarget( this ) ;
                _filters = value;
                Log.addTarget( this ) ;
            }
            else
            {
                _filters = value;
            }
        }
        
        /**
         * Indicates the level of this target.
         */
        public function get level():LoggerLevel
        {
            return _level ;
        }
        
        /**
         * @private
         */
        public function set level( value:LoggerLevel ):void
        {
            Log.removeTarget( this ) ;
            _level = value ;
            Log.addTarget( this ) ;
        } 
        
        /**
         * Insert a channel in the fllters if this channel don't exist.
         * Returns a boolean if the channel is add in the list.
         */
        public function addFilter( channel:String ):Boolean 
        {
            if ( _filters == null ) 
            {
                filters = [] ;
            }
            if ( _filters.indexOf( channel ) == -1 ) 
            {
                return false ;
            }
            _filters.push( channel ) ;
            return true ;
        }
        
        /**
         * Sets up this target with the specified logger.
         * Note : this method is called by the framework and should not be called by the developer.
         */
        public function addLogger( logger:Logger ):void 
        {
            if ( logger != null )
            {
                _count++ ;
                logger.addEventListener( LoggerEvent.LOG , _handleEvent ) ;
            }
        }
        
        /**
         *  This method handles a <code class="prettyprint">LoggerEvent</code> from an associated logger.
         *  A target uses this method to translate the event into the appropriate format for transmission, storage, or display.
         *  This method will be called only if the event's level is in range of the target's level.
         *  <b><i>Descendants need to override this method to make it useful.</i></b>
         */
        public function logEvent( event:LoggerEvent ):void
        {
            // override please.
        }
        
        /**
         * Remove a channel in the fllters if this channel exist.
         * @return a boolean if the channel is remove.
         */
        public function removeFilter( channel:String ):Boolean
        {
            var pos:int = _filters.indexOf( channel ) ;
            if ( pos > -1) 
            {
                _filters.splice(pos, 1) ;
                return true ;
            }
            else 
            {
                return false ;
            }
        }
        
        /**
         * Stops this target from receiving events from the specified logger.
         */
        public function removeLogger( logger:Logger ):void 
        {
            if ( logger != null )
            {
                _count-- ;
                logger.removeEventListener( LoggerEvent.LOG , _handleEvent ) ;
            }
        }
        
        /**
         * Storage for the filters property.
         */
        private var _filters:Array = ["*"] ;
        
        /**
         * Storage for the filters property.
         */
        private var _level:LoggerLevel = LoggerLevel.ALL ;
        
        /**
         * Count of the number of loggers this target is listening to. 
         * When this value is zero changes to the filters property shouldn't do anything.
         */
        private var _count:uint ;
        
        /**
         * This method will call the <code class="prettyprint">logEvent</code> method if the level of the event is appropriate for the current level.
         */
        private function _handleEvent( event:LoggerEvent ):void
        {
            if ( int( event.level ) >= int( level ) )
            {
                logEvent(event) ;
            }
        }
    }
}