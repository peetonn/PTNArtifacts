//
//  MyViewController.h
//  PTNTestApp
//
//  Created by Peter Gusev on 12/6/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MyViewController : UIViewController

-(IBAction)showAlert:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *button;

@end
