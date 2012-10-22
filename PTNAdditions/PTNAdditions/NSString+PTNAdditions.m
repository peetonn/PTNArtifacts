//
//  NSString+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 9/11/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "NSString+PTNAdditions.h"

@implementation NSString (PTNAdditions)

-(NSString*)strippedURLString
{
    NSString *stripped = [self stringByReplacingOccurrencesOfString:@"http://" withString:@""];
    return [stripped stringByTrimmingCharactersInSet:[NSCharacterSet characterSetWithCharactersInString:@"/"]];
}

@end
