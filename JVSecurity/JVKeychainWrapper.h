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
//
//  Methods found in JVKeychainWrapper are derived in part, from Ray
//  Wenderlich's tutorials on security and using Apple's Keychain API found at:
//  <http://www.raywenderlich.com/6475/basic-security-in-ios-5-tutorial-part-1>
//  <http://www.raywenderlich.com/6603/basic-security-in-ios-5-tutorial-part-2>

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

/* Return a configured JVKeychainWrapper item with a configured generic password query setup
 @param identifier is a the account that you want the keychain data for. For example, an account: "UserName"
 @param service is the accessing company or application ID. For example. com.yourApp.developer or the bundle ID
 @return a JVKeychainWrapper used to write/read from the keychain for a specific identifier/service
 */
- (id)initWithAccountIdentifier:(NSString *)identifier forService:(NSString *)service;

/* Stores a (presumably) salted and hashed password data to the keychain, if the value already exists it's updated.
 @param data is the salted & hashed password data
 @return a boolean value that says alerts the user if the write/update was a success
 */
- (BOOL)setPasswordData:(NSData *)data;

/* Searches the keychain for a key and compares it to the passed in value.
 @param dataToCompare is the NSData object to compare to the stored key
 @return a boolean value, YES if the two objects match, NO otherwise
 */
- (BOOL)compareKeychainValueWithData:(NSData *)dataToCompare;

@end
