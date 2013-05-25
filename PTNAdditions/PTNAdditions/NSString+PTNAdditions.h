//
//  NSString+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 9/11/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSString (PTNAdditions)

/**
 * Returns new string without occurences like "http://", trail "/" etc.
 */
-(NSString*)strippedURLString;

@end
