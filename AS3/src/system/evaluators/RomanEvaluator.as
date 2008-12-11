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

package system.evaluators 
{
    import system.evaluators.Evaluable;
    import system.numeric.Range;        

    /**
     * Evaluates an int value and transform it in roman numeral expression.
     * <p><b>Example :</b></p>
     * <pre class="prettyprint">
     * import system.evaluators.RomanEvaluator ;
     * 
     * var evaluator:RomanEvaluator = new RomanEvaluator() ;
     * 
     * trace( evaluator.eval( 1 ) ) ; // I
     * trace( evaluator.eval( 2 ) ) ; // II
     * trace( evaluator.eval( 3 ) ) ; // III
     * trace( evaluator.eval( 4 ) ) ; // IV
     * trace( evaluator.eval( 5 ) ) ; // V
     * trace( evaluator.eval( 9 ) ) ; // IX
     * trace( evaluator.eval( 10 ) ) ; // X 
     * trace( evaluator.eval( 50 ) ) ; // L 
     * trace( evaluator.eval( 2459 ) ) ; // MMCDLIX
     * 
     * try
     * {
     *     evaluator.eval( 4000 ) ;
     * }
     * catch( e:Error )
     * {
     *     trace( e.message ) ; // RomanEvaluator.eval(4000) failed, the value is out of the range [Range<1,3999>]
     * }
     * </pre>
     */
    public class RomanEvaluator implements Evaluable 
    {

        /**
         * Creates a new RomanEvaluator instance.
         */
        public function RomanEvaluator()
        {
        	//
        }
        
        /**
         * Evaluates the specified object.
         */
        public function eval( o:* ):*
        {
            var s:String = "" ;
            var value:int = int(o) ;
            if ( LIMIT.isOutOfRange(value) )
            {
                throw RangeError( "RomanEvaluator.eval(" + o + ") failed, the value is out of the range " + LIMIT ) ;
            }
            var t:int = value ;
            var l:int = VALUES.length ;
            for ( var i:int ; i < l ; i++ ) 
            {
                while ( t >= VALUES[i] ) 
                {
                    s += ROMANS[i] ;
                    t -= VALUES[i] ;
                }
            }
            return s ;       
        }
        
        /**
         * @private
         */
        private static var LIMIT:Range = new Range(1, 3999) ;
        
        /**
         * @private
         */
        private static var ROMANS:Array = [ "M", "CM", "D", "CD", "C", "XC", "L", "XL", "X", "IX", "V", "IV", "I" ] ;
        
        /**
         * @private
         */
        private static var VALUES:Array = [ 1000,  900, 500, 400, 100, 90, 50, 40, 10, 9, 5, 4,  1] ;        
        
    }

}
