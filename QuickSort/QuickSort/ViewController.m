//
//  ViewController.m
//  QuickSort
//
//  Created by Yevhen Herasymenko on 23/07/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger countOfCompare;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _countOfCompare = 0;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"QuickSort"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *array = [content componentsSeparatedByString:@"\r\n"];
//    NSArray *firstArray = [self sortFirstPivotArray:array];
//    NSLog(@"first - %ld", (long)self.countOfCompare);
//    _countOfCompare = 0;
//    NSArray *lastArray = [self sortLastPivotArray:array];
//    NSLog(@"last - %ld", (long)self.countOfCompare);
//    _countOfCompare = 0;
//    NSArray *middleArray = [self sortMiddlePivotArray:array];
//    NSLog(@"midle - %ld", (long)self.countOfCompare);
//    
//    
//    NSArray *testA = @[@3, @8, @2, @5, @1, @4, @7, @6];
//    [self sortFirstPivotArray:testA];
    NSMutableArray *mArray = [[NSMutableArray alloc] initWithArray:array];
    [self sortArray:mArray from:0 to:[mArray count]];
   // [self sortMiddlePivotArray:mArray from:0 to:[mArray count]];
    
    
}


//- (void)sortArray:(NSMutableArray *)array from:(NSInteger)begin to:(NSInteger)end {
//    
//    NSString *pivot = array[begin];
//    NSInteger j = begin + 1;
//    for (NSInteger i = begin + 1; i < end; i++) {
//        self.countOfCompare++;
//        if ([pivot integerValue] > [array[i] integerValue]) {
//            NSString *delta = array[i];
//            array[i] = array[j];
//            array[j] = delta;
//            j++;
//        }
//    }
//    j--;
//    NSString *delta = array[j];
//    array[j] = array[begin];
//    array[begin] = delta;
//    if (j - begin > 1) {
//        [self sortArray:array from:begin to:j];
//    }
//    if (end - j > 1) {
//        [self sortArray:array from:j+1 to:end];
//    }
//    
//}

//- (void)sortArray:(NSMutableArray *)array from:(NSInteger)begin to:(NSInteger)end {
//    
//    NSString *deltaZ = array[end-1];
//    array[end-1] = array[begin];
//    array[begin] = deltaZ;
//    
//    NSString *pivot = array[begin];
//    NSInteger j = begin + 1;
//    for (NSInteger i = begin + 1; i < end; i++) {
//        self.countOfCompare++;
//        if ([pivot integerValue] > [array[i] integerValue]) {
//            NSString *delta = array[i];
//            array[i] = array[j];
//            array[j] = delta;
//            j++;
//        }
//    }
//    j--;
//    NSString *delta = array[j];
//    array[j] = array[begin];
//    array[begin] = delta;
//    if (j - begin > 1) {
//        [self sortArray:array from:begin to:j];
//    }
//    if (end - j > 1) {
//        [self sortArray:array from:j+1 to:end];
//    }
//    
//}


- (void)sortArray:(NSMutableArray *)array from:(NSInteger)begin to:(NSInteger)end {
    
    NSInteger pivotIndex = (end - begin)%2 == 0 ? (end-begin)/2 - 1 : (end - 1 - begin)/2;
    pivotIndex = begin + pivotIndex;
    NSString *deltaZ = array[pivotIndex];
    array[pivotIndex] = array[begin];
    array[begin] = deltaZ;
    
    NSString *pivot = array[begin];
    NSInteger j = begin + 1;
    for (NSInteger i = begin + 1; i < end; i++) {
        self.countOfCompare++;
        if ([pivot integerValue] > [array[i] integerValue]) {
            NSString *delta = array[i];
            array[i] = array[j];
            array[j] = delta;
            j++;
        }
    }
    j--;
    NSString *delta = array[j];
    array[j] = array[begin];
    array[begin] = delta;
    if (j - begin > 1) {
        [self sortArray:array from:begin to:j];
    }
    if (end - j > 1) {
        [self sortArray:array from:j+1 to:end];
    }
    
}



