//
// Copyright 2010-2017 Amazon.com, Inc. or its affiliates. All Rights Reserved.
//
// Licensed under the Apache License, Version 2.0 (the "License").
// You may not use this file except in compliance with the License.
// A copy of the License is located at
//
// http://aws.amazon.com/apache2.0
//
// or in the "license" file accompanying this file. This file is distributed
// on an "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either
// express or implied. See the License for the specific language governing
// permissions and limitations under the License.
//

#import <Foundation/Foundation.h>

//! Project version number for AWSCognitoIdentityProvider.
FOUNDATION_EXPORT double AWSCognitoIdentityProviderVersionNumber;

//! Project version string for AWSCognitoIdentityProvider.
FOUNDATION_EXPORT const unsigned char AWSCognitoIdentityProviderVersionString[];



#import "AWSCognitoIdentityProviderService.h"
#import "AWSCognitoIdentityUserPool.h"
#import "AWSCognitoIdentityUser.h"

#import "aws_tommath_class.h"
#import "aws_tommath_superclass.h"
#import "aws_tommath.h"
#import "AWSCognitoIdentityProviderHKDF.h"
#import "AWSCognitoIdentityProviderSrpHelper.h"
#import "AWSCognitoIdentityUser_Internal.h"
#import "AWSCognitoIdentityUserPool_Internal.h"
#import "AWSJKBigDecimal.h"
#import "AWSJKBigInteger.h"
#import "NSData+AWSCognitoIdentityProvider.h"
