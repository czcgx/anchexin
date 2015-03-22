//
//  NoticationsViewController.h
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"
#import "NoticationCell.h"
#import "EditCell.h"

@interface NoticationsViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *remindTableView;
    
    UIView *tabView;
    UIView *tabLine;
    
    int pt;
    
    int requestTimes;
    
    NSArray *noticeList;
    NSDictionary *noticeDic;
    
    UILabel *desLabel;
    
    int alertPt;
}


@end
