//
//  NSUserDefaults+BreakerDefaults.m
//  Breaker
//
//  Created by Joel Garrett on 10/13/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import "NSUserDefaults+BreakerDefaults.h"

#define kBreakerUserDefaultsKeyPreferredControlType         @"kBreakerUserDefaultsKeyPreferredControlType"

@implementation NSUserDefaults (BreakerDefaults)

+ (NSInteger)preferredControlType
{
    return [[NSUserDefaults standardUserDefaults] integerForKey:kBreakerUserDefaultsKeyPreferredControlType];
}


+ (void)setPreferredControlType:(NSInteger)type
{
    [[NSUserDefaults standardUserDefaults] setInteger:type forKey:kBreakerUserDefaultsKeyPreferredControlType];
}

@end
