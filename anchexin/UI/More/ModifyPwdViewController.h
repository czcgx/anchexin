//
//  ModifyPwdViewController.h
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BaseViewController.h"
#import "ModifyCell.h"

@interface ModifyPwdViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *modifyTableView;
    NSArray *modifyArray;
    
    int requestTimes;
    NSString *phoneNumber;
    
    int alertPt;
    
}

@property(nonatomic,assign)int tag;

@end
