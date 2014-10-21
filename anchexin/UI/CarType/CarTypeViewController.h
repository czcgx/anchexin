//
//  CarTypeViewController.h
//  AnCheXin
//
//  Created by cgx on 13-11-9.
//  Copyright (c) 2013年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>


#import "CarTypeCell.h"
#import "ChineseToPinyin.h"//将中文转换成拼音
#import "CarSeriesViewController.h"//获取某车的系列

@interface CarTypeViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *carTableView;
    
    NSMutableArray *sections;
    NSMutableArray *rows;
    NSMutableArray *dataSource;
    
    NSArray *array;

}

@property(nonatomic,assign)int state;




@end
