//
//  PTNControlsAppTester.m
//  PTNControlsAppTester
//
//  Created by Peter Gusev on 9/12/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNControlsAppTester.h"
#import "AppDelegate.h"

@interface  PTNControlsAppTester()

@property (nonatomic, readonly) AppDelegate *delegate;

@end

@implementation PTNControlsAppTester

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

- (void)testReadMoreLabel
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    view.backgroundColor = [UIColor grayColor];
    
    PTNReadMoreLabel *label = [[PTNReadMoreLabel alloc] initWithFrame:CGRectMake(20, 20, 300, 40)];

    [view addSubview:label];
    label.visibleCharactersNum = 50;
    label.text = @"Lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum lorem ipsum";
    
    [self.delegate.window addSubview:view];
    
    [self waitFor:30];
}

//********************************************************************************
-(void)waitFor:(NSTimeInterval)seconds
{
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
}
-(AppDelegate*)delegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

@end
