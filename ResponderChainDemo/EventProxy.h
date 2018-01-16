//
//  EventProxy.h
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import <Foundation/Foundation.h>

@class ViewController, TestAViewController, TestBViewController;
@interface EventProxy : NSObject

+ (EventProxy *)shareInstance;

- (void)handleEvent:(NSString *)eventName userInfo:(NSDictionary *)userInfo;

@property (nonatomic, weak) ViewController *mainVc;
@property (nonatomic, weak) TestAViewController *testAVc;
@property (nonatomic, weak) TestBViewController *testBVc;

@end
