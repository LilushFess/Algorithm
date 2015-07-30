//
//  main.m
//  SCCMacOS
//
//  Created by Yevhen Herasymenko on 29/07/2015.
//  Copyright (c) 2015 YevhenHerasymenko. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Test.h"

int main(int argc, const char * argv[]) {
    @autoreleasepool {
        // insert code here...
        NSLog(@"Hello, World!");
        [[[Test alloc] init] run];
    }
    return 0;
}


