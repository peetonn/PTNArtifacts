//
//  MyViewController.m
//  PTNTestApp
//
//  Created by Peter Gusev on 12/6/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "MyViewController.h"
#import <PTNArtifacts/PTNControls.h>

@interface MyViewController ()

@end

@implementation MyViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)shouldAutorotate
{
    return YES;
}

-(IBAction)showAlert:(id)sender
{
    PTNInputAlertViewController *alertViewController = [[PTNInputAlertViewController alloc] init];
    [alertViewController showInputAlertViewWithTitle:@"Title"
                                             message:@"Input something!!!"
                                   cancelButtonTitle:@"OK"
                                andDismissalCallback:^(PTNAlertView *alertView, NSString *inputText){
                                    [self.button setTitle:inputText forState:UIControlStateNormal];
                                }];
}

- (void)viewDidUnload {
    [self setButton:nil];
    [super viewDidUnload];
}
@end
