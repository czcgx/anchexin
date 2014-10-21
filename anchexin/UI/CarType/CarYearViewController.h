//
//  CarYearViewController.h
//  AnCheXin
//
//  Created by cgx on 14-2-20.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CarSeriesAndYearViewController.h"

@interface CarYearViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *carYearTableView;
    
    NSArray *yearArray;
    
}

@property(nonatomic,retain)NSString *seriesid;
@property(nonatomic,retain)NSString *brandID;

@end
