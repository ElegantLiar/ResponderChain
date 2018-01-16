//
//  UIResponder+Router.m
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import "UIResponder+Router.h"

@implementation UIResponder (Router)

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    [[self nextResponder] routerEventWithName:eventName userInfo:userInfo];
}

@end
