//
//  PXCoalescedRunner.m
//  ActiveTrac
//
//  Created by Spencer Phippen on 2015/09/04.
//
//

#import "PXCoalescedRunner.h"

@implementation PXCoalescedRunner {
    double _delay;

    PXCoalescedRunnerBlock _block;

    NSInvocation* _invocation;

    PXCoalescedRunnerFunction _function;
    void* _context;

    NSTimer* _timer;
}

- (instancetype) init {
    return nil;
}

- (instancetype) initWithDelay:(double)delay block:(PXCoalescedRunnerBlock)block {
    NSParameterAssert(block);
    NSParameterAssert(delay >= 0.0);

    self = [super init];
    if (!self)
        return nil;

    _delay = delay;
    _block = block;

    _invocation = nil;
    _function = NULL;
    _context = NULL;

    return self;
}

- (instancetype) initWithDelay:(double)delay target:(id)target action:(SEL)action {
    NSParameterAssert(target);
    NSParameterAssert(delay >= 0.0);

    self = [super init];
    if (!self)
        return nil;

    _delay = delay;
    _invocation = [NSInvocation invocationWithMethodSignature:[target methodSignatureForSelector:action]];
    [_invocation setTarget:target];
    [_invocation setSelector:action];

    _block = nil;
    _function = NULL;
    _context = NULL;

    return self;
}

- (instancetype) initWithDelay:(double)delay function:(PXCoalescedRunnerFunction)function context:(void*)context {
    NSParameterAssert(function);
    NSParameterAssert(delay >= 0.0);

    self = [super init];
    if (!self)
        return nil;
    
    _delay = delay;
    _function = function;
    _context = context;
    
    _block = nil;
    _invocation = nil;

    return self;
}

- (void) startTimer {
    dispatch_async(dispatch_get_main_queue(), ^{
        [_timer invalidate];
        _timer = [NSTimer scheduledTimerWithTimeInterval:[self delay] target:self selector:@selector(actuallyCall) userInfo:nil repeats:FALSE];
    });
}

- (void) actuallyCall {
    if (_block)
        _block();
    else if (_function)
        _function(_context);
    else if (_invocation)
        [_invocation invoke];

    [_timer invalidate];
    _timer = nil;
}

@end
