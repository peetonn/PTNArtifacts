//
//  PTNSingleton.m
//  PTNAdditions
//
//  Created by Peter Gusev on 10/3/14.
//  Copyright (c) 2014 peetonn inc. All rights reserved.
//

#import "PTNSingleton.h"

@implementation PTNSingleton

+(PTNSingleton*)sharedInstance
{
    static PTNSingleton *singleton = nil;
    dispatch_once_t *onceToken = [[self class] token];
    
    dispatch_once(onceToken, ^{
        singleton = [[self class] createInstance];
    });
    
    return singleton;
}

+(PTNSingleton*)createInstance
{
    return [[PTNSingleton alloc] init];
}

static dispatch_once_t token;
+(dispatch_once_t*)token
{
    return &token;
}

@end
