//
//  AnalysisViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "AnalysisViewController.h"

@interface AnalysisViewController ()

@end

@implementation AnalysisViewController

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
    [self skinOfBackground];
    self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor clearColor];
    
    /*
     moreArray=[[NSArray alloc] initWithObjects:@[@"返回"],@[@"我的订单",@"行程分析",@"车况诊断",@"市场活动"],@[@"账户信息",@"修改密码",@"二维码",@"设备绑定",@"车辆管理"],@[@"操作指南",@"关于我们"], nil];
     moreIconArray=[[NSArray alloc] initWithObjects:@[@"tab3@2x"],@[@"icon1",@"icon2",@"icon3",@"icon4",],@[@"icon5",@"icon6",@"icon7",@"icon8",@"icon9",],@[@"icon10",@"icon11",], nil];
     */
    
    analysisTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, mainView.frame.size.height)];
    analysisTableView.delegate=self;
    analysisTableView.dataSource=self;
    analysisTableView.backgroundView=nil;
    analysisTableView.backgroundColor=[UIColor clearColor];
    analysisTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [mainView addSubview:analysisTableView];
    
    [self.view addSubview:mainView];

    
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 3;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 40)];
    bgView.backgroundColor=kUIColorFromRGB(0x1c1c1c);
    
    /*
    UILabel *upLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    upLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:upLabel];
    
    UILabel *downLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 24.5, WIDTH, 0.5)];
    downLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:downLabel];
    */
    
    return bgView;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    AnalysisCell *cell=(AnalysisCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"AnalysisCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (indexPath.row % 2)
    {
        cell.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    }

    

    
    return cell;
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
