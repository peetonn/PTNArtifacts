//
//  NSTimer+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 1/29/13.
//  Copyright (c) 2013 peetonn inc. All rights reserved.
//

#import "NSTimer+PTNAdditions.h"

@interface NSTimer()

@end

@implementation NSTimer (PTNAdditions)

+(NSTimer*)scheduledTimerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo fireBlock:(PTNTimerBlock)block
{
    return [NSTimer scheduledTimerWithTimeInterval:ti
                                            target:self
                                          selector:@selector(PTNExecuteBlockWithTimer:)
                                          userInfo:[block copy]
                                           repeats:yesOrNo];
}

+(NSTimer*)timerWithTimeInterval:(NSTimeInterval)ti repeats:(BOOL)yesOrNo fireBlock:(PTNTimerBlock)block
{
    return [NSTimer timerWithTimeInterval:ti
                                   target:self
                                 selector:@selector(PTNExecuteBlockWithTimer:)
                                 userInfo:[block copy]
                                  repeats:yesOrNo];
}

+(void)PTNExecuteBlockWithTimer:(NSTimer *)timer
{
    PTNTimerBlock block = [timer userInfo];
    block(timer);
}

@end
