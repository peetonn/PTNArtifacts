//
//  NSDate+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 1/31/13.
//  Copyright (c) 2013 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSDate (PTNAdditions)
/**
 * Returns true is current date represent today's day. It's not just simple comparison with [NSDate date].
 */
-(bool)isToday;

@end
