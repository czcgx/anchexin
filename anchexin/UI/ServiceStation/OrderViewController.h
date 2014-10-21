//
//  OrderViewController.h
//  anchexin
//
//  Created by cgx on 14-9-14.
//
//

#import "BaseViewController.h"
#import "CKCalendarView.h"//日历

@interface OrderViewController : BaseViewController<CKCalendarDelegate,UITextFieldDelegate,UIAlertViewDelegate,UIActionSheetDelegate,UITableViewDataSource,UITableViewDelegate>
{
    UIScrollView *orderScrollView;
    
    UILabel *orderDate;
    UILabel *orderTime;
    UILabel *orderContact;
    UILabel *orderPhone;
    
    
    CKCalendarView *calendar ;
    UIActionSheet *actionSheet;
    UIDatePicker *dataPickerView;//日期控件
    
    int pt;
    
    UIView *bottomView;
    
    int requestTimes;
    
    NSArray *ListArray;
    NSArray *sectionArray;
    UITableView *listTableView;
    
    NSMutableArray *tempArray;
    NSMutableArray *orderListArrayFlag;
    NSMutableArray *orderListArray;
    NSMutableArray *uploadorderListArray;
    
    UIView *pmView;
    
    UITextField *ewaiTextField;
}

@property(nonatomic,retain)NSArray *orderArray;
@property(nonatomic,retain)NSString *stationId;
@end
