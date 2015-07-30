//
//  ViewController.m
//  GrafMinCut
//
//  Created by Yevhen Herasymenko on 26/07/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"kargerMinCut"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];

    
//    NSMutableArray *testArray = [[NSMutableArray alloc] initWithArray:@[
//                                  [[NSMutableArray alloc] initWithArray:@[[[NSMutableArray alloc] initWithArray:@[@"1"]], @"2", @"4"]],
//                                  [[NSMutableArray alloc] initWithArray:@[[[NSMutableArray alloc] initWithArray:@[@"2"]], @"1", @"3", @"4"]],
//                                  [[NSMutableArray alloc] initWithArray:@[[[NSMutableArray alloc] initWithArray:@[@"3"]], @"2", @"4"]],
//                                  [[NSMutableArray alloc] initWithArray:@[[[NSMutableArray alloc] initWithArray:@[@"4"]], @"1", @"2", @"3"]]
//                                  ]];
//    [self findMinCutGraf:testArray];
//    
    NSInteger minCuount = INT32_MAX;
    NSInteger testCuount = INT32_MAX;

    while (1 > 0) {
        NSMutableArray *array = [[NSMutableArray alloc] initWithArray:[content componentsSeparatedByString:@"\r\n"]];
        [array removeLastObject];
        for (int i = 0; i < [array count]; i++) {
            array[i] = [[NSMutableArray alloc] initWithArray:[array[i] componentsSeparatedByString:@"\t"]];
            array[i][0] = [[NSMutableArray alloc] initWithObjects:array[i][0], nil];
            [array[i] removeLastObject];
        }
        testCuount = [self findMinCutGraf:array];
        if (testCuount < minCuount) {
            minCuount = testCuount;
            NSLog(@"count - %ld", (long)minCuount);
        }
    }
    
    
}

- (NSInteger)findMinCutGraf:(NSMutableArray *)grafArray {
    NSInteger minCut = 0;
    while ([grafArray count] > 2) {
        NSUInteger r = arc4random_uniform([grafArray count] - 1);
        NSMutableArray *lineR = grafArray[r];
        NSString *tString = lineR[arc4random_uniform([grafArray[r] count] - 2) + 1];
        
        NSInteger t = 0;
        NSMutableArray *lineT;
        for (NSMutableArray *array in grafArray) {
            if ([array[0][0] isEqualToString:tString]) {
                lineT = array;
                t = [grafArray indexOfObject:array];
            }
        }
        
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:r];
        [indexSet addIndex:t];
        [grafArray removeObjectsAtIndexes:indexSet];
        NSMutableIndexSet *indexSetRR = [NSMutableIndexSet indexSet];
        for (int i = 1; i< [lineR count]; i++) {
            if ([lineR[i] isEqualToString:lineT[0][0]]) {
                [indexSetRR addIndex:i];
                //break;
            }
        }
        [lineR removeObjectsAtIndexes:indexSetRR];
        NSMutableIndexSet *indexSetRT = [NSMutableIndexSet indexSet];
        for (int i = 1; i< [lineT count]; i++) {
            if ([lineT[i] isEqualToString:lineR[0][0]]) {
                [indexSetRT addIndex:i];
                //break;
            }
        }
        [lineT removeObjectsAtIndexes:indexSetRT];
        
        NSArray *subArrayT = [lineT subarrayWithRange:NSMakeRange(1, [lineT count]-1)];
        
        [lineR addObjectsFromArray:subArrayT];
        for (NSMutableArray *array in grafArray ) {
            for (int i = 1; i < [array count]; i++) {
                if ([array[i] isEqualToString:lineT[0][0]]) {
                    array[i] = lineR[0][0];
                }
            }
        }
        NSMutableIndexSet *indexSetR = [NSMutableIndexSet indexSet];
        for (int i = 1; i< [lineR count]; i++) {
            if ([lineR[i] isEqualToString:lineR[0][0]]) {
                [indexSetR addIndex:i];
            } else if ([lineR[i] isEqualToString:lineT[0][0]]) {
                [indexSetR addIndex:i];
            }
        }
        [lineR removeObjectsAtIndexes:indexSetR];
        [grafArray addObject:lineR];
        /*
        
        NSInteger t = 0;
        NSMutableArray *lineT;
        for (NSMutableArray *array in grafArray) {
            for (NSString *stringInt in array[0]) {
                if ([stringInt integerValue] ==  [tString integerValue]) {
                    lineT = array;
                    t = [grafArray indexOfObject:array];
                }
            }
        }
        NSMutableIndexSet *indexSet = [NSMutableIndexSet indexSet];
        [indexSet addIndex:r];
        [indexSet addIndex:t];
        [grafArray removeObjectsAtIndexes:indexSet];
        [lineR[0] addObjectsFromArray:lineT[0]];
        NSArray *subArrayT = [lineT subarrayWithRange:NSMakeRange(1, [lineT count]-1)];
        [lineR addObjectsFromArray:subArrayT];
        for (NSString *vers in lineR[0]) {
            NSInteger indexR = -1;
            for (NSString *strI in [lineR subarrayWithRange:NSMakeRange(1, [lineR count]-1)]) {
                if ([strI integerValue] == [vers integerValue]) {
                    indexR = [lineR indexOfObject:strI];
                    break;
                }
            }
            if (indexR > 0) {
                [lineR removeObjectAtIndex:indexR];
            }
        }
        [grafArray addObject:lineR];*/
    }
    minCut = [grafArray[0] count] - 1;
    if (minCut == 21) {
        
    }
    return minCut;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
