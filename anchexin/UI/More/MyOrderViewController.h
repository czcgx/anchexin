//
//  MyOrderViewController.h
//
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "OrderCell.h"
#import "OrderInfoViewController.h"
#import "RepairRecordCell.h"

@interface MyOrderViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UIView *tabView;
    UIView *tabLine;
    
    UITableView *orderTableView;
    
    int requestTimes;
    
    NSArray *orderList;
    NSArray *repairArray;
    
}

@property(nonatomic,assign)int state;
@property(nonatomic,assign)int selected;

@end
