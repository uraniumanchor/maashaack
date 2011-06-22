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

package system.process 
{
    import buRRRn.ASTUce.framework.TestCase;
    
    import system.Reflection;
    import system.logging.Loggable;
    import system.logging.Logger;
    import system.process.mocks.MockTaskReceiver;
    
    public class TaskTest extends TestCase
    {
        public function TaskTest(name:String = "")
        {
            super(name);
        }
        
        public var task:Task ;
        public var mockReceiver:MockTaskReceiver ;
        
        public function setUp():void
        {
            task         = new Task() ;
            mockReceiver = new MockTaskReceiver( task ) ;
        }
        
        public function tearDown():void
        {
            mockReceiver.unregister() ;
            mockReceiver = null ;
            task         = null ;
        }
        
        public function testConstructor():void
        {
            assertNotNull( task ) ;
        }
        
        public function testInherit():void
        {
            assertTrue( task is Object ) ;
        }
        
        public function testInterface():void
        {
            assertTrue( task is Action   ) ;
            assertTrue( task is Lockable ) ;
            assertTrue( task is Loggable ) ;
        }
        
        public function testLogger():void
        {
            var logger:Logger = task.logger ;
            assertNotNull( logger , "01 - The logger property of the Task class failed." ) ;
            assertEquals( logger.channel , Reflection.getClassPath( task ) , "02 - The logger property of the Task class failed." ) ;
        }
        
        public function testClone():void
        {
            var clone:Task = task.clone() as Task ;
            assertNotNull( clone , "01 - Task clone() failed." ) ;
            assertFalse( clone == task  , "02 - Task clone() failed." ) ;
        }
        
        public function testRunning():void
        {
            assertFalse( task.running  , "Action running failed, default property value must be false." ) ;
        }
        
        public function testNotifyFinished():void
        {
            task.notifyFinished() ;
            assertTrue( mockReceiver.finishCalled , "Action notifyFinished failed, the finishIt signal must emit." ) ;
        }
        
        public function testNotifyStarted():void
        {
            task.notifyStarted() ;
            assertTrue( mockReceiver.startCalled , "Action notifyStarted failed, the startIt signal must emit." ) ;
        }
        
        public function testRun():void
        {
            assertTrue( "run" in task , "Action run 01 method exist." ) ;
        }
    }
}
