//
//  JVCrypto.h
//  JVSecurity
//
//  Created by Jake Vizzoni on 11/14/12.
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

#import <Foundation/Foundation.h>

/*
 Design Intentions:
 ------------------
 * As of now, JVCrypto is intended to integrate with JVKeychainWrapper providing an easy method for hashing a password.
 * JVCrypto is essentially a wrapper class for Common Crypto and provides a simple interface for the user to:
 * 1) Generate random data using a cryptographically secure pseudo-random number generator (CSPRNG)
 * 2) Provide a method (eventually multiple methods) that takes a password and salt to generate a key using a KDF.
 * 3) ...
 */

@interface JVCrypto : NSObject

/*
 @function randomDataOfLength
 @abstract Generates random data of a specified length using a CSPRNG
 @param length The length(in bytes) of the random data you want generated
 @return Random data with the specified length
 @discussion  When using this function for the purpose of generating a salt any length may be used, however, 8 bytes is the PKCS#5 minimum recommended length.
 */
+ (NSData *)randomDataOfLength:(size_t)length;

/* 
 @function keyWithSize
 @abstract Generate a key using PBKDF2 with 10000 passes.
 @param size Size of the key generated (kCCKeySizeAES128, kCCKeySizeAES256, etc...)
 @param password The password being hashed
 @param salt Salt to use in the hashing algorithm
 @return A key with the specified length
 @discussion A SHA1 hashing algorithm to generate a key with a specified size. This is a purposely slow hashing algorithm which helps combat brute force attacks.
 */
+ (NSData *)keyWithSize:(NSUInteger)size forPassword:(NSString *)password usingSalt:(NSData *)salt;

@end
