//
//  ChangeStateServiceViewController.h
//  AnCheXin
//
//  Created by cgx on 14-2-26.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ChangeStateServiceViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *maintenanceTableView;
    NSMutableArray *flagArray;//标志数组。用来判断当前是展开还是闭合，0-->闭合，1-->展开
    NSMutableArray *mainteArray;//保养卡列表
    
    int flag;
}


@property(nonatomic,retain)NSString *carid;


@end
