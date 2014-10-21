//
//  StationInfoViewController.h
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "BaseViewController.h"
#import "CommentCell.h"
#import "StationImgViewController.h"
#import "DisscussViewController.h"

@interface StationInfoViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UIView *tabView;
    UIView *tabLine;
    UIView *tabContentView;
    UIView *tabContentView_1;
    UIView *tabContentView_2;
    
    UITableView *shopTableView;
    
    NSMutableArray *shopMutableArray;
    
    NSDictionary *receiveDic;
    
    NSMutableArray *commentList;
    int requestTimes;
    int page;
    
    
}
@property(nonatomic,retain)NSArray *orderArry;

@property(nonatomic,retain)NSDictionary *stationInfo;

@end
