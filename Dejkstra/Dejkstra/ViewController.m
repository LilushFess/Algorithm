//
//  ViewController.m
//  Dejkstra
//
//  Created by Yevhen Herasymenko on 07/08/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@property (strong, nonatomic) NSMutableDictionary *result;
@property (strong, nonatomic) NSMutableArray *checkedEdges;
@property (strong, nonatomic) NSMutableArray *array;
@property (strong, nonatomic) NSMutableArray *queue;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    NSString* path = [[NSBundle mainBundle] pathForResource:@"dijkstraData"
                                                     ofType:@"txt"];
    NSString* content = [NSString stringWithContentsOfFile:path
                                                  encoding:NSUTF8StringEncoding
                                                     error:NULL];
    self.array = [[NSMutableArray alloc] initWithArray:[content componentsSeparatedByString:@"\t\r"]];
    for (int i = 0; i< [self.array count]; i++) {
        NSString *arrayString = self.array[i];
        NSArray *subArray = [arrayString componentsSeparatedByString:@"\t"];
        NSMutableDictionary *dict = [[NSMutableDictionary alloc] init];
        for (int j = 1; j < [subArray count]; j++) {
            NSString *keyString = subArray[j];
            NSArray *childArray = [keyString componentsSeparatedByString:@","];
            dict[childArray[0]] = childArray[1];
        }
        self.array[i] = dict;
    }
    self.queue = [[NSMutableArray alloc] init];
    self.result = [[NSMutableDictionary alloc] init];
    self.checkedEdges = [[NSMutableArray alloc] init];
    [self.queue addObject:@1];
    self.result[@"1"] = @0;
    [self foundForItem:@1];
    
    
}


- (void)foundForItem:(NSNumber *)item {
    [self.checkedEdges addObject:item];
    NSNumber *selfSize = (NSNumber *)self.result[item];
    NSDictionary *dict = self.array[[item integerValue] - 1];
    [dict enumerateKeysAndObjectsUsingBlock:^(id key, id obj, BOOL *stop) {
        BOOL isChecked = NO;
        for (NSNumber *edge in self.checkedEdges) {
            if ([edge integerValue] == [key integerValue]) {
                isChecked = YES;
                break;
            }
        }
        if (!isChecked) {
            [self.queue insertObject:key atIndex:0];
        }
        if (!self.result[key]) {
            self.result[key] = [NSNumber numberWithInteger:[selfSize integerValue] + [obj integerValue]];
        } else if ([self.result[key] integerValue] > [selfSize integerValue] + [obj integerValue]) {
            self.result[key] = [NSNumber numberWithInteger:[selfSize integerValue] + [obj integerValue]];
            [self.queue insertObject:key atIndex:0];
        }
        
    }];
    [self.queue removeLastObject];
    if ([self.queue count]) {
        [self foundForItem:self.queue.lastObject];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end