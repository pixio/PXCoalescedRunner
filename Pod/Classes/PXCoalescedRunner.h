//
//  PXCoalescedRunner.h
//  PXCoalescedRunner
//
//  Created by Spencer Phippen on 2015/09/04.
//
//

#import <Foundation/Foundation.h>

@class PXCoalescedRunner;
typedef void (^PXCoalescedRunnerBlock)();
typedef void (*PXCoalescedRunnerFunction)(void* context);

/** Coalesces multiple method calls less than a given amount of time apart into a single method call.
 *
 * For example, suppose we have a PXCoalescedRunner with a delay of 1 second.
 * When the startTimer method is called, the "action" passed to this class is scheduled
 * for invocation 1 second later - if the startTimer method is called again before the 1-second
 * window is up, the invocation is reset to 1 second in the future again. Once the entire 1-second
 * window passes without startTimer being called, the "action" is finally invoked.
 *
 * This class is thread-safe, but the action (whether block, target+selector pair, or C function) is always run on the main thread.
 * As a result, blocking the main thread can cause the action to be delayed.
 */
@interface PXCoalescedRunner : NSObject

- (instancetype) init __attribute__((unavailable("Use one of the other init methods")));

- (instancetype) initWithDelay:(double)delay block:(PXCoalescedRunnerBlock)block;
/** target is not retained */
- (instancetype) initWithDelay:(double)delay target:(id)target action:(SEL)action;
- (instancetype) initWithDelay:(double)delay function:(PXCoalescedRunnerFunction)function context:(void*)context;

/** If this property is changed, the new delay does not take effect until the next time startTimer is called. */
@property double delay;

/**
 * Starts the countdown to invoking the action for this runner.
 * See the class description for more detail.
 */
- (void) startTimer;

@end
