//
//  ACNavBarDrawer.h
//  ACNavBarDrawer
//
//  Created by albert on 13-7-29.
//  Copyright (c) 2013年 albert. All rights reserved.
//

#import <UIKit/UIKit.h>

/** 抽屉视图 委托协议 */
@protocol ACNavBarDrawerDelegate <NSObject>

@required
/** 关闭按钮 代理回调方法 */
-(void)theBtnPressed:(NSString *)content sort:(int)sort;

@optional
/** 触摸背景 遮罩 代理回调方法 */
-(void)theBGMaskTapped;

@end


@interface ACNavBarDrawer : UIView<UITableViewDataSource,UITableViewDelegate>
{
    
    NSArray *arr;
    UITableView *ACNTableView;
    
    int selectedIndex;
    NSString *defaultStr;
    
}

/** 抽屉视图 代理 */
@property (nonatomic, assign) id <ACNavBarDrawerDelegate> delegate;


/** 抽屉视图是否已打开 */
@property (nonatomic) BOOL isOpen;


/**
 * 实例化抽屉视图
 */

-(id)initView;

/**
 * 打开抽屉
 */
- (void)openNavBarDrawer:(int)index Parameters:(id)Parameters defaultValue:(id)defaultValue;
/**
 * 关起抽屉
 */
- (void)closeNavBarDrawer;

@end
