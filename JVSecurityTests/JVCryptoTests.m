//
//  JVCryptoTests.m
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

#import "JVCryptoTests.h"
#import "JVCrypto.h"
#import <CommonCrypto/CommonCrypto.h>

@implementation JVCryptoTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testRandomDataOfLength
{
    STAssertNotNil([JVCrypto randomDataOfLength:8], @"Could not generate random data, returned nil.");
}

- (void)testKeyWithSize
{
    // test generating a AES128 key
    NSUInteger size = kCCKeySizeAES128;
    NSString *password = @"Passw0rd!";
    NSData *salt = [JVCrypto randomDataOfLength:8];
    
    NSData *key = [JVCrypto keyWithSize:size forPassword:password usingSalt:salt];
    STAssertNotNil(key, @"Unable to generate key");
}

@end
