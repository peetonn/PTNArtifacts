//
//  NSTimer+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 1/29/13.
//  Copyright (c) 2013 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^PTNTimerBlock)(NSTimer*);

@interface NSTimer (PTNAdditions)

+(NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo fireBlock:(PTNTimerBlock)block;
+(NSTimer*)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo fireBlock:(PTNTimerBlock)block;

@end
