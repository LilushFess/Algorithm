//
//  NSMutableArray+Sort.m
//  SCCMacOS
//
//  Created by Yevhen Herasymenko on 29/07/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import "NSMutableArray+Sort.h"

@implementation NSMutableArray (Sort)

- (NSComparisonResult)compareFirst:(NSMutableArray *)otherObject {
    return [self[0] compare:otherObject[0]];
}

@end