- (NSMutableArray *)sortFirstPivotArray:(NSArray *)array {
    self.countOfCompare += [array count] - 1;
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *biggerArrray = [[NSMutableArray alloc] init];
    NSString *pivot = [array firstObject];
    for (int i = 1; i < [array count]; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray insertObject:array[i] atIndex:0];
        }
    }
    if ([lessArray count] > 1) {
        lessArray = [self sortFirstPivotArray:lessArray];
    }
    if ([biggerArrray count] > 1) {
        biggerArrray = [self sortFirstPivotArray:biggerArrray];
    }
    if ([lessArray count]) {
        [sortedArray addObjectsFromArray:lessArray];
    }
    [sortedArray addObject:pivot];
    if ([biggerArrray count]) {
        [sortedArray addObjectsFromArray:biggerArrray];
    }
    return sortedArray;
}

- (NSMutableArray *)sortLastPivotArray:(NSArray *)array {
    self.countOfCompare += [array count] - 1;
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *biggerArrray = [[NSMutableArray alloc] init];
    NSString *pivot = [array lastObject];
    for (int i = 0; i < [array count] - 1; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray insertObject:array[i] atIndex:0];
        }
    }
    if ([lessArray count] > 1) {
        lessArray = [self sortLastPivotArray:lessArray];
    }
    if ([biggerArrray count] > 1) {
        biggerArrray = [self sortLastPivotArray:biggerArrray];
    }
    if ([lessArray count]) {
        [sortedArray addObjectsFromArray:lessArray];
    }
    [sortedArray addObject:pivot];
    if ([biggerArrray count]) {
        [sortedArray addObjectsFromArray:biggerArrray];
    }
    return sortedArray;
}

- (NSMutableArray *)sortMiddlePivotArray:(NSArray *)array {
    self.countOfCompare += [array count] - 1;
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *biggerArrray = [[NSMutableArray alloc] init];
    NSInteger lenght = [array count];
    NSInteger index = lenght%2 == 0 ? lenght/2 - 1 : (lenght - 1)/2;
    NSString *pivot = [array objectAtIndex:index];
    for (int i = 0; i < index; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray insertObject:array[i] atIndex:0];
        }
    }
    for (int i = (int)index + 1; i < [array count]; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray insertObject:array[i] atIndex:0];
        }
    }
    if ([lessArray count] > 1) {
        lessArray = [self sortFirstPivotArray:lessArray];
    }
    if ([biggerArrray count] > 1) {
        biggerArrray = [self sortFirstPivotArray:biggerArrray];
    }
    if ([lessArray count]) {
        [sortedArray addObjectsFromArray:lessArray];
    }
    [sortedArray addObject:pivot];
    if ([biggerArrray count]) {
        [sortedArray addObjectsFromArray:biggerArrray];
    }
    return sortedArray;
}

