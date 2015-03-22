//
//  ServiceStationViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "ServiceStationViewController.h"

@interface ServiceStationViewController ()

@end

@implementation ServiceStationViewController
@synthesize lat;
@synthesize lng;
@synthesize orderArray;
@synthesize state;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}


-(void)search_search
{
    pageIndex++;
    [[self JsonFactory]getRepairStationListBySearch:[NSString stringWithFormat:@"%d",pageIndex] name:searchText.text lat:lat lng:lng action:@"getStationListBySearch"];
    
}

-(void)searchIcon
{
    [searchText resignFirstResponder];
    
    if (!searchBool)
    {
        self.navigationItem.rightBarButtonItem.title=@"常用";
        //upSubView.frame=CGRectMake(-WIDTH, 0, WIDTH, 50);
        searchView.hidden=NO;
        tabView.hidden=YES;
    }
    else
    {
        self.navigationItem.rightBarButtonItem.title=@"搜索";
        //upSubView.frame=CGRectMake(0, 0, WIDTH, 50);
        searchView.hidden=YES;
        tabView.hidden=NO;
        
    }
    searchBool=!searchBool;
    
    CGContextRef context=UIGraphicsGetCurrentContext();
    [UIView beginAnimations:nil context:context];
    [UIView setAnimationCurve:UIViewAnimationCurveLinear];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationTransition:UIViewAnimationTransitionFlipFromLeft forView:upSubView cache:YES];
    
    //当父视图里面只有两个视图的时候，可以直接使用下面这段.
    [upSubView exchangeSubviewAtIndex:0 withSubviewAtIndex:1];
    
    
    [UIView setAnimationDelegate:self];
    [UIView commitAnimations];
    
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [MobClick event:@"stationService"];//统计服务网点页面

}



- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    searchBool=NO;
    //导航栏右侧
    UIBarButtonItem *item=[[UIBarButtonItem alloc] initWithTitle:@"搜索"
                                                           style:UIBarButtonItemStylePlain
                                                          target:self
      
                                                          action:@selector(searchIcon)];
    
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        item.tintColor=[UIColor whiteColor];
    }
    
    self.navigationItem.rightBarButtonItem=item;
  
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor clearColor];
    
    upSubView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    upSubView.backgroundColor=[UIColor clearColor];
    [mainView addSubview:upSubView];
    
    //搜索界面
    searchView=[[UIView alloc] initWithFrame:CGRectMake(0,0,WIDTH, 50)];
    searchView.backgroundColor=[UIColor blackColor];
    searchView.alpha=0.8;
    searchView.hidden=YES;
    [searchView addSubview:[self customImageView:searchView.bounds image:IMAGE(@"rootbg")]];

    /*
    UIImageView *frameImageView=[[UIImageView alloc] initWithFrame:CGRectMake(5, 8, 260, 35)];
    frameImageView.image=IMAGE(@"search_frame");
    [searchView addSubview:frameImageView];
    */
    UIView *view=[[UIView alloc] initWithFrame:CGRectMake(5, 8, 260, 35)];
    view.backgroundColor=[UIColor whiteColor];
    view.layer.cornerRadius = 5;//(值越大，角就越圆)
    view.layer.masksToBounds = YES;
    view.layer.borderWidth=1.0;
    view.layer.borderColor=[[UIColor clearColor] CGColor];
    [searchView addSubview:view];
    
    
    UIImageView *searchImageView=[[UIImageView alloc] initWithFrame:CGRectMake(15, 18, 18, 18)];
    searchImageView.image=IMAGE(@"search_search");
    [searchView addSubview:searchImageView];
    
    searchText=[[UITextField alloc] initWithFrame:CGRectMake(40, 9, 250, 35)];
    searchText.delegate=self;
    searchText.font=[UIFont systemFontOfSize:14.0];
    searchText.returnKeyType=UIReturnKeyDone;
    searchText.placeholder=@"输入搜索关键字";
    [searchView addSubview:searchText];

    
    /*
    UIButton *searchButton=[UIButton buttonWithType:UIButtonTypeCustom];
    searchButton.frame=CGRectMake(268, 11, 50, 30);
    [searchButton setBackgroundImage:IMAGE(@"search_button") forState:UIControlStateNormal];
    [searchButton addTarget:self action:@selector(search) forControlEvents:UIControlEventTouchUpInside];
    */
    
    UIView *customView=[[UIView alloc] initWithFrame:CGRectMake(268, 11, 50, 30)];
    customView.backgroundColor=[UIColor clearColor];
    customView.layer.cornerRadius = 5;//(值越大，角就越圆)
    customView.layer.masksToBounds = YES;
    customView.layer.borderWidth=1.0;
    customView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [customView addSubview:[self customLabel:customView.bounds color:[UIColor lightGrayColor] text:@"搜索" alignment:0 font:16.0]];
    [customView addSubview:[self customButton:customView.bounds tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [searchView addSubview:customView];
    
    //[searchView addSubview:[self customView:CGRectMake(268, 11, 50, 30) labelTitle:@"搜索" buttonTag:1]];

    [upSubView addSubview:searchView];
    

    //常用界面
    tabView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
    tabView.backgroundColor=[UIColor blackColor];
    tabView.alpha=0.8;
    [tabView addSubview:[self customImageView:tabView.bounds image:IMAGE(@"rootbg")]];
    
    NSMutableArray *tabArray=[[NSMutableArray alloc] init];
    NSString *cityStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"ServiceProvice"];
    if (cityStr)
    {
        r_city=cityStr;
        [tabArray addObject:cityStr];
    }
    else
    {
        r_city=@"";
        [tabArray addObject:@"省份"];
    }
    
    NSString *areaStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"ServiceArea"];
    if (areaStr)
    {
        r_area=areaStr;
        [tabArray addObject:areaStr];
    }
    else
    {
        r_area=@"";
        [tabArray addObject:@"区域"];
    }
    
    NSString *orderStr=[[NSUserDefaults standardUserDefaults] objectForKey:@"ServiceOrder"];
    order=@"";
    if (orderStr)
    {
        r_order=orderStr;
        [tabArray addObject:orderStr];
        
        //顺序
        if ([r_order isEqualToString:@"默认排序"])
        {
            order=@"";
        }
        else if ([r_order isEqualToString:@"按总分排序"])
        {
            order=@"avg_comment";
        }
        else if ([r_order isEqualToString:@"距离最近"])
        {
            order=@"juli";
        }
    }
    else
    {
        r_order=@"";
        [tabArray addObject:@"排序"];
    }
    
    for (int i=0; i<tabArray.count; i++)
    {
        if (i>0)
        {
            UILabel *label_=[[UILabel alloc] initWithFrame:CGRectMake(107*i, 10, 1, 30)];
            label_.backgroundColor=[UIColor whiteColor];
            [tabView addSubview:label_];
        }
        
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(107*i, 10, 107, 30)];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:16.0];
        label.text=[tabArray objectAtIndex:i];
        label.tag=i+100;
        label.textColor=[UIColor whiteColor];
        label.textAlignment=NSTextAlignmentCenter;
        [tabView addSubview:label];
        
        [tabView addSubview:[self customButton:label.frame tag:i+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    }
    
    [upSubView addSubview:tabView];
    
    UIView *subView=nil;
    if (state==0)
    {
        //底部
        subView=[[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, mainView.frame.size.height-50)];
    }
    else
    {
        //底部
        subView=[[UIView alloc] initWithFrame:CGRectMake(0, 50, WIDTH, mainView.frame.size.height-50-50)];
    }
   
   
    [mainView addSubview:subView];
    [self.view addSubview:mainView];
    
    serviceTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, subView.frame.size.height)];
    serviceTableView.delegate=self;
    serviceTableView.dataSource=self;
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        serviceTableView.backgroundView=nil;
        serviceTableView.backgroundColor=[UIColor clearColor];
    }
    serviceTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [subView addSubview:serviceTableView];
    

    //第三方控件，进行下拉刷新
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = serviceTableView;
    

    _drawerView = [[ACNavBarDrawer alloc] initView];
    _drawerView.delegate = self;
    [self.view addSubview:_drawerView];
    
    if (![AppDelegate setGlobal].currentLatitude || ![AppDelegate setGlobal].currentLongitude)
    {
        [AppDelegate setGlobal].currentLatitude=@"";
        [AppDelegate setGlobal].currentLongitude=@"";
    }
    
    lat=[AppDelegate setGlobal].currentLatitude;
    lng=[AppDelegate setGlobal].currentLongitude;
    //NSLog(@"%@,%@",lat,lng);
    
    pageIndex=0;
   // pt=0;
    //[self reloadRequestData:r_city area:r_area type:@""];
    
    [self reloadRequestOrderData:r_city area:r_area order:order];
   
    
}


