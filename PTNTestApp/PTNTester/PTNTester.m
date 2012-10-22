//
//  PTNTester.m
//  PTNTester
//
//  Created by Peter Gusev on 9/12/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNTester.h"
#import "AppDelegate.h"


@interface PTNTester ()

@property (nonatomic, readonly) AppDelegate *delegate;

@end

@implementation PTNTester

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

//-(void)testAlertView
//{
//    PTNAlertView *alert = [[PTNAlertView alloc] initWithTitle:@"Alert view" message:@"Enter code Enter code Enter code Enter code Enter code Enter code Enter code Enter code Enter code Enter code Enter code Enter code" delegate:self cancelButtonTitle:@"Ok" otherButtonTitles:nil];
//    
//    alert.ptnAlertViewStyle = PTNAlertViewStyleSecureInput;
//    
//    [alert show];
//    [self waitFor:30];
//}
//
//-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
//{
//    NSLog(@"%@",((PTNAlertView*)alertView).enteredText);
//}

- (void)testReadMoreLabel
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 320, 460)];
    view.backgroundColor = [UIColor lightGrayColor];
    view.userInteractionEnabled = YES;
    
    UIView *measure = [[UIView alloc] initWithFrame:CGRectMake(0, 20, 10, 35)];
    measure.backgroundColor = [UIColor redColor];
    [view addSubview:measure];
    
    stub = [[UIView alloc] initWithFrame: CGRectMake(20, 60, 280, 40)];
    stub.backgroundColor = [UIColor whiteColor];
    [view addSubview:stub];
    
    PTNExpandableLabel *label = [[PTNExpandableLabel alloc] initWithFrame:CGRectMake(20, 20, 280, 35)];
    
    label.delegate = self;
    [view addSubview:label];
    label.userInteractionEnabled = YES;
    
    label.numberOfLines = 0;
    label.font = [label.font fontWithSize:13.];
    label.textColor = [UIColor blackColor];
    label.visibleCharactersNum = 70;
    label.text = @"123456789*123456789*123456789*123456789*123456789*123456789*123456789*123456789*";
    
    [label sizeToFit];
    [self.delegate.window addSubview:view];
    
    [self waitFor:30];
}

//********************************************************************************
-(void)expandableLabel:(PTNExpandableLabel *)expandableLabel willExpandToNewSize:(CGSize)newLabelSize duration:(NSTimeInterval)duration
{
    [UIView animateWithDuration:duration
                     animations:^(){
                         CGRect newFrame = stub.frame;
                         newFrame.origin.y += (newLabelSize.height - expandableLabel.frame.size.height);
                         stub.frame = newFrame;
                     }];
}

-(void)waitFor:(NSTimeInterval)seconds
{
    [[NSRunLoop mainRunLoop] runUntilDate:[NSDate dateWithTimeIntervalSinceNow:seconds]];
}
-(AppDelegate*)delegate
{
    return (AppDelegate*)[[UIApplication sharedApplication] delegate];
}

@end
