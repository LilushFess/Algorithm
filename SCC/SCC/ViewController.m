//
//  ViewController.m
//  SCC
//
//  Created by Yevhen Herasymenko on 29/07/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import "ViewController.h"

#import "NSMutableArray+Sort.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger tValue;
@property (assign, nonatomic) NSInteger countPoint;


@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
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
    }*/
    
    NSMutableArray *pointArray = [[NSMutableArray alloc] init];
    for (NSArray *arrow in array) {
        if ([pointArray count] < [arrow[0] integerValue]) {
            NSMutableDictionary *pointDict = [[NSMutableDictionary alloc] init];
            pointDict[@"points"] = [[NSMutableArray alloc] initWithObjects:arrow[1], nil];
            pointDict[@"discover"] = @NO;
            pointDict[@"maxDeep"] = @-1;
            [pointArray addObject:pointDict];
        } else {
            [pointArray[[arrow[0] integerValue] -1][@"points"] addObject:arrow[1]];
        }
    }
    for (NSMutableArray *arrayPoint in array) {
        arrayPoint[0] = [NSNumber numberWithInteger:[arrayPoint[0] integerValue]];
        arrayPoint[1] = [NSNumber numberWithInteger:[arrayPoint[1] integerValue]];
    }
    
    
    [self mainDFS:pointArray];
    
    NSMutableArray *newArray = [[NSMutableArray alloc] init];
    for (NSArray *arrayPoint in array) {
        NSMutableArray *newArrayPoint = [[NSMutableArray alloc] initWithObjects:arrayPoint[1], arrayPoint[0], nil];
        newArrayPoint[0] = [NSString stringWithFormat:@"%@", pointArray[[newArrayPoint[0] integerValue] - 1][@"maxDeep"]];
        newArrayPoint[1] = [NSString stringWithFormat:@"%@", pointArray[[newArrayPoint[1] integerValue] - 1][@"maxDeep"]];
        [newArray addObject:newArrayPoint];
    }
    
    newArray = [[NSMutableArray alloc] initWithArray:[newArray sortedArrayUsingSelector:@selector(compareFirst:)]];
    
    
    pointArray = [[NSMutableArray alloc] init];
    for (NSArray *arrow in newArray) {
        if ([pointArray count] < [arrow[0] integerValue]) {
            NSMutableDictionary *pointDict = [[NSMutableDictionary alloc] init];
            pointDict[@"points"] = [[NSMutableArray alloc] initWithObjects:arrow[1], nil];
            pointDict[@"discover"] = @NO;
            pointDict[@"maxDeep"] = @-1;
            [pointArray addObject:pointDict];
        } else {
            [pointArray[[arrow[0] integerValue] -1][@"points"] addObject:arrow[1]];
        }
    }
    newArray = nil;
    
    [self mainSCC:pointArray];
    
}



- (void)mainSCC:(NSMutableArray *)array {
    NSMutableArray *counts = [[NSMutableArray alloc] init];
    for (NSInteger i = [array count]; i > 0; i--) {
        NSMutableDictionary *nextPointDict = array[i - 1];
        if ([nextPointDict[@"discover"]  isEqual: @NO]) {
            self.countPoint = 0;
            [self DFS:array index:i];
            [counts addObject:@(self.countPoint)];
        }
    }
    
    NSSortDescriptor *highestToLowest = [NSSortDescriptor sortDescriptorWithKey:@"self" ascending:NO];
    [counts sortUsingDescriptors:[NSArray arrayWithObject:highestToLowest]];
    for (int i=0; i<5; i++) {
        NSLog(@"%@", counts[[counts count] - i - 1]);
    }
    
}

- (void)mainDFS:(NSMutableArray *)array {
    for (NSInteger i = [array count]; i > 0; i--) {
        NSMutableDictionary *nextPointDict = array[i - 1];
        if ([nextPointDict[@"discover"]  isEqual: @NO]) {
            [self DFS:array index:i];
        }
        nextPointDict = nil;
    }
}


- (void)DFS:(NSMutableArray *)array index:(NSInteger) index {
    NSMutableDictionary *pointDict = array[index - 1];
    pointDict[@"discover"] = @YES;
    self.countPoint++;
    for (NSNumber *nextIndex in pointDict[@"points"]) {
        NSMutableDictionary *nextPointDict = array[[nextIndex integerValue] -1];
        if ([nextPointDict[@"discover"]  isEqual: @NO]) {
            [self DFS:array index:[nextIndex integerValue]];
        }
    }
    self.tValue++;
    pointDict[@"maxDeep"] = @(self.tValue);
    pointDict = nil;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
