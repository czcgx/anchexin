//
//  CarSeriesViewController.h
//  AnCheXin
//
//  Created by cgx on 14-2-20.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarYearViewController.h"

@interface CarSeriesViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *carSeriesTableView;
    
    NSArray *seriesArray;
    
}

@property(nonatomic,retain)NSString *brandID;

@end
