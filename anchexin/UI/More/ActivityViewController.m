//
//  ActivityViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "ActivityViewController.h"

@interface ActivityViewController ()

@end

@implementation ActivityViewController

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
    
    [MobClick event:@"activityPage"];//统计活动页面
    
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 150)];
    subView.backgroundColor=[UIColor whiteColor];
    [subView addSubview:[self drawLine:CGRectMake(0, 0, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    txt1=[[UITextField alloc] initWithFrame:CGRectMake(15, 10, 290, 35)];
    txt1.returnKeyType=UIReturnKeyDone;
    txt1.font=[UIFont systemFontOfSize:15.0];
    txt1.placeholder=@"请输入搜索区域";
    txt1.delegate=self;
    txt1.borderStyle=UITextBorderStyleRoundedRect;
    txt1.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [subView addSubview:txt1];
    [subView addSubview:[self customButton:txt1.frame tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    txt2=[[UITextField alloc] initWithFrame:CGRectMake(15, 50, 290, 35)];
    txt2.returnKeyType=UIReturnKeyDone;
    txt2.font=[UIFont systemFontOfSize:15.0];
    txt2.placeholder=@"请输入搜索项目";
    txt2.delegate=self;
    txt2.borderStyle=UITextBorderStyleRoundedRect;
    txt2.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [subView addSubview:txt2];
    [subView addSubview:[self customButton:txt2.frame tag:2 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    
    [subView addSubview:[self customView:CGRectMake(50, 100, 100, 35) labelTitle:@"已领取" buttonTag:3]];
    
    [subView addSubview:[self customView:CGRectMake(170, 100, 100, 35) labelTitle:@"搜索" buttonTag:4]];
    
    
    [subView addSubview:[self drawLine:CGRectMake(0, subView.frame.size.height-1, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    [mainView addSubview:subView];
    
    
    activityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 165, WIDTH,mainView.frame.size.height-165)];
    activityTableView.delegate=self;
    activityTableView.dataSource=self;
    activityTableView.backgroundView=nil;
    activityTableView.backgroundColor=[UIColor clearColor];
    activityTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [mainView addSubview:activityTableView];
    
    [self.view addSubview:mainView];
    
    _drawerView = [[ACNavBarDrawer alloc] initView];
    _drawerView.delegate = self;
    [self.view addSubview:_drawerView];
    
    

    [ToolLen ShowWaitingView:YES];
    requestTimes=3;
    [[self JsonFactory]getActivity:@"getActivity"];
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errcode"] intValue]==0 && requestTimes==3)
    {
        requestArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"activitylist"]];
        
        [activityTableView reloadData];
    }
    else if (responseObject && [[responseObject objectForKey:@"errcode"] intValue]==0 && requestTimes==1)
    {
        //弹出视图
        [_drawerView openNavBarDrawer:1 Parameters:[responseObject objectForKey:@"citylist"] defaultValue:@"no"];
    }
    else if (responseObject && [[responseObject objectForKey:@"errcode"] intValue]==0 && requestTimes==4)
    {
        requestArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"activitylist"]];
        
        [activityTableView reloadData];
    }
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        requestTimes=1;
        [[self JsonFactory] getCityList:@"getCityList"];//获取城市列表
    }
    else if(sender.tag==2)
    {
        NSArray *arr=[[NSArray alloc] initWithObjects:@"保养",@"美容",@"洗车",@"其他", nil];
        [_drawerView openNavBarDrawer:3 Parameters:arr defaultValue:@"no"];

    }
    else if(sender.tag==3)
    {
        requestTimes=3;
        [[self JsonFactory]getActivity:@"getActivity"];
    }
    else if(sender.tag==4)
    {
        requestTimes=4;
        if (txt1.text.length>0 && txt2.text.length>0)
        {
            [[self JsonFactory]searchActivity:txt1.text item:txt2.text action:@"searchActivity"];
        }
        
    }
}

#pragma mark - ACNavBarDrawerDelegate
-(void)theBtnPressed:(NSString *)content sort:(int)sort
{
    if (sort==1)
    {
        txt1.text=content;
    }
    else
    {
        txt2.text=content;
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [requestArray count];
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 100.0;
}
-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    ActivitiyCell *cell=(ActivitiyCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"ActivitiyCell" owner:self options:nil];
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
    
    //图片
    [cell.shopImageView setImageWithURL:[NSURL URLWithString:[[requestArray objectAtIndex:indexPath.row] objectForKey:@"stationimg"]] placeholderImage:nil];
    
    //标题
    cell.activityNameLabel.text=[[requestArray objectAtIndex:indexPath.row] objectForKey:@"title"];
    
    //活动门店
    cell.shopNameLabel.text=[[requestArray objectAtIndex:indexPath.row] objectForKey:@"stationname"];
    //活动项目
    cell.carNameLabel.text=[[requestArray objectAtIndex:indexPath.row] objectForKey:@"item"];
    
    //活动时间
    cell.timeLabel.text=[NSString stringWithFormat:@"%@/%@",[[[requestArray objectAtIndex:indexPath.row] objectForKey:@"starttime"] substringFromIndex:2],[[[requestArray objectAtIndex:indexPath.row] objectForKey:@"endtime"] substringFromIndex:2] ];
    
    if ([[[requestArray objectAtIndex:indexPath.row] objectForKey:@"have"] isEqualToString:@"true"])
    {
        cell.isRequest.textColor=[UIColor redColor];
        cell.isRequest.text=@"活动已领取";
    }
    else
    {
        cell.isRequest.textColor=[UIColor lightGrayColor];
        cell.isRequest.text=@"请参加活动";
    }
    
    
    return cell;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
    info.activityInfo=[requestArray objectAtIndex:indexPath.row];
    [self.navigationController pushViewController:info animated:YES];
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
