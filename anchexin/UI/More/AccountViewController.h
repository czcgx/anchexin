//
//  AccountViewController.h
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "BaseViewController.h"
#import "AccountCell.h"
#import "ModifyPwdViewController.h"//编辑密码和修改手机号

@interface AccountViewController : BaseViewController<UITableViewDelegate,UITableViewDataSource>
{
    UITableView *accountTableView;
    NSArray *accountArray;
    
}

@end
