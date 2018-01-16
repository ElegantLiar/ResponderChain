//
//  TestAViewController.m
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import "TestAViewController.h"
#import "EventProxy.h"
#import "UIResponder+Router.h"

@interface TestAViewController ()

@end

@implementation TestAViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn setFrame:CGRectMake(0, 0, 80, 80)];
    [testBtn setCenter:self.view.center];
    [testBtn setBackgroundColor:[UIColor darkGrayColor]];
    [testBtn addTarget:self action:@selector(btnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)hasPushedTestAViewController{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"hasPushedTestAViewController"
                                                        message:nil
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
}

- (void)btnClick{
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    [[EventProxy shareInstance] handleEvent:eventName userInfo:userInfo];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
