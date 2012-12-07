//
//  NSObject+PTNAdditions.h
//  PTNAdditions
//
//  Created by Peter Gusev on 8/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <Foundation/Foundation.h>

/**
 * Category contains extension of NSObject class
 */
@interface NSObject (PTNAdditions)

/**
 * @name Instance methods
 */
/**
 * Generates notification into default notification queue with specified name with NSPostNow method
 * @param notificationName Name of notification
 * @param userInfo User's info dictionary
 */
-(void)notifyNowWithNotificationName:(NSString*)notificationName andUserInfo:(NSDictionary*)userInfo;

/**
 * Subscribe current instance for notifications. Notifications list should be eneded with nil 
 * @param notification1 Name of first notification
 */
-(void)subscribeForNotificationsAndSelectors:(NSString*)notification1,...;

/**
 * Unsubscribe from notifications
 */
-(void)unsubscribeFromNotifications:(NSString*)notification1,...;

/**
 * Unsubscribe from notifications
 */
-(void)unsubscribeFromNotifications;

@end
