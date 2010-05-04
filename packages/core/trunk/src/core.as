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
  Portions created by the Initial Developers are Copyright (C) 2006-2010
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

package
{
    import core.strings.pad; void(pad);
    import core.strings.format; void(format);
    import core.strings.compare; void(compare);
    import core.strings.startsWith; void(startsWith);
    import core.strings.endsWith; void(endsWith);
    
    import core.reflect.getClassByName; void(getClassByName);
    import core.reflect.getClassName; void(getClassName);
    import core.reflect.getClassPath; void(getClassPath);
    import core.reflect.getClassPackage; void(getClassPackage);
    import core.reflect.getDefinitionByName; void(getDefinitionByName);
    import core.reflect.getClassMethods; void(getClassMethods);
    
    import flash.display.Sprite;
    import flash.utils.describeType;
    
    
    [SWF(width="400", height="400", backgroundColor="0xffffff", frameRate="24", pageTitle="core", scriptRecursionLimit="1000", scriptTimeLimit="60")]
    public class core extends Sprite
    {
        public function core()
        {
            trace( "core" );
            
            //basic usage
            
            trace( "---- core.bit ----" );
            
            trace( "---- core.uri ----" );
            
            trace( "---- core.version ----" );
            
            trace( "---- core.strings ----" );
            
            //pad
            var word:String = "hello";
            trace( "[" + pad( word, 8 ) + "]" );
            trace( "[" + pad( word, -8 ) + "]" );
            
            var seinfeld:Array = [ "jerry", "george", "kramer", "helen" ];
            for( var i:uint=0; i<seinfeld.length; i++ )
            {
                trace( pad( seinfeld[i], 10, "." ) );
            }
            
            //format
            var str0:String = "hello {0}, {1} {2}";
            var str1:String = "if it was {0} then it would not be {1}";
            var str2:String = "hello {name}, do you want to play a game of {game} ?";
            var str3:String = "hello {-0}, {1} {2}"; //throw error because of malformed {-0}
            var str4:String = "hello {0,-8}|\nhello {1,-8}|";
            var str5:String = "hello {0,8}|\nhello {1,8}|";
            var str6:String = "hello {x,-8}|\nhello {y,-8}|";
            var str7:String = "{0} {1} {2} {3} {4} {5}";
            
            trace( format( str0, "world", "I'm", "here" ) );
            trace( format( str1, true, false ) );
            trace( format( str2, {name:"john", game:"chess"} ) );
            //trace( format( str3, "world", "I'm", "here" ) );
            trace( format( str4, "alice", "bob" ) );
            trace( format( str5, "alice", "bob" ) );
            trace( format( str6, {x:"alice", y:"bob"} ) );
            trace( format( str7, ["zero", "one", "two"], "three", "four", "five" ) );
            
            var names:Array  = ["A","B","C","D"];
            var scores:Array = [16,32,128,1024];
            
            for( var j:uint=0; j<names.length; j++ )
            {
                trace( format( "{0} scored {1,5}", names[j], scores[j] ) );
            }
            
            //compare
            var s0:String = "HELLO";
            var s1:String = "hello";
            var s2:String = "welcome";
            var s3:String = "world";
            
            trace( compare( s1, s2 ) ); //-1
            trace( compare( s2, s1 ) ); //1
            trace( compare( s1, s3 ) ); //1
            trace( compare( s1, s1 ) ); //0
            trace( compare( s1, s0 ) ); //0
            trace( compare( s1, s0, true ) ); //-1
            trace( compare( s0, s1, true ) ); //1
            
            //startsWith
            trace( startsWith( "hello world", "h" ) ); //true
            trace( startsWith( "hello world", "hello" ) ); //true
            trace( startsWith( "hello world", "a" ) ); //false
            
            //endsWith
            trace( endsWith( "hello world", "world" ) ); //true
            trace( endsWith( "hello world", "hello" ) ); //false
            
            
            trace( "---- core.reflect ----" );
            
            var one_str:String = "flash.display.Sprite";
            var one_cls:Class  = getClassByName( one_str );
            var one_obj:* = new one_cls();
            
            //getClassByName
            trace( one_obj is Sprite );
            
            //getClassName
            trace( getClassName( one_obj ) == "Sprite"  );
            trace( getClassName( one_obj, true ) == "flash.display::Sprite"  );
            
            //getClassPath
            trace( getClassPath( one_obj ) == "flash.display::Sprite" );
            trace( getClassPath( one_obj, true ) == "flash.display.Sprite" );
            trace( getClassPath( {} ) == "Object" );
            trace( getClassPath( {}, true ) == "Object" );
            
            //getClassPackage
            trace( getClassPackage( one_obj ) == "flash.display" );
            trace( getClassPackage( {} ) == "" );
            
            //getDefinitionByName
            
            //getClassMethods
            trace( getClassMethods( one_obj ) );
            trace( getClassMethods( one_obj, true ) );
            trace( describeType( one_obj ) );
        }
    }
}
