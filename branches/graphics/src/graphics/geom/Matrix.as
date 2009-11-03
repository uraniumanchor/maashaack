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

package graphics.geom 
{
    import system.Reflection;
    import system.eden;
    
    /**
     * Defines a <code class="prettyprint">Matrix</code> with n rows and n columns.
     */
    public class Matrix implements Geometry
    {
        /**
         * Creates a new <code class="prettyprint">Matrix</code> instance.
         * @param r the number of rows in the matrix.
         * @param c the number of columns in the matrix.
         * @param ar the optional Matrix instance to fill the current Matrix.
         */
        public function Matrix( r:uint, c:uint , ar:Array=null )
        {
            super();
            this.m = new Array(r);
            for (var i:int ; i<r ; i++)
            {
                m[i] = new Array(c) ;
            }
            this.r = r ;
            this.c = c ;
        }
        
        /**
         * Defined the number of columns in the Matrix.
         */
        public var c:Number ;
            
        /**
         * The matrix array
         */
        public var m:Array ;
        
        /**
         * Defined the number of rows in the Matrix.
         */
        public var r:Number ;
        
        /**
         * Returns a shallow copy of this instance.
         * @return a shallow copy of this instance.
         */
        public function clone():*
        {
            var matrix:Matrix = new Matrix(r, c) ;
            // fill the matrix !!
            return matrix ;
        }
        
        /**
         * Compares the specified object with this object for equality.
         * @return <code class="prettyprint">true</code> if the the specified object is equal with this object.
         */
        public function equals( o:* ):Boolean 
        {
            if ( o is Matrix )
            {
                // test if all elements are equals in the 2 matrix
                return (o.r == r) && (o.c == c) ;
            }
            else
            {
                return false ;
            }     
        }
        
        /**
         * Returns the source code string representation of the object.
         * @return the source code string representation of the object.
         */
        public function toSource( indent:int = 0 ):String  
        {
            return "new " + Reflection.getClassPath(this) + "(" + eden.serialize(r) + "," + eden.serialize(c) + "," + eden.serialize(m) + ")" ;
        }
        
        /**
         * Returns the string representation of the object.
         * @return the string representation of the object.
         */     
        public function toString():String
        {
            return "[" + Reflection.getClassName(this) + ":{" + r + "," + c + "}]" ;
        }
        
    }
}
