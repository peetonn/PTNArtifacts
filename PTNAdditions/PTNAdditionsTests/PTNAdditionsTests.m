//
//  PTNAdditionsTests.m
//  PTNAdditionsTests
//
//  Created by Peter Gusev on 8/14/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNAdditionsTests.h"



@implementation PTNAdditionsTests

- (void)setUp
{
    [super setUp];
    
    // Set-up code here.
}

- (void)tearDown
{
    // Tear-down code here.
    
    [super tearDown];
}

- (void)testNotifications
{
    [self subscribeForNotificationsAndSelectors:@"notification1", @selector(notificationHandler:), nil];
    [self notifyNowWithNotificationName:@"notification1" andUserInfo:nil];
    
    [[NSRunLoop currentRunLoop] runMode:NSDefaultRunLoopMode beforeDate:[NSDate dateWithTimeIntervalSinceNow:5]];
    
    STAssertTrue(gotNotification,@"should have handle notification");
}
     
-(void)notificationHandler:(NSNotification*)notif
{
    gotNotification = YES;
}

@end
