//
//  IllegalListViewController.h
//  AnCheXin
//
//  Created by cgx on 14-6-12.
//  Copyright (c) 2014年 LianJia. All rights reserved.
//

#import "BaseViewController.h"
#import "IllegalCell.h"

@interface IllegalListViewController : BaseViewController<UITableViewDataSource,UITableViewDelegate>
{
    UITableView *illegalTableView;
    NSMutableArray *listFlags;
    NSDictionary *resultDic;
    
}

@property(nonatomic,retain)NSString *strdic;

@end
