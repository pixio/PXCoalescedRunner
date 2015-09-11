//
//  PXViewController.m
//  PXCoalescedRunner
//
//  Created by Spencer Phippen on 09/11/2015.
//  Copyright (c) 2015 Spencer Phippen. All rights reserved.
//

#import "PXViewController.h"

#import <PXCoalescedRunner/PXCoalescedRunner.h>
#import "PXView.h"

static UIColor* randomColor();
static void runner2CFunction(void* context);

@implementation PXViewController {
    PXCoalescedRunner* _runner1;
    PXCoalescedRunner* _runner2;
    PXCoalescedRunner* _runner3;
}

- (instancetype) initWithNibName:(NSString*)nibNameOrNil bundle:(NSBundle*)nibBundleOrNil {
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (!self)
        return nil;
    
    typeof(self) __weak weakSelf = self;
    _runner1 = [[PXCoalescedRunner alloc] initWithDelay:1.0 block:^{
        typeof(self) __strong strongSelf = weakSelf;
        [strongSelf button1];
    }];
    _runner2 = [[PXCoalescedRunner alloc] initWithDelay:1.0 function:runner2CFunction context:(__bridge void*)self];
    _runner3 = [[PXCoalescedRunner alloc] initWithDelay:1.0 target:self action:@selector(button3)];
    
    return self;
}

#pragma mark UIViewController Methods
- (void) loadView {
    [self setView:[[PXView alloc] init]];
}

- (void) viewDidLoad {
    [[[self pxView] button1] addTarget:self action:@selector(button1Pushed:) forControlEvents:UIControlEventTouchUpInside];
    [[[self pxView] button2] addTarget:self action:@selector(button2Pushed:) forControlEvents:UIControlEventTouchUpInside];
    [[[self pxView] button3] addTarget:self action:@selector(button3Pushed:) forControlEvents:UIControlEventTouchUpInside];
}

#pragma mark PXViewController Methods
- (PXView*) pxView {
    return (PXView*)[self view];
}

- (void) button1Pushed:(UIButton*)button {
    [_runner1 startTimer];
}
- (void) button1 {
    [[[self pxView] button1] setBackgroundColor:randomColor()];
}

- (void) button2Pushed:(UIButton*)button {
    [_runner2 startTimer];
}
- (void) button2 {
    [[[self pxView] button2] setBackgroundColor:randomColor()];
}

- (void) button3Pushed:(UIButton*)button {
    [_runner3 startTimer];
}
- (void) button3 {
    [[[self pxView] button3] setBackgroundColor:randomColor()];
}

@end

static UIColor* randomColor() {
    double r = (double)arc4random() / UINT32_MAX;
    double g = (double)arc4random() / UINT32_MAX;
    double b = (double)arc4random() / UINT32_MAX;
    return [UIColor colorWithRed:r green:g blue:b alpha:1.0];
}

static void runner2CFunction(void* context) {
    PXViewController* controller = (__bridge PXViewController*)context;
    [controller button2];
}
