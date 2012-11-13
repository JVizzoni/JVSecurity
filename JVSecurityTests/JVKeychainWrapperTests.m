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

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
    self.keychainWrapper = [[JVKeychainWrapper alloc] initWithAccountIdentifier:kAccount forService:kService];
    
    // delete any existing keychain data that may exist for this account so the tests have a fresh start
    SecItemDelete((__bridge CFDictionaryRef)self.keychainWrapper.genericPasswordQuery);
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testKeychainWrapper
{
    // bad passwords but just testing this function so it doesn't matter
    NSString *password = @"Password";
    NSString *newPassword = @"NewPassword";
    
    // Attempt to add the password to the keychain
    STAssertTrue([self.keychainWrapper setPasswordData:[password dataUsingEncoding:NSUTF8StringEncoding]], @"Failed to create the password");
    
    // compare the keychain value to the password
    STAssertTrue([self.keychainWrapper compareKeychainValueWithData:[password dataUsingEncoding:NSUTF8StringEncoding]], @"Passwords did not match!");
    STAssertFalse([self.keychainWrapper compareKeychainValueWithData:[newPassword dataUsingEncoding:NSUTF8StringEncoding]], @"Passwords matched when they shouldn't have");
    
    // Attempt to update the password to the new password
    STAssertTrue([self.keychainWrapper setPasswordData:[newPassword dataUsingEncoding:NSUTF8StringEncoding]], @"Failed to update the password");
    
    // compare the passwords again
    STAssertTrue([self.keychainWrapper compareKeychainValueWithData:[newPassword dataUsingEncoding:NSUTF8StringEncoding]], @"Passwords did not match!");
    STAssertFalse([self.keychainWrapper compareKeychainValueWithData:[password dataUsingEncoding:NSUTF8StringEncoding]], @"Passwords matched when they shouldn't have");
}

@end
