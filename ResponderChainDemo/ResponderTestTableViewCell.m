//
//  ResponderTestTableViewCell.m
//  ResponderChainDemo
//
//  Created by EL on 2018/1/15.
//  Copyright © 2018年 Etouch. All rights reserved.
//

#import "ResponderTestTableViewCell.h"
#import "UIResponder+Router.h"
#import "ResponderChainName.h"

@implementation ResponderTestTableViewCell{
    UILabel     *_testLabel;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        [self initUI];
    }
    return self;
}

- (void)initUI{
    // cell中可点击按钮
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [testBtn setFrame:CGRectMake(100, 30, 110, 40)];
    [testBtn setBackgroundColor:[UIColor lightGrayColor]];
    [testBtn addTarget:self action:@selector(testBtnClick) forControlEvents:UIControlEventTouchUpInside];
    [self.contentView addSubview:testBtn];
    
    _testLabel = [[UILabel alloc] initWithFrame:CGRectMake(15, 0, 100, 100)];
    [_testLabel setFont:[UIFont systemFontOfSize:18]];
    [self.contentView addSubview:_testLabel];
}

- (void)configureTextWithIndexRow:(NSInteger)row{
    [_testLabel setText:[NSString stringWithFormat:@"row:%zd", row]];
}

- (void)testBtnClick{
    // 接收到点击事件时，将事件往上层传递
    [self.nextResponder routerEventWithName:kTestCellBtnClickedEvent userInfo:@{kUserInfoObject : _testLabel.text}];
}

@end
