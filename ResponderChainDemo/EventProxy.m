//
//  EventProxy.m
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import "EventProxy.h"
#import "ResponderChainName.h"

@interface EventProxy()

@property (nonatomic, strong) NSMutableDictionary<NSString *, NSInvocation *> *eventStrategy;

@end

@implementation EventProxy

+ (EventProxy *)shareInstance{
    static EventProxy *shareInstance = nil;
    static dispatch_once_t oncePredicate;
    dispatch_once(&oncePredicate, ^{
        shareInstance = [[EventProxy alloc] init];
    });
    return shareInstance;
}

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    NSInvocation *invocation = [self.eventStrategy objectForKey:eventName];
    if (invocation) {
        if (invocation.methodSignature.numberOfArguments > 2) {
            [invocation setArgument:&userInfo atIndex:2];
        }
        [invocation invoke];
    }
}

- (NSInvocation *)createInvocationWithTarget:(id)target selector:(SEL)action{
    if (!target) {
        return nil;
    }
    NSMethodSignature *methodSignature = [(NSObject *)target methodSignatureForSelector:action];
    NSInvocation *invocation = [NSInvocation invocationWithMethodSignature:methodSignature];
    invocation.selector = action;
    invocation.target = target;
    return invocation;
}

- (NSMutableDictionary<NSString *,NSInvocation *> *)eventStrategy{
    if (_eventStrategy == nil) {
        _eventStrategy = @{}.mutableCopy;
    }
    return _eventStrategy;
}

// 重写set方法是为了在设置其他target的时候，添加对应的事件

- (void)setMainVc:(ViewController *)mainVc{
    _mainVc = mainVc;
    if (![self.eventStrategy objectForKey:kTestCellBtnClickedEvent]) {
        [self.eventStrategy setObject:[self createInvocationWithTarget:self.mainVc selector:NSSelectorFromString(@"testCellBtnClicked:")] forKey:kTestCellBtnClickedEvent];
    }
}

- (void)setTestAVc:(TestAViewController *)testAVc{
    _testAVc = testAVc;
    if (![self.eventStrategy objectForKey:kTestABtnClickedEvent]) {
        [self.eventStrategy setObject:[self createInvocationWithTarget:self.testAVc selector:NSSelectorFromString(@"hasPushedTestAViewController")] forKey:kTestABtnClickedEvent];
    }
}

@end
