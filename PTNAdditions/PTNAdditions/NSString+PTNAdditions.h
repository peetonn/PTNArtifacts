//
//  NSString+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 9/11/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Contains extensions for NSString class
 */
@interface NSString (PTNAdditions)

/**
 * Returns new string without occurences like "http://", trail "/" etc.
 */
-(NSString*)strippedURLString;

/**
 * Checks, whether string is a valid e-mail
 */
-(BOOL)isValidEmail;

@end
