//
//  NSObject+PTNAdditions.m
//  PTNAdditions
//
//  Created by Peter Gusev on 8/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "NSObject+PTNAdditions.h"

@implementation NSObject (PTNAdditions)

-(void)notifyNowWithNotificationName:(NSString *)notificationName andUserInfo:(NSDictionary*)userInfo
{
    NSNotification *notification = [NSNotification notificationWithName:notificationName object:self userInfo:userInfo];
    
    [[NSNotificationQueue defaultQueue] enqueueNotification:notification postingStyle:NSPostNow];
}

-(void)subscribeForNotificationsAndSelectors:(NSString*)notification1,...
{
    va_list n_list;
    va_start(n_list, notification1);
    
    NSString *notification = [notification1 copy];
    SEL selector;
    
    while (notification &&  (selector = va_arg(n_list, SEL))) {
        [[NSNotificationCenter defaultCenter] addObserver:self selector:selector name:notification object:nil];
        notification = va_arg(n_list, NSString*);
    }
    
    va_end(n_list);
}

-(void)unsubscribeFromNotifications:(NSString*)notification1,...
{
    va_list n_list;
    va_start(n_list, notification1);
    
    NSString *notification = [notification1 copy];
    
    while (notification) {
        [[NSNotificationCenter defaultCenter] removeObserver:self name:notification object:nil];
        notification = va_arg(n_list, NSString*);
    }
    
    va_end(n_list);
}

-(void)unsubscribeFromNotifications
{
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

-(void)watchObject:(id)object forKeypaths:(NSString *)keyPath1, ...
{
    va_list n_list;
    va_start(n_list, keyPath1);
    
    NSString *keyPath = [keyPath1 copy];
    
    while (keyPath) {
        [self addObserver:self forKeyPath:keyPath
                  options:(NSKeyValueObservingOptionNew|NSKeyValueObservingOptionOld)
                  context:nil];
        keyPath = va_arg(n_list, NSString*);
    }
    
    va_end(n_list);
}

-(void)stopWatchingObject:(id)object forKeypaths:(NSString*)keyPath1,...
{
    va_list n_list;
    va_start(n_list, keyPath1);
    
    NSString *keyPath = [keyPath1 copy];
    
    while (keyPath) {
        [self removeObserver:self forKeyPath:keyPath];
        keyPath = va_arg(n_list, NSString*);
    }
    
    va_end(n_list);
}

@end