-(void)customEvent:(UIButton *)sender
{
    
    if (sender.tag==1)
    {
        [UIView animateWithDuration:.3 animations:^{
            [searchText resignFirstResponder];
            
        }completion:^(BOOL finished) {
            [ToolLen ShowWaitingView:YES];
            requestTimes=1;
            pageIndex=0;
            
            [self search_search];
            
        }];
    }
    else
    {
        [UIView beginAnimations:nil context:nil];//动画开始
        [UIView setAnimationDuration:0.3];
        
        NSArray *arr=nil;
        switch (sender.tag)
        {
            case 100://选择城市
            {
                //tabLine.frame = CGRectMake(0, 42, WIDTH/3, 10);
                requestTimes=100;
                NSArray *tempArray=[document readDataFromDocument:@"ServiceCity" IsArray:YES];
                if (tempArray)
                {
                    [_drawerView openNavBarDrawer:1 Parameters:tempArray defaultValue:r_city];
                }
                else
                {
                    [[self JsonFactory] getCityList:@"getCityList"];
                }
                
                break;
            }
            case 101://点击选择区域
            {
                //tabLine.frame = CGRectMake(WIDTH/3, 42, WIDTH/3, 10);
                requestTimes=101;
                if (![r_city isEqualToString:@""])
                {
                    NSArray *tempArray=[document readDataFromDocument:[NSString stringWithFormat: @"ServiceArea_%@",r_city] IsArray:YES];
                    if (tempArray)
                    {
                        [_drawerView openNavBarDrawer:2 Parameters:tempArray defaultValue:r_area];
                    }
                    else
                    {
                        [[self JsonFactory] getAreaList:r_city action:@"getAreaList"];
                    }
                }
                else
                {
                    [self alertOnly:@"请点击左边选择城市"];
                }
                
                break;
            }
            case 102://选择排序方式
            {
                //tabLine.frame = CGRectMake(WIDTH/3 *2, 42,WIDTH/3, 10);
                
                arr=[[NSArray alloc] initWithObjects:@"默认排序",@"距离最近",@"按总分排序", nil];
                
                [_drawerView openNavBarDrawer:3 Parameters:arr defaultValue:r_order];
                
                break;
            }
                
            default:
                break;
        }
        
        [UIView commitAnimations];
    
    }
}

/*
//按区域请求数据
-(void)reloadRequestData:(NSString *)city area:(NSString *)area type:(NSString *)type
{
    requestTimes=1;
    if (pageIndex==0)
    {
        [ToolLen ShowWaitingView:YES];
    }
    
    pageIndex++;
    [[self JsonFactory] get_getRepairStationList:[NSString stringWithFormat:@"%d",pageIndex] city:city area:area type:type lng:lng lat:lat action:@"getRepairStationList"];
    
}
 */


//按排序方式请求数据
-(void)reloadRequestOrderData:(NSString *)city area:(NSString *)area order:(NSString *)order1
{
    requestTimes=1;
    //pt=1;
    
    if (pageIndex==0)//如果是第一个页面，显示转子
    {
        [ToolLen ShowWaitingView:YES];
    }
    
    pageIndex++;
    
    //[self alertOnly:[NSString stringWithFormat:@"lat::%@ lng::%@",[AppDelegate setGlobal].currentLatitude,[AppDelegate setGlobal].currentLongitude]];
    
    //NSLog(@"lat::%@",lat);
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        //lat=[AppDelegate setGlobal].currentLatitude;
        //lng=[AppDelegate setGlobal].currentLongitude;
        
        //测试账户
        [[self JsonFactory] get_getRepairStationOrderList:[NSString stringWithFormat:@"%d",pageIndex] city:city area:area order:order1 lng:[AppDelegate setGlobal].currentLongitude lat:[AppDelegate setGlobal].currentLatitude  state:0 action:@"getStationListByOrder"];
    }
    else
    {
        //正式账户
        [[self JsonFactory] get_getRepairStationOrderList:[NSString stringWithFormat:@"%d",pageIndex] city:city area:area order:order1 lng:[AppDelegate setGlobal].currentLongitude lat:[AppDelegate setGlobal].currentLatitude  state:1  action:@"getStationListByOrder"];
        
    }
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        if (pageIndex==1 )//如果是第一页，初始化
        {
            addArray=[[NSMutableArray alloc]init];
        }
        
        [addArray addObjectsFromArray:[responseObject objectForKey:@"repairstationlist"]];
        
     
        [self performSelector:@selector(reloadDeals) withObject:nil];

    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==100)
    {
        //保存
        [document saveDataToDocument:@"ServiceCity" fileData:[responseObject objectForKey:@"citylist"]];
        //弹出视图
        [_drawerView openNavBarDrawer:1 Parameters:[responseObject objectForKey:@"citylist"] defaultValue:@""];
        
        [document deleteFileFromDocument:[NSString stringWithFormat:@"ServiceArea_%@",[[responseObject objectForKey:@"citylist"] objectAtIndex:0]]];

    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==101)
    {
        //保存
        [document saveDataToDocument:[NSString stringWithFormat:@"ServiceArea_%@",r_city] fileData:[responseObject objectForKey:@"arealist"]];
        //弹出视图
        [_drawerView openNavBarDrawer:2 Parameters:[responseObject objectForKey:@"arealist"] defaultValue:@""];
        
    }
    else if (responseObject && [[responseObject objectForKey:@""] intValue]==0 && requestTimes==102)
    {
        
    }
    
    
}


