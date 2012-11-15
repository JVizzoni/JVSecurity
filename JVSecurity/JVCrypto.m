//
//  JVCrypto.m
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

#import "JVCrypto.h"
#import <CommonCrypto/CommonCryptor.h>
#import <CommonCrypto/CommonKeyDerivation.h>

@implementation JVCrypto

+ (NSData *)randomDataOfLength:(size_t)length
{
    NSMutableData *data = [NSMutableData dataWithLength:length];
    int result = SecRandomCopyBytes(kSecRandomDefault, length, data.mutableBytes);
    NSAssert(result == 0, @"Unable to generate random bytes: %d", errno);
    
    return data;
}

+ (NSData *)keyWithSize:(NSUInteger)size forPassword:(NSString *)password usingSalt:(NSData *)salt;
{
    NSMutableData *key = [NSMutableData dataWithLength:size];
    
    int result = CCKeyDerivationPBKDF(kCCPBKDF2,
                                      password.UTF8String,
                                      password.length,
                                      salt.bytes,
                                      salt.length,
                                      kCCPRFHmacAlgSHA1,
                                      10000,
                                      key.mutableBytes,
                                      key.length);
    
    NSAssert(result == kCCSuccess, @"Unable to generate a key: %d", result);
    
    return key;
}

@end
