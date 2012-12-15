//
//  PTNContainerViewController.h
//  reviewit
//
//  Created by Peter Gusev on 11/25/12.
//  Copyright (c) 2012 peetonn inc. All rights reserved.
//

#import <UIKit/UIKit.h>

/**
 * This is superclass for container view controllers. It includes necessary behaviour for switching between view controllers. Current shown view controller is stored in currentActiveViewController.
 */
@interface PTNContainerViewController : UIViewController
{
    UIViewController *_currentActiveViewController;
}

/**
 * @name Properties
 */
/**
 * Current presented view controller
 */
@property (nonatomic, strong) UIViewController *currentActiveViewController;
/**
 * Determines, if animation of transition of view controllers is in progress
 */
@property (nonatomic, readonly) BOOL isViewTransitionInProgress;
/**
 * Content view, to which all view controllers' views will be added. Should be linked with xib outlets in subclasses
 */
@property (weak, nonatomic) IBOutlet UIView *contentView;

/**
 * @name Instance methods
 */
/**
 * Perform animated transition between view controllers.
 * @param vc1 View controller to switch from. Normally, it is self.currentActiveViewController
 * @param vc2 View controller that will be presented
 * @param animation UIViewAnimationOptions variable presenting animation options for transition
 * @param duration Animation duration
 * @param completionBlock Callback which is get called upon animatino completion
 */
-(void)switchViewController:(UIViewController*)vc1 toViewController:(UIViewController*)vc2 withAnimation:(UIViewAnimationOptions)animation duration:(float)duration completionBlock:(void(^)(void))completionBlock;
/**
 * Loads view controller from .xib file, configures it and adds it as a child view contorller
 */
-(UIViewController*)loadViewControllerFromNibNamed:(NSString*)nibName ofClass:(Class)viewControllerClass;
/**
 * Loads view controller from storyboard, configures it and adds it as a child view controller
 */
-(UIViewController*)loadViewControllerFromStoryboard:(UIStoryboard*)storyboard named:(NSString*)viewControllerName;
/**
 * Performs adjustment of current view controller's view to the content view
 */
-(void)adjustCurrentViewToSuperview;
/**
 * Initiates current view controller with the view controller provided by adding its view to the content view.
 * @param vc View controller which is going to be present initially
 */
-(void)initializeCurrentViewControllerWithViewController:(UIViewController*)vc;

@end
