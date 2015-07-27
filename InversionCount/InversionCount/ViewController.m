//
//  ViewController.m
//  InversionCount
//
//  Created by Yevhen Herasymenko on 04/07/2015.
//  Copyright (c) 2015 Fess2036. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (assign, nonatomic) NSInteger countOfInversion;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _countOfInversion = 0;
    NSString* path = [[NSBundle mainBundle] pathForResource:@"IntegerArray"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    NSArray *array = [content componentsSeparatedByString:@"\r\n"];
    [self sortArray:array];
    NSLog(@"inversion - %ld", (long)self.countOfInversion);
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (NSArray *)sortArray:(NSArray *)array {
    NSInteger half = (array.count - array.count%2)/2;
    NSArray *leftArray = [array subarrayWithRange:NSMakeRange(0, half)];
    NSArray *rightArray = [array subarrayWithRange:NSMakeRange(half, array.count - half)];
    if (leftArray.count > 1) {
        leftArray = [self sortArray:leftArray];
    }
    if (rightArray.count > 1) {
        rightArray = [self sortArray:rightArray];
    }
    return [self sordedArrays:leftArray and:rightArray];
}

- (NSArray *)sordedArrays:(NSArray *)leftArray and:(NSArray *)rightArray {
    NSMutableArray *sortedArray = [[NSMutableArray alloc] init];
    int left, right;
    left = right = 0;
    for (int i = 0; i < leftArray.count + rightArray.count; i++) {
        if (left > leftArray.count-1) {
            [sortedArray addObject:rightArray[right]];
            right++;
        } else if (right > rightArray.count-1) {
            [sortedArray addObject:leftArray[left]];
            left++;
        } else if ([leftArray[left] integerValue] > [rightArray[right] integerValue]) {
            self.countOfInversion = self.countOfInversion + (leftArray.count - left);
            [sortedArray addObject:rightArray[right]];
            right++;
        } else {
            [sortedArray addObject:leftArray[left]];
            left++;
        }
    }
    return sortedArray;
    
}

@end
