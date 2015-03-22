//
//  MoreViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "MoreViewController.h"

@interface MoreViewController ()

@end

@implementation MoreViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    //[self changebgImg];//更改背景图片
    //[self skinOfBackground];
    self.view.backgroundColor=kUIColorFromRGB(0x1c1c1c);
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 480+(iPhone5?88:0)-20)];
    mainView.backgroundColor=[UIColor clearColor];
    
    //@"行程分析",@"车况诊断",,@"设备绑定"@"修改密码",
    moreArray=[[NSArray alloc] initWithObjects:@[@"返回"],@[@"我的订单",@"优惠活动",@"常去店铺"],@[@"账户信息",@"身份二维码",@"车辆管理"],@[@"操作指南",@"关于我们",@"意见反馈",@"换肤",@"注销"], nil];
    //@"icon2",@"icon3",@"icon8"//,,,,@"icon6",
    moreIconArray=[[NSArray alloc] initWithObjects:@[@"tab3@2x"],@[@"icon1",@"icon4",@"icon14"],@[@"icon5",@"icon7",@"icon9",],@[@"icon10",@"icon11",@"icon15",@"icon12",@"icon13"], nil];
    
    moreTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, mainView.frame.size.height)];
    moreTableView.delegate=self;
    moreTableView.dataSource=self;
    moreTableView.backgroundView=nil;
    moreTableView.backgroundColor=[UIColor clearColor];
    moreTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [mainView addSubview:moreTableView];
    
    [self.view addSubview:mainView];
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [moreArray count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [moreArray[section] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;

}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 25.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 25)];
    bgView.backgroundColor=[UIColor clearColor];
    
    UILabel *upLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    upLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:upLabel];
    
    UILabel *downLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 24.5, WIDTH, 0.5)];
    downLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:downLabel];
    
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";

    MoreCell *cell=(MoreCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MoreCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    UILabel *labelbg=[[UILabel alloc] initWithFrame:CGRectMake(20, 49.5, WIDTH-40, 0.5)];
    labelbg.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [cell.contentView addSubview:labelbg];
  
    if (indexPath.row<[moreArray[indexPath.section] count]-1 || indexPath.section==2)
    {
        labelbg.hidden=NO;
    }
    else
    {
        labelbg.hidden=YES;
    }
    
    NSString *icon=moreIconArray[indexPath.section][indexPath.row];
    cell.iconImageView.image=IMAGE(icon);
    
    cell.contentLabel.text=moreArray[indexPath.section][indexPath.row];
        

    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.section==0)
    {
        if (indexPath.row==0)
        {
            //NSLog(@"返回");
        
         // UITabBarController *tabBarController=[[AppDelegate setGlobal] customTabBarController];
            
          [[AppDelegate setGlobal].rootController setRootController:[AppDelegate setGlobal].tabBarController animated:YES];
        
        }
    }
    else if (indexPath.section==1)
    {
        switch (indexPath.row)
        {
            case 0://我的订单
            {
                
                MyOrderViewController *order=[[MyOrderViewController alloc] init];
                CustomNavigationController *nav=[[CustomNavigationController alloc] initWithRootViewController:order];
                order.state=1;
                order.title=@"我的订单";
                order.selected=0;
                [[AppDelegate setGlobal].rootController setRootController:nav animated:YES];
    
                /*
                [[NSUserDefaults standardUserDefaults] setObject:@"bg2.png" forKey:@"DefaultBackground"];
                
                [self alertOnly:@"更换皮肤成功"];
                
                //通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBgImg" object:nil userInfo:nil];
                
                //通知
                [[NSNotificationCenter defaultCenter] postNotificationName:@"homeSkin" object:nil userInfo:nil];
                 */
                
                
                break;
            }
            case 1://市场活动
            {
               
               // ActivityViewController *activity=[[ActivityViewController alloc] init];
                New_ActivityViewController *activity=[[New_ActivityViewController alloc] init];
                CustomNavigationController *navActivity=[[CustomNavigationController alloc] initWithRootViewController:activity];
                
                activity.title=@"优惠活动";
                [[AppDelegate setGlobal].rootController setRootController:navActivity animated:YES];
                
                break;
            }
            case 2://常去店铺
            {
                
                CollectionShopViewController *collect=[[CollectionShopViewController alloc] init];
                CustomNavigationController *navCollect=[[CustomNavigationController alloc] initWithRootViewController:collect];
                
                collect.title=@"常去店铺";
                [[AppDelegate setGlobal].rootController setRootController:navCollect animated:YES];
                
                break;
            }
                
            default:
                break;
        }
    }
    else if (indexPath.section==2)
    {
        switch (indexPath.row)
        {
            case 0://账户信息
            {
                AccountViewController *account=[[AccountViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:account];
                
                account.title=@"账户信息";
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
                /*
            case 1://修改密码
            {
                ModifyPwdViewController *modifyPwd=[[ModifyPwdViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:modifyPwd];
                
                modifyPwd.title=@"修改密码";
                modifyPwd.tag=2;//修改密码
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
                 */
            case 1://二维码
            {
                CodeViewController *code=[[CodeViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:code];
                
                code.title=@"二维码";
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
            case 2://车辆管理
            {
                CarManageViewController *manage=[[CarManageViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:manage];
                
                manage.title=@"车辆管理";
                
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
                
                
            default:
                break;
        }
    }
    else if (indexPath.section==3)
    {
        switch (indexPath.row)
        {
            case 0://操作指南
            {
                GuideViewController *guide=[[GuideViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:guide];
                
                guide.title=@"操作指南";
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
            case 1://关于我们
            {
                AboutUsViewController *about=[[AboutUsViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:about];
                
                about.title=@"关于我们";
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
            case 2://意见反馈
            {
                FeedbackViewController *feed=[[FeedbackViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:feed];
                
                feed.title=@"意见反馈";
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                break;
            }
            case 3://换肤
            {
                
                SkinViewController *skin=[[SkinViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:skin];
                
                skin.title=@"换肤";
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                
                
                break;
            }
            case 4://注销
            {
               
                [document deleteFileFromDocument:@"user"];//删除保存的用户信息
                [document deleteFileFromDocument:@"car"];//删除车辆信息
                
                [document deleteFileFromDocument:@"ServiceCity"];//删除城市
                
                
                [[NSUserDefaults standardUserDefaults] setInteger:0 forKey:@"vaild"];//无效
                //置空
                [AppDelegate setGlobal].token=nil;
                [AppDelegate setGlobal].uid=nil;
                
                LoginGuideViewController *guide=[[LoginGuideViewController alloc] init];
                CustomNavigationController *navAccount=[[CustomNavigationController alloc] initWithRootViewController:guide];
            
                [[AppDelegate setGlobal].rootController setRootController:navAccount animated:YES];
                
                
                /*
                navAccount.view.frame=CGRectMake(WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
                
                [[UIApplication sharedApplication].keyWindow addSubview:navAccount.view];
                
                [UIView animateWithDuration:1.0 animations:^{
                    self.view.frame=CGRectMake(-WIDTH, 0, WIDTH, 480+(iPhone5?88:0));
                    navAccount.view.frame=CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0));
                }];
                 */
                
                break;
            }
        }
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
