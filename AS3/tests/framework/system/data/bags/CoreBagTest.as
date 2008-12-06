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
 
package system.data.bags 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.data.Bag;
    import system.data.Collection;
    import system.data.Iterator;
    import system.data.collections.ArrayCollection;
    import system.data.iterators.BagIterator;
    import system.data.maps.ArrayMap;
    import system.data.maps.HashMap;
    
    import flash.errors.IllegalOperationError;    

    public class CoreBagTest extends TestCase 
    {

        public function CoreBagTest(name:String = "")
        {
            super( name );
        }
        
        public var bag:CoreBag ;
        
        public function setUp():void
        {
            bag = new CoreBag( new ArrayMap() ) ;
        }

        public function tearDown():void
        {
            bag = undefined ;
        }        
        
        public function testConstructor():void
        {
            
            assertNotNull( bag , "01 - CoreBag constructor failed." ) ;
            
            var b:Bag ;
            
            try
            {
                b = new CoreBag() ;
                fail( "02-01 - CoreBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "02-02 - CoreBag constructor failed."  ) ;
                assertEquals( e.message , "CoreBag, set the internal Map failed. The Map must be non-null and empty.", "02-03 - CoreBag constructor failed."  ) ;
            }
            
            try
            {
                b = new CoreBag(null) ;
                fail( "03-01 - CoreBag constructor failed."  ) ;
            }
            catch( e:Error )
            {
                assertTrue( e is ArgumentError ,  "03-02 - CoreBag constructor failed."  ) ;
                assertEquals( e.message , "CoreBag, set the internal Map failed. The Map must be non-null and empty.", "03-03 - CoreBag constructor failed."  ) ;
            }            
            
            var co:ArrayCollection = new ArrayCollection([1,2,3,3,4]) ;
            var ma:ArrayMap        = new ArrayMap() ;
            
            b = new CoreBag( ma , co ) ;            
            
            assertEquals( b.size()      , 5 , "04-01 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(1) , 1 , "04-02 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(2) , 1 , "04-03 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(3) , 2 , "04-04 - CoreBag constructor failed."  ) ;
            assertEquals( b.getCount(4) , 1 , "04-04 - CoreBag constructor failed."  ) ;
            
            
        }
        
        public function testInterface():void
        {
            assertTrue( bag is Bag        , "CoreBag must implement the Bag interface." ) ;
            assertTrue( bag is Collection , "CoreBag must implement the Collection interface." ) ;	
        }
        
        public function testModCount():void
        {
            assertEquals( bag.modCount , 0 , "01 - CoreBag modCount property failed" ) ;	
            bag.modCount ++ ;
            assertEquals( bag.modCount , 1 , "02 - CoreBag modCount property failed" ) ;
            bag.modCount = 0 ;
            assertEquals( bag.modCount , 0 , "03 - CoreBag modCount property failed" ) ;
        }
            
        public function testAdd():void 
        {
            var bag:Bag = new CoreBag( new HashMap() ) ;
            bag.add("item1") ;
            assertEquals( bag.getCount("item1") , 1 , "01-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 1 , "01-02 - CoreBag add method failed : " + bag) ;
            bag.add("item1") ;
            assertEquals( bag.getCount("item1") , 2 , "02-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 2 , "02-02 - CoreBag add method failed : " + bag) ;
            bag.add("item2") ;
            assertEquals( bag.getCount("item2") , 1 , "03-01 - addCopies failed : " + bag) ;
            assertEquals(bag.size()             , 3 , "03-02 - CoreBag add method failed : " + bag) ;
        }

        public function testAddAll():void 
        {
            var bag:Bag = new CoreBag( new ArrayMap() ) ;
            var c:Collection = new ArrayCollection( ["item1", "item2", "item3", "item4", "item5"] ) ;
            bag.addAll(c) ;
            assertEquals( bag.size() , 5, "CoreBag addAll failed : " + bag ) ;
        }
        
        public function testAddCopies():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            bag.addCopies("item2", 2) ;
            assertEquals( bag.getCount("item2") , 2, "01-01 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.size()            , 2, "01-02 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.modCount          , 1, "01-03 - CoreBag addCopies failed : " + bag) ;
            
            bag.addCopies("item3", 1) ;
            assertEquals( bag.getCount("item3") , 1, "02-01 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.size()            , 3, "02-02 - CoreBag addCopies failed : " + bag) ;
            assertEquals( bag.modCount          , 2, "02-03 - CoreBag addCopies failed : " + bag) ;
                        
        } 
        
        public function testClear():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item1") ;
            bag.clear() ;
            assertTrue( bag.isEmpty(), "01 - CoreBag clear failed.") ;
        }        
              
        public function testClone():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;      	        
            bag.add("item2") ;
            
            var clone:CoreBag = bag.clone() as CoreBag ;
            
            assertNotNull( clone         , "01 - CoreBag clone failed." ) ;
            assertNotSame( bag   , clone , "02 - CoreBag clone failed." ) ;
            
            assertEquals( clone.size() , bag.size() , "03 - CoreBag clone failed." ) ;
            
            assertEquals( clone.getCount("item1") , bag.getCount("item1") , "04-01 - CoreBag clone failed." ) ;
            assertEquals( clone.getCount("item2") , bag.getCount("item2") , "04-02 - CoreBag clone failed." ) ;
            
        }
        
        public function testContains():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;                  
            bag.add("item2") ;
            
            assertTrue( bag.contains("item1") , "01 - CoreBag contains failed." ) ;
            assertTrue( bag.contains("item2") , "02 - CoreBag contains failed." ) ;
            assertFalse( bag.contains("item3") , "03 - CoreBag contains failed." ) ;
        }        
        
        public function testContainsAll():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            var c1:Collection = new ArrayCollection( ["item1", "item2", "item2", "item3", "item4", "item5"] ) ;
            var c2:Collection = new ArrayCollection( ["item1", "item2"] ) ;
            var c3:Collection = new ArrayCollection( ["item5", "item4"] ) ;
            var c4:Collection = new ArrayCollection( ["item5", "item6"] ) ;
            
            assertTrue ( bag.containsAll( c1   ) , "01 - CoreBag containsAll failed : " + bag ) ;
            assertTrue ( bag.containsAll( c2   ) , "02 - CoreBag containsAll failed : " + bag ) ;
            assertTrue ( bag.containsAll( c3   ) , "03 - CoreBag containsAll failed : " + bag ) ;
            assertFalse( bag.containsAll( c4   ) , "04 - CoreBag containsAll failed : " + bag ) ;
            assertFalse( bag.containsAll( null ) , "05 - CoreBag containsAll failed : " + bag ) ;
            
        }   
        
        public function testContainsAllInBag():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            var b1:HashBag = new HashBag( new ArrayCollection(["item1", "item2", "item2", "item3", "item4", "item5"] ) ) ;
            var b2:HashBag = new HashBag( new ArrayCollection(["item1", "item2"] ) ) ;
            var b3:HashBag = new HashBag( new ArrayCollection(["item5", "item4"] ) ) ;
            var b4:HashBag = new HashBag( new ArrayCollection(["item5", "item6"] ) ) ;
            
            assertTrue ( bag.containsAllInBag( b1   ) , "01 - CoreBag containsAllInBag failed : " + bag ) ;
            assertTrue ( bag.containsAllInBag( b2   ) , "02 - CoreBag containsAllInBag failed : " + bag ) ;
            assertTrue ( bag.containsAllInBag( b3   ) , "03 - CoreBag containsAllInBag failed : " + bag ) ;
            assertFalse( bag.containsAllInBag( b4   ) , "04 - CoreBag containsAllInBag failed : " + bag ) ;
            assertFalse( bag.containsAllInBag( null ) , "05 - CoreBag containsAllInBag failed : " + bag ) ;
            
        }         
             
        public function testGet():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
        	try
        	{
                bag.get("key") ;
                fail( "01 - CoreBag get method failed." ) ;  
        	}
        	catch( e:Error )
        	{
                assertTrue( e is IllegalOperationError ,  "02 - CoreBag get method failed."  ) ;
                assertEquals( e.message , "CoreBag, the get() method is unsupported.", "03 - CoreBag get method failed."  ) ;
            }
        }
        
        public function testGetCount():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;
            
            assertEquals( bag.getCount('item1') , 1 , "01 - CoreBag getCount('item1') failed : " + bag ) ;              
            assertEquals( bag.getCount('item2') , 2 , "02 - CoreBag getCount('item2') failed : " + bag ) ;
            assertEquals( bag.getCount('item3') , 0 , "03 - CoreBag getCount('item3') failed : " + bag ) ;
            
        }
        
        public function testIndexOf():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            try
            {
                bag.indexOf("key", 0) ;
                fail( "01 - CoreBag indexOf method failed." ) ;  
            }
            catch( e:Error )
            {
                assertTrue( e is IllegalOperationError ,  "02 - CoreBag indexOf method failed."  ) ;
                assertEquals( e.message , "CoreBag, the indexOf() method is unsupported.", "03 - CoreBag indexOf method failed."  ) ;
            }
        }        
        
        public function testIsEmpty():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            assertTrue( bag.isEmpty() , "01 - CoreBag isEmpty method failed." ) ;
            bag.add("item1") ;
            assertFalse( bag.isEmpty() , "02 - CoreBag isEmpty method failed." ) ;
        }        
        
        public function testIterator():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;
            
            var it:Iterator = bag.iterator() ;
            
            assertNotNull( it , "01 - CoreBag iterator method failed."  )  ;
            assertTrue( it is BagIterator , "02 - CoreBag iterator method failed."  )  ;
            assertTrue( it.hasNext() , "03 - CoreBag iterator method failed."  )  ;
            assertEquals( it.next() , "item1", "04 - CoreBag iterator method failed."  )  ;
            
        }           
        
        public function testRemove():void 
        {
            var bag:CoreBag = new CoreBag( new ArrayMap() ) ;
            
            var modCount:uint = bag.modCount ;
            
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;
            
            assertTrue( bag.remove("item1") , "01-01 - CoreBag remove method failed." ) ;
            assertEquals( bag.getCount("item1") , 0, "01-02 - CoreBag remove method failed." ) ;
            
            assertTrue( bag.remove("item2") , "02-01 - CoreBag remove method failed." ) ;
            assertEquals( bag.getCount("item2") , 0, "02-02 - CoreBag remove method failed." ) ;
            
            assertFalse( bag.remove("item3") , "03-01 - CoreBag remove method failed." ) ;
            assertEquals( bag.getCount("item3") , 0, "03-02 - CoreBag remove method failed." ) ;
            
            assertTrue( bag.modCount > modCount , "04 - CoreBag remove method failed." ) ; 
            
        }
        
        public function testRemoveAll():void 
        {
            var bag:CoreBag  ;
            var col:Collection ;
            
            // 01
            
            bag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            col = new ArrayCollection(["item1", "item2", "item2", "item3", "item4", "item5"] ) ;
            
            assertTrue ( bag.removeAll( col  ) , "01-01 - CoreBag removeAll failed : " + bag ) ;
            assertEquals( bag.size() , 0 , "01-02 - CoreBag removeAll failed : " + bag ) ;

            // 02

            bag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
             
            col = new ArrayCollection(["item1", "item2"] ) ;
            
            assertTrue ( bag.removeAll( col  ) , "02-01 - CoreBag removeAll failed : " + bag ) ;
            assertEquals( bag.size() , 4 , "02-02 - CoreBag removeAll failed : " + bag ) ;
            assertEquals( bag.getCount("item2") , 1 , "02-03 - CoreBag removeAll failed : " + bag ) ;

            // 03

            bag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
            
            col = new ArrayCollection(["item5", "item4", "item2"] ) ;
            
            assertTrue ( bag.removeAll( col  ) , "03-01 - CoreBag removeAll failed : " + bag ) ;
            assertEquals( bag.size() , 3 , "03-02 - CoreBag removeAll failed : " + bag ) ;            
            
            // 03

            bag = new CoreBag( new ArrayMap() ) ;
            bag.add("item1") ;
            bag.add("item2") ;
            bag.add("item2") ;                  
            bag.add("item3") ;
            bag.add("item4") ;
            bag.add("item5") ;
                         
            
            col = new ArrayCollection(["item6"] ) ;
            
            assertFalse( bag.removeAll( col  ) , "04 - CoreBag removeAll failed : " + bag ) ;
                        
        }         
        
    }
}
