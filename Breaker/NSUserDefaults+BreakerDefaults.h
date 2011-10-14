//
//  NSUserDefaults+BreakerDefaults.h
//  Breaker
//
//  Created by Joel Garrett on 10/13/11.
//  Copyright (c) 2011 Joel Garrett. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSUserDefaults (BreakerDefaults)

+ (NSInteger)preferredControlType;
+ (void)setPreferredControlType:(NSInteger)type;

@end
