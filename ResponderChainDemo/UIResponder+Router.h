//
//  UIResponder+Router.h
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface UIResponder (Router)

/**
 为响应链添加配对的方法，以实现事件沿响应链传递

 @param eventName 事件名称
 @param userInfo 传递的参数
 */
- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@end
