//
//  JVKeychainWrapperTests.m
//  JVSecurity
//
//  Created by Jake Vizzoni on 11/8/12.
//  Copyright (c) 2012 JV Assets, LLC. All rights reserved.
//
//  This file is part of JVSecurity.
//
//  JVSecurity is free software: you can redistribute it and/or modify
//  it under the terms of the GNU General Public License as published by
//  the Free Software Foundation, either version 3 of the License, or
//  (at your option) any later version.
//
//  JVSecurity is distributed in the hope that it will be useful,
//  but WITHOUT ANY WARRANTY; without even the implied warranty of
//  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//  GNU General Public License for more details.
//
//  You should have received a copy of the GNU General Public License
//  along with JVSecurity.  If not, see <http://www.gnu.org/licenses/>.

#import "JVKeychainWrapperTests.h"
#import "JVKeychainWrapper.h"

@interface JVKeychainWrapperTests ()
@property (nonatomic, strong) JVKeychainWrapper *keychainWrapper;
@end

@implementation JVKeychainWrapperTests

@synthesize keychainWrapper = _keychainWrapper;

#define kAccount @"UserName"
#define kService @"APP_ID"
#define kPassword @"Password"

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.keychainWrapper = [[JVKeychainWrapper alloc] initWithAccountIdentifier:kAccount forService:kService];
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

/*
 Keychain needs an application target to run on for the tests to run properly. The only way I've been able to run these tests is when this library is included as a submodule in another existing project that is using the library.
 
 IF ANYONE KNOWS A WAY AROUND THIS I'M ALL FOR SUGGESTIONS!
 
 For now, I've disabled these tests in the scheme.
 */

- (void)testAddItemToKeychain
{
    // a bad password but just testing this function so it doesn't matter
    NSString *password = kPassword;
    NSData *passwordData = [password dataUsingEncoding:NSUTF8StringEncoding];
    
    BOOL success = [self.keychainWrapper setPasswordData:passwordData];
    STAssertTrue(success, @"Failed to create the password");
}

/*
- (void)testSearchDictionaryForAccountWithIdentifier
{
    NSDictionary *searchDictionary = [JVKeychainWrapper searchDictionaryForService:kAccount withIdentifer:kId];
    
    STAssertNotNil(searchDictionary, @"A NULL dictionary was returned");
    STAssertEquals([searchDictionary objectForKey:(__bridge id)kSecAttrService], kAccount, @"The account was not properly set inside the search dictionary");
    STAssertEquals([searchDictionary objectForKey:(__bridge id)kSecAttrAccount], kId, @"The identifier was not properly set inside the search dictionary");
}

- (void)testCreateKeychainValue
{
    NSDictionary *searchDictionary = [JVKeychainWrapper searchDictionaryForService:kAccount withIdentifer:kId];
    
    STAssertTrue([JVKeychainWrapper createKeychainValue:PASSWORD usingDictionary:searchDictionary], @"Failed to store a password");
    
    // try adding the password again - it should just update the value and return true
    STAssertTrue([JVKeychainWrapper createKeychainValue:PASSWORD usingDictionary:searchDictionary], @"Failed to update the stored password");
}

//- (void)testCompareKeychainValueWithAttributesWithData
//{
//    // test that compareKeychainValueWithAttributes:withData: returns true when asked to compare a password with what's stored
//    NSDictionary *searchDictionary = [JVKeychainWrapper searchDictionaryForService:kAccount withIdentifer:kId];
//    NSData *passwordData = [PASSWORD dataUsingEncoding:NSUTF8StringEncoding];
//    STAssertTrue([JVKeychainWrapper compareKeychainValueWithAttributes:searchDictionary withData:passwordData], @"Password's did not match");
//    
//    NSString *incorrectPassword = @"WrongPassword";
//    NSData *incorrectPasswordData = [incorrectPassword dataUsingEncoding:NSUTF8StringEncoding];
//    STAssertFalse([JVKeychainWrapper compareKeychainValueWithAttributes:searchDictionary withData:incorrectPasswordData], @"Password's should not match");
//    
//}

- (void)testDeleteKeychainValue
{
    NSDictionary *searchDictionary = [JVKeychainWrapper searchDictionaryForService:kAccount withIdentifer:kId];
    
    // Assuming other tests have already added the entry into the keychain by the time this test runs
    STAssertTrue([JVKeychainWrapper deleteItemFromKeychainWithAttributes:searchDictionary], @"Failed to delete entry in keychain");
}
*/
@end
