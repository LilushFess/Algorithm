//
//  Test.m
//  SCCMacOS
//
//  Created by Yevhen Herasymenko on 29/07/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import "Test.h"
#import "NSMutableArray+Sort.h"

@interface Test()

@property (assign, nonatomic) NSInteger tValue;
@property (assign, nonatomic) NSInteger countPoint;
@property (strong, nonatomic) NSMutableArray *pointArray;

@end

@implementation Test

- (void)run {
    _tValue = 0;
    
    NSString* path = [[NSBundle mainBundle] pathForResource:@"SCC"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[content componentsSeparatedByString:@" \n"]];
    for (int i = 0; i < [array count]; i++) {
        array[i] = [[NSMutableArray alloc] initWithArray:[array[i] componentsSeparatedByString:@" "]];
        if ([array[i] count] == 3) {
            [array[i] removeLastObject];
        }
    }
    /*NSString* path = [[NSBundle mainBundle] pathForResource:@"test"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[content componentsSeparatedByString:@" \n"]];
    for (int i = 0; i < [array count]; i++) {
        array[i] = [[NSMutableArray alloc] initWithArray:[array[i] componentsSeparatedByString:@" "]];
        if ([array[i] count] == 3) {
            [array[i] removeLastObject];
        }
    } */
    
    self.pointArray = [[NSMutableArray alloc] init];
    for (NSArray *arrow in array) {
        if ([self.pointArray count] < [arrow[0] integerValue]) {
            NSMutableDictionary *pointDict = [[NSMutableDictionary alloc] init];
            pointDict[@"points"] = [[NSMutableArray alloc] initWithObjects:arrow[1], nil];
            pointDict[@"discover"] = @NO;
            pointDict[@"maxDeep"] = @-1;
            [self.pointArray addObject:pointDict];
        } else {
            [self.pointArray[[arrow[0] integerValue] -1][@"points"] addObject:arrow[1]];
        }
    }
    for (NSMutableArray *arrayPoint in array) {
        arrayPoint[0] = [NSNumber numberWithInteger:[arrayPoint[0] integerValue]];
        arrayPoint[1] = [NSNumber numberWithInteger:[arrayPoint[1] integerValue]];
    }
    
    
    [self mainDFS];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (NSArray *arrayPoint in array) {
        NSMutableArray *newArrayPoint = [[NSMutableArray alloc] initWithObjects:arrayPoint[1], arrayPoint[0], nil];
        newArrayPoint[0] = [NSString stringWithFormat:@"%@", self.pointArray[[newArrayPoint[0] integerValue] - 1][@"maxDeep"]];
        newArrayPoint[1] = [NSString stringWithFormat:@"%@", self.pointArray[[newArrayPoint[1] integerValue] - 1][@"maxDeep"]];
        [newArray addObject:newArrayPoint];
    }
    
    newArray = [[NSMutableArray alloc] initWithArray:[newArray sortedArrayUsingSelector:@selector(compareFirst:)]];
    
    
    self.pointArray = [[NSMutableArray alloc] init];
    for (NSArray *arrow in newArray) {
        if ([self.pointArray count] < [arrow[0] integerValue]) {
            NSMutableDictionary *pointDict = [[NSMutableDictionary alloc] init];
            pointDict[@"points"] = [[NSMutableArray alloc] initWithObjects:arrow[1], nil];
            pointDict[@"discover"] = @NO;
            pointDict[@"maxDeep"] = @-1;
            [self.pointArray addObject:pointDict];
        } else {
            [self.pointArray[[arrow[0] integerValue] -1][@"points"] addObject:arrow[1]];
        }
    }
    newArray = nil;
    
    [self mainSCC];
}

- (void)mainSCC {
    NSMutableArray *counts = [[NSMutableArray alloc] init];
    for (NSInteger i = [self.pointArray count]; i > 0; i--) {
        NSDictionary *nextPointDict = self.pointArray[i - 1];
        if ([nextPointDict[@"discover"]  isEqual: @NO]) {
            self.countPoint = 0;
            [self DFSIndex:i];
            [counts addObject:@(self.countPoint)];
        }
    }
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [counts sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    for (int i=0; i<5; i++) {
        NSLog(@"%@", counts[[counts count] - i - 1]);
    }
    
}

- (void)mainDFS {
    for (NSInteger i = [self.pointArray count]; i > 0; i--) {
        NSDictionary *nextPointDict = self.pointArray[i - 1];
        if ([nextPointDict[@"discover"]  isEqual: @NO]) {
            [self DFSIndex:i];
        }
        nextPointDict = nil;
    }
}


- (void)DFSIndex:(NSInteger) index {
    self.pointArray[index - 1][@"discover"] = @YES;
    self.countPoint++;
    for (NSNumber *nextIndex in self.pointArray[index - 1][@"points"]) {
        if ([self.pointArray[[nextIndex integerValue] -1][@"discover"]  isEqual: @NO]) {
            [self DFSIndex:[nextIndex integerValue]];
        }
    }
    self.tValue++;
    self.pointArray[index - 1][@"maxDeep"] = @(self.tValue);
}

@end
