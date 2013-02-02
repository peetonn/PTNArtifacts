//
//  NSDate+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 1/31/13.
//  Copyright (c) 2013 peetonn inc. All rights reserved.
//

#import "NSDate+PTNAdditions.h"

@implementation NSDate (PTNAdditions)
-(bool)isToday
{
    NSCalendar *cal = [NSCalendar currentCalendar];
    NSDate *today = [NSDate date];
    
    NSDateComponents *todayComp = [cal components:(kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay) fromDate:today];
    NSDateComponents *selfComp = [cal components:(kCFCalendarUnitYear|kCFCalendarUnitMonth|kCFCalendarUnitDay) fromDate:self];
    
    bool res = [todayComp year]==[selfComp year] &&
    [todayComp month] == [selfComp month] &&
    [todayComp day] == [selfComp day];
    return res;
}
@end
