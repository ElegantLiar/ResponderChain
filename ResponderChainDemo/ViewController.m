//
//  ViewController.m
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import "ViewController.h"
#import "UIResponder+Router.h"
#import "ResponderChainName.h"
#import "ResponderTestTableViewCell.h"
#import "EventProxy.h"
#import "TestAViewController.h"
#import "TestBViewController.h"

@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>


@end

@implementation ViewController{
    UITableView     *_tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    UIView *responderHeaderView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds), 200)];
    
    UIButton *testABtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testABtn setFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 4 - 40, 60, 80, 80)];
    [testABtn setBackgroundColor:[UIColor lightGrayColor]];
    [testABtn addTarget:self action:@selector(testABtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [responderHeaderView addSubview:testABtn];
    
    UIButton *testBBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBBtn setFrame:CGRectMake(CGRectGetWidth(self.view.bounds) / 4 * 3 - 40, 60, 80, 80)];
    [testBBtn setBackgroundColor:[UIColor darkGrayColor]];
    [testABtn addTarget:self action:@selector(testBBtnClicked) forControlEvents:UIControlEventTouchUpInside];
    [responderHeaderView addSubview:testBBtn];
    
    _tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    _tableView.delegate = self;
    _tableView.dataSource = self;
    [self.view addSubview:_tableView];
    [_tableView setTableHeaderView:responderHeaderView];
    
    [_tableView registerClass:[ResponderTestTableViewCell class] forCellReuseIdentifier:NSStringFromClass([ResponderTestTableViewCell class])];
    
    [EventProxy shareInstance].mainVc = self;
}

- (void)testABtnClicked{
    TestAViewController *testAVc = [[TestAViewController alloc] init];
    [self presentViewController:testAVc animated:YES completion:nil];
    [EventProxy shareInstance].testAVc = testAVc;
    [testAVc routerEventWithName:kTestABtnClickedEvent userInfo:nil];
}

- (void)testBBtnClicked{
    TestBViewController *testBVc = [[TestBViewController alloc] init];
    [self presentViewController:testBVc animated:YES completion:nil];
}

- (void)testCellBtnClicked:(NSDictionary *)info{
    UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"传递至控制器routerEventWithName"
                                                        message:info[kUserInfoObject]
                                                       delegate:nil
                                              cancelButtonTitle:@"OK"
                                              otherButtonTitles: nil];
    [alertView show];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 20;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    ResponderTestTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([ResponderTestTableViewCell class]) forIndexPath:indexPath];
    [cell configureTextWithIndexRow:indexPath.row];
    return cell;
}

- (void)routerEventWithName:(NSString *)eventName userInfo:(NSDictionary *)userInfo{
    [[EventProxy shareInstance] handleEvent:eventName userInfo:userInfo];
    
}

@end
