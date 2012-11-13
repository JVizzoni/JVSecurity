//
//  JVKeychainWrapper.m
//  JVSecurity
//
//  Created by Jake Vizzoni on 11/4/12.
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

#import "JVKeychainWrapper.h"
#import <Security/Security.h>

@interface JVKeychainWrapper ()

// A utility method that calls SecItemCopyMatching() using the genericPasswordQuery
// @returns the generic password, nil if not found
- (NSData *)searchSecItemCopyMatching;

@end

@implementation JVKeychainWrapper

/*
 This class is ARC compliant - any references to CF classes must be paired with a "__bridge" statement to cast between Objective-C and Core Foundation Classes.  WWDC 2011 Video "Introduction to Automatic Reference Counting" explains this.
 */

@synthesize genericPasswordQuery = _genericPasswordQuery;

#pragma mark - Private Methods
- (NSData *)searchSecItemCopyMatching
{
    NSMutableDictionary *searchDictionary = [self.genericPasswordQuery mutableCopy];
    // Limit search results to one.
    [searchDictionary setObject:(__bridge id)kSecMatchLimitOne forKey:(__bridge id)kSecMatchLimit];
    // Specify we want NSData/CFData returned.
    [searchDictionary setObject:(__bridge id)kCFBooleanTrue forKey:(__bridge id)kSecReturnData];
    
    NSData *valueData = nil;
    CFTypeRef foundDictionary = NULL;
    OSStatus result = SecItemCopyMatching((__bridge CFDictionaryRef)searchDictionary, &foundDictionary);
    
    if (result == noErr) {
        valueData = (__bridge_transfer NSData *)foundDictionary;
    } else {
        // the only acceptable error in this situation is errSecItemNotFound
        // if we fail for any other reason we have more serious problems
        NSAssert(result == errSecItemNotFound, @"A serious error occured while searching the keychain: error code = %ld", result);
    }
    
    return valueData;
}


#pragma mark - Public Methods
- (id)initWithAccountIdentifier:(NSString *)identifier forService:(NSString *)service
{
    if (self = [super init]) {
        self.genericPasswordQuery = [[NSMutableDictionary alloc] init];

        // Specify that we are looking for/using a generic password
        [self.genericPasswordQuery setObject:(__bridge id)(kSecClassGenericPassword) forKey:(__bridge id)(kSecClass)];
        
        // Sepcify the service (the requesting app/company) & the account (the identifier)
        [self.genericPasswordQuery setObject:service forKey:(__bridge id)kSecAttrService];
        [self.genericPasswordQuery setObject:identifier forKey:(__bridge id)kSecAttrAccount];
    }
    
    return self;
}

- (BOOL)setPasswordData:(NSData *)data
{
    NSMutableDictionary *keychainItem = [self.genericPasswordQuery mutableCopy];
    [keychainItem setObject:data forKey:(__bridge id)kSecValueData];
    
    OSStatus status;
    BOOL success = NO;
    
    if ([self searchSecItemCopyMatching]) {
        // item found so update it
        NSMutableDictionary *searchDictionary = [self.genericPasswordQuery mutableCopy];
        
        // must remove the item class because it cannot be updated once set
        [keychainItem removeObjectForKey:(__bridge id)(kSecClass)];
        
        // Attempt to update value
        status = SecItemUpdate((__bridge CFDictionaryRef)(searchDictionary),
                               (__bridge CFDictionaryRef)(keychainItem));
    } else {
        // The item does not exist, so add it

        // Protect the keychain entry so it's only valid when the device is unlocked.
        [keychainItem setObject:(__bridge id)kSecAttrAccessibleWhenUnlocked forKey:(__bridge id)kSecAttrAccessible];
        
        // Add to the keychain
        status = SecItemAdd((__bridge CFDictionaryRef)keychainItem, NULL);
    }
    
    if (status == errSecSuccess) {
        success = YES;
    }
    
    return success;
}

- (BOOL)compareKeychainValueWithData:(NSData *)dataToCompare
{
    BOOL match = NO;
    
    if ([[self searchSecItemCopyMatching] isEqualToData:dataToCompare]) {
        match = YES;
    }
    
    return match;
}

@end
