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

-(BOOL)isValidEmail
{
    BOOL stricterFilter = YES;
    NSString *stricterFilterString = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSString *laxString = @".+@.+\\.[A-Za-z]{2}[A-Za-z]*";
    NSString *emailRegex = stricterFilter ? stricterFilterString : laxString;
    NSPredicate *emailTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", emailRegex];
    
    return [emailTest evaluateWithObject:self];
}

@end
