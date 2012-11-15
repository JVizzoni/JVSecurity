//
//  JVKeychainWrapper.h
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

#include <Foundation/Foundation.h>

/*
 Design Intentions:
 ------------------
 1) First and foremost, this keychain wrapper is designed to encourage and make it simple for users to follow standard security procedures. Specifically, it should provide a simple interface for storing *SALT & HASHED* passwords. If you would like to learn more about why you should salt and hash your passwords, ask Linked In.
 2) It should interface seemlessly with the other classes in JVSecurity to salt, hash, and store your data.
 3) It should provide a simple wrapper for the Keychain C API.
*/

@interface JVKeychainWrapper : NSObject

/* A password query is used to identify the keychain item you want to manipulate. */
@property (nonatomic, strong) NSMutableDictionary *genericPasswordQuery;

/*
 @function initWithAccountIdentifier:forService:
 @abstract Initiializes a JVKeychainWrapper object for storing and comparing keychain values
 @param identifier is a the account that you want the keychain data for. For example, an account: "UserName"
 @param service is the accessing company or application ID. For example. com.yourApp.developer or the bundle ID
 @return JVKeychainWrapper item
 @discussin Initializer that returns a JVKeychainWrapper item with a configured generic password query. Specify the account identifier and service that the keychain item is stored under. The other methods allow for access/modification of this specific item.
 */
- (id)initWithAccountIdentifier:(NSString *)identifier forService:(NSString *)service;

/*
 @function setPasswordData
 @abstract Allows a user to store data into the keychain. The item is updated if it already exists.
 @param data is the salted & hashed password data
 @return a boolean value that says alerts the user if the write/update was a success
 @discussion Although and NSData object may be used, the data should be key generated using hashing algoritms included in the Common Crytpo library. JVCrypto provides a wrapper for easy use of the CC library.
 */
- (BOOL)setPasswordData:(NSData *)data;

/*
 @function compareKeychainValueWithData
 @abstract Compares the passed in value with the value stored in the keychain.
 @param dataToCompare is the NSData object to compare to the stored key
 @return a boolean value, YES if the two objects match, NO otherwise
 @discussion This method does not return the data in the keychain on purpose. Although keychain operations are expensive, we do not want to allow the user to store the data in memory. Maybe that's a little paranoid but it's certainly safe.
 */
- (BOOL)compareKeychainValueWithData:(NSData *)dataToCompare;

@end
