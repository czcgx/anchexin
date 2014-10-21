//
//  HealthCardViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"
#import "HealthyCell.h"
#import "MaintenanceCell.h"
#import "RepairRecordCell.h"

#import "RepairInfoViewController.h"//订单详情
#import "CarTypeViewController.h"//车型

#import "OrderViewController.h"

@interface HealthCardViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    
    
    UIView *tabView;
    UIView *tabLine;
    UIView *tabContentView;
    
    UIView *tabContentView_1;
    UITableView *healthyTableView;
    UILabel *chooseLabel;
    
    UIView *tabContentView_2;
    UITableView *maintenanceTableView;
    
    UIView *tabContentView_3;
    UITableView *repairTableView;
    
    NSArray *todoArray;
    NSMutableArray *mainteArray;
    NSArray *repairArray;
    
    NSMutableArray *todoMutableArray;
    NSMutableArray *mainteMutableArray;
    
    NSString *currentKm;
    UILabel *currentKmLabel;
    
    
    int requestTimes;
    
    UIImageView *img;
    UILabel *lb1;
    
}

@end