#pragma mark 刷新页面
- (void)reloadDeals
{
    
    [serviceTableView reloadData];
    
    // 结束刷新状态
    [_footer endRefreshing];
    if ([addArray count]==0)
    {
        [self alertOnly:@"暂无列表信息"];
    }
}

#pragma mark - ACNavBarDrawerDelegate
-(void)theBtnPressed:(NSString *)content sort:(int)sort
{
    pageIndex=0;
    
    for (UIView *subView in[tabView subviews])
    {
        if ([subView isKindOfClass:[UILabel class]])
        {
            UILabel *selectLabel = (UILabel *)[subView viewWithTag:subView.tag];
            if (subView.tag==sort+99)
            {
                selectLabel.text=content;
                if (sort==1)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:content forKey:@"ServiceProvice"];
                    r_city=content;
                    
                    //[self reloadRequestData:r_city area:r_area type:@""];
                    [self reloadRequestOrderData:r_city area:r_area order:order];
                }
                else if(sort==2)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:content forKey:@"ServiceArea"];
                    r_area=content;
                    //[self reloadRequestData:r_city area:r_area type:@""];
                    [self reloadRequestOrderData:r_city area:r_area order:order];
                    
                }
                else if(sort==3)
                {
                    [[NSUserDefaults standardUserDefaults] setObject:content forKey:@"ServiceOrder"];
                    r_order=content;
                    //顺序
                    if ([content isEqualToString:@"默认排序"])
                    {
                        order=@"";
                    }
                    else if ([content isEqualToString:@"按总分排序"])
                    {
                        order=@"avg_comment";
                    }
                    else if ([content isEqualToString:@"距离最近"])
                    {
                        order=@"juli";
                        
                    }
                    
                    [self reloadRequestOrderData:r_city area:r_area order:order];
                }
            }
        }
        
    }

}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   
    return [addArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    return 80;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    ServiceCell *cell=(ServiceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"ServiceCell" owner:self options:nil];
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
    
   // [cell.stationImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[addArray objectAtIndex:indexPath.row] objectForKey:@"half_img"]]] placeholderImage:nil];
    
    [cell.stationImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[addArray objectAtIndex:indexPath.row] objectForKey:@"half_img"]]] placeholderImage:nil];
    
    cell.stationNameLabel.text=[[addArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.stationDistanceLabel.text=[NSString stringWithFormat:@"%.1fKm",[[[addArray objectAtIndex:indexPath.row] objectForKey:@"juli"] floatValue]/1000];
    
    
    //好评率
    float temp=[[[addArray objectAtIndex:indexPath.row] objectForKey:@"avg_comment"] floatValue]*100.0+0.5;
    int m=temp/20;
    //NSLog(@"m::%d",m);
    for (int i=0; i<m; i++)
    {
        UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(110+16*i, 28, 20, 20)];
        starImageView.image=IMAGE(@"commet");
        [cell.contentView addSubview:starImageView];
    }
    
    cell.orderLabel.text=[NSString stringWithFormat:@"%d单",[[[addArray objectAtIndex:indexPath.row] objectForKey:@"orderCount"] intValue]];
    
    if ([[[addArray objectAtIndex:indexPath.row] objectForKey:@"have_pos"] intValue]==1)
    {
        //显示
        cell.stationFlag.hidden=NO;
        for (int i=0; i<4; i++)
        {
            UIImageView *iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(115+17*i,55, 15,15)];
            NSString *iconStr=[NSString stringWithFormat:@"station_%d",i+1];
            iconImageView.image=IMAGE(iconStr);
            [cell.contentView addSubview:iconImageView];
            
        }
    }
    else
    {
        //隐藏
        cell.stationFlag.hidden=YES;
    }
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    StationInfoViewController *stationInfo=[[StationInfoViewController alloc] init];
    stationInfo.hidesBottomBarWhenPushed=YES;
    stationInfo.title=@"维修站详情";
    stationInfo.orderArry=orderArray;
    stationInfo.stationInfo=[addArray objectAtIndex:indexPath.row];//店面信息
    [self.navigationController pushViewController:stationInfo animated:YES];
     */
    
    New_StationInfoViewController *station=[[New_StationInfoViewController alloc] init];
    station.hidesBottomBarWhenPushed=YES;
    station.title=@"维修站详情";
    station.stationInfo=[addArray objectAtIndex:indexPath.row];//店面信息
    
    [self.navigationController pushViewController:station animated:YES];
    
    
}



//上拉更新加载更多数据
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer)//上拉刷新
    {
        if (searchBool)
        {
            [self search_search];
        }
        else
        {
            [self reloadRequestOrderData:r_city area:r_area order:order];
        }
      
    }
}


@end