/*

- (NSMutableArray *)sortMiddlePivotArray:(NSArray *)array {
    self.countOfCompare += [array count] - 1;
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *biggerArrray = [[NSMutableArray alloc] init];
    NSInteger lenght = [array count];
    NSInteger index = lenght%2 == 0 ? lenght/2 - 1 : (lenght - 1)/2;
    NSString *pivot = [array objectAtIndex:index];
    for (int i = 0; i < index; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray addObject:array[i]];
        }
    }
    for (int i = (int)index + 1; i < [array count]; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray addObject:array[i]];
        }
    }
    if ([lessArray count] > 1) {
        lessArray = [self sortFirstPivotArray:lessArray];
    }
    if ([biggerArrray count] > 1) {
        biggerArrray = [self sortFirstPivotArray:biggerArrray];
    }
    if ([lessArray count]) {
        [sortedArray addObjectsFromArray:lessArray];
    }
    [sortedArray addObject:pivot];
    if ([biggerArrray count]) {
        [sortedArray addObjectsFromArray:biggerArrray];
    }
    return sortedArray;
}

- (NSMutableArray *)sortLastPivotArray:(NSArray *)array {
    self.countOfCompare += [array count] - 1;
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *biggerArrray = [[NSMutableArray alloc] init];
    NSString *pivot = [array lastObject];
    for (int i = 0; i < [array count] - 1; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray addObject:array[i]];
        }
    }
    if ([lessArray count] > 1) {
        lessArray = [self sortLastPivotArray:lessArray];
    }
    if ([biggerArrray count] > 1) {
        biggerArrray = [self sortLastPivotArray:biggerArrray];
    }
    if ([lessArray count]) {
        [sortedArray addObjectsFromArray:lessArray];
    }
    [sortedArray addObject:pivot];
    if ([biggerArrray count]) {
        [sortedArray addObjectsFromArray:biggerArrray];
    }
    return sortedArray;
}

- (NSMutableArray *)sortFirstPivotArray:(NSArray *)array {
    self.countOfCompare += [array count] - 1;
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    NSMutableArray *lessArray = [[NSMutableArray alloc] init];
    NSMutableArray *biggerArrray = [[NSMutableArray alloc] init];
    NSString *pivot = [array firstObject];
    for (int i = 1; i < [array count]; i++) {
        if ([array[i] integerValue] < [pivot integerValue]) {
            [lessArray addObject:array[i]];
        } else {
            [biggerArrray addObject:array[i]];
        }
    }
    if ([lessArray count] > 1) {
        lessArray = [self sortFirstPivotArray:lessArray];
    }
    if ([biggerArrray count] > 1) {
        biggerArrray = [self sortFirstPivotArray:biggerArrray];
    }
    if ([lessArray count]) {
        [sortedArray addObjectsFromArray:lessArray];
    }
    [sortedArray addObject:pivot];
    if ([biggerArrray count]) {
        [sortedArray addObjectsFromArray:biggerArrray];
    }
    return sortedArray;
}

- (void)sortArray:(NSMutableArray *)array from:(NSInteger)begin to:(NSInteger)end {
    
    NSInteger index = begin;
    NSString *pivot = array[index];
    self.countOfCompare += end - 1 - begin;
    for (int i = (int)index + 1; i < end; i++) {
       // self.countOfCompare++;
        if ([pivot integerValue] > [array[i] integerValue]) {
            NSString *arrayI = array[i];
            NSString *arrayIndex = array[index + 1];
            array[index] = arrayI;
            array[index + 1] = pivot;
            if (i != index + 1) {
                array[i] = arrayIndex;
            }
            
            index++;
        }
    }
    if (index - begin > 1) {
        [self sortArray:array from:begin to:index];
    }
    if (end - index > 1) {
        [self sortArray:array from:index+1 to:end];
    }
    
}

- (void)sortLArray:(NSMutableArray *)array from:(NSInteger)begin to:(NSInteger)end {
    
    NSInteger index = begin;
    NSString *pivot = array[end-1];
    for (int i = (int)index; i < end-1; i++) {
        self.countOfCompare++;
        if ([pivot integerValue] > [array[i] integerValue]) {
            if (i != index) {
                    NSString *arrayI = array[i];
                    NSString *arrayIndex = array[index];
                    array[i] = arrayIndex;
                    array[index] = arrayI;
                
            }
            index++;
        }
    }
    if (index != end-1) {
        NSString *arrayI = array[end - 1];
        NSString *arrayIndex = array[index];
        array[end - 1] = arrayIndex;
        array[index] = arrayI;
       // index++;
    }
    
    if (index - begin > 1) {
        [self sortLArray:array from:begin to:index];
    }
    if (end - index > 1) {
        [self sortLArray:array from:index+1 to:end];
    }
    
}


- (void)sortMiddlePivotArray:(NSMutableArray *)array from:(NSInteger)begin to:(NSInteger)end {
    NSInteger pivotIndex = (end - begin)%2 == 0 ? (end - 1 - begin)/2 : (end-begin)/2 - 1;
    NSString *pivot = array[pivotIndex];
    NSInteger i = begin;
    NSInteger j = end-1;
    self.countOfCompare += end - 1 - begin;
    while (i < j) {
        while ([array[i] integerValue] < [pivot integerValue]) {
            i++;
            if (i > pivotIndex) {
                pivotIndex = i;
            }
        }
        while ([array[j] integerValue] > [pivot integerValue]) {
            j--;
            if (j < pivotIndex) {
                pivotIndex = j;
            }
        }
        NSString *beta = array[i];
        array[i] = array[j];
        array[j] = beta;
    }
    
    if (pivotIndex - begin > 1) {
        [self sortLArray:array from:begin to:pivotIndex];
    }
    if (end - pivotIndex > 1) {
        [self sortLArray:array from:pivotIndex+1 to:end];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


*/

@end
