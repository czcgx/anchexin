//
//  CarSeriesAndYearViewController.h
//  AnCheXin
//
//  Created by cgx on 14-2-20.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>

#import "CreateHealthyCarViewController.h"//创建健康卡

@interface CarSeriesAndYearViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *carSeriesYearTableView;
    
    NSArray *seriesYearArray;
    
    int flag;
    
}

@property(nonatomic,retain)NSString *seriesid;
@property(nonatomic,retain)NSString *year;
@property(nonatomic,retain)NSString *brandID;
@property(nonatomic,retain)NSString * series;
@end
