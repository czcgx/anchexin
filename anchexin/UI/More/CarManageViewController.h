//
//  CarManageViewController.h
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "ManageCell.h"
#import "CarInfoViewController.h"//车辆信息

@interface CarManageViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *manageTableView;
    NSArray *manageArray;
    
    int requestTimes;
    int index;
    
    NSString *currentNumber;
    
    int alertPt;
}

@end
