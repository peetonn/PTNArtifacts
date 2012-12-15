//
//  PTNContainerViewController.m
//  reviewit
//
//  Created by Peter Gusev on 11/25/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import "PTNContainerViewController.h"

@interface PTNContainerViewController ()
@property (nonatomic) BOOL isViewTransitionInProgress;

@end

@implementation PTNContainerViewController
@synthesize contentView;
@synthesize isViewTransitionInProgress;
//********************************************************************
#pragma mark - received actions
// <#your IBAction's handlers goes here#>

//********************************************************************
#pragma mark - initialization and memory management
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//********************************************************************
#pragma mark - view lifecycle
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

//********************************************************************
#pragma mark - delegation: <#sender#>
// <#your delegated methods goes here#>

//********************************************************************
#pragma mark - protocol: <#protocol name#>
// <#your conformed protocol code goes here#>

//********************************************************************
#pragma mark - notifications
// <#your notification's handlers' code goes here#>

//********************************************************************
#pragma mark - overriden
// <#your overide code goes here#>

//********************************************************************
#pragma mark - class methods
// <#your class methods code goes here#>

//********************************************************************
#pragma mark - properties
-(UIViewController*)currentActiveViewController
{
    return _currentActiveViewController;
}
-(void)setCurrentActiveViewController:(UIViewController *)currentActiveViewController
{
    _currentActiveViewController = currentActiveViewController;
    //    [self adjustCurrentViewToSuperview];
}

//********************************************************************
#pragma mark - public methods
-(UIViewController*)loadViewControllerFromNibNamed:(NSString *)nibName ofClass:(__unsafe_unretained Class)viewControllerClass
{
    UIViewController *vc = [[viewControllerClass alloc] init];
    [[NSBundle mainBundle] loadNibNamed:nibName owner:vc options:nil];
    [self addChildViewController:vc];
    [self adaptViewControllerForContentView:vc];
    
    return vc;
}
-(UIViewController*)loadViewControllerFromStoryboard:(UIStoryboard *)storyboard named:(NSString *)viewControllerName
{
    UIViewController *vc = [storyboard instantiateViewControllerWithIdentifier:viewControllerName];
    [self addChildViewController:vc];
    [self adaptViewControllerForContentView:vc];
    
    return vc;
}
-(void)switchViewController:(UIViewController*)vc1 toViewController:(UIViewController*)vc2 withAnimation:(UIViewAnimationOptions)animation duration:(float)duration completionBlock:(void(^)(void))completionBlock;
{
    // check if view controller to be presented is already presented
    if ([self.currentActiveViewController isEqual:vc2])
        return;
    
    if (self.isViewTransitionInProgress)
        return;
    
    self.isViewTransitionInProgress = YES;
    [self transitionFromViewController:vc1
                      toViewController:vc2
                              duration:duration
                               options:animation
                            animations:^(){
                                vc1.view.hidden = YES;
                                vc2.view.hidden = NO;
                            }
                            completion:^(BOOL finished){
                                self.isViewTransitionInProgress = NO;
                                self.currentActiveViewController = vc2;
                                
                                if (completionBlock)
                                    completionBlock();
                            }];
}
-(void)adjustCurrentViewToSuperview
{
    self.currentActiveViewController.view.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
}
-(void)initializeCurrentViewControllerWithViewController:(UIViewController *)vc
{
    self.currentActiveViewController = vc;
    [self.contentView addSubview:vc.view];
}
//********************************************************************
#pragma mark - private methods
-(void)adaptViewControllerForContentView:(UIViewController*)vc
{
    vc.view.frame = CGRectMake(0, 0, self.contentView.bounds.size.width, self.contentView.bounds.size.height);
}

@end
