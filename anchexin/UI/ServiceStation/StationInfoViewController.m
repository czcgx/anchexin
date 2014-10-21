//
//  StationInfoViewController.m
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "StationInfoViewController.h"

@interface StationInfoViewController ()

@end

@implementation StationInfoViewController
@synthesize stationInfo;
@synthesize orderArry;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}


//待办服务
-(void)tabContent_1
{
    
    [tabContentView_1 removeFromSuperview];
    
    tabContentView_1=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, tabContentView.frame.size.height)];
    tabContentView_1.backgroundColor=[UIColor clearColor];
    
    //预约
    UIView *orderView=[[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH, 50)];
    orderView.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    
    UIView *buttonView=[[UIView alloc] initWithFrame:CGRectMake(85, 5, 150, 40)];
    buttonView.backgroundColor=[UIColor clearColor];
    buttonView.layer.cornerRadius = 5;//(值越大，角就越圆)
    buttonView.layer.masksToBounds = YES;
    buttonView.layer.borderWidth=1.0;
    buttonView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
   
    if ([[stationInfo objectForKey:@"have_pos"] intValue]==1)
    {
        
        [buttonView addSubview:[self customImageView:CGRectMake(30, 8, 24, 24) image:IMAGE(@"orderhealth")]];
        [buttonView addSubview:[self customLabel:CGRectMake(60,10, 80, 20) color:[UIColor darkGrayColor] text:@"现在预约" alignment:-1 font:16.0]];
        [buttonView addSubview:[self customButton:buttonView.bounds tag:11 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    }
    else
    {
        [buttonView addSubview:[self customImageView:CGRectMake(30, 8, 24, 24) image:IMAGE(@"orderhealth2")]];
        [buttonView addSubview:[self customLabel:CGRectMake(60,10, 80, 20) color:[UIColor lightGrayColor] text:@"现在预约" alignment:-1 font:16.0]];
        [buttonView addSubview:[self customButton:buttonView.bounds tag:11 title:nil state:0 image:nil selectImage:nil color:nil enable:NO]];
        
    }
    
    [orderView addSubview:buttonView];
    
    [tabContentView_1 addSubview:orderView];
    
    [tabContentView addSubview:tabContentView_1];
    
    /*
    shopTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, tabContentView_1.frame.size.height-50)];
    shopTableView.tag=1;
    shopTableView.delegate=self;
    shopTableView.dataSource=self;
    shopTableView.backgroundView=nil;
    shopTableView.backgroundColor=[UIColor clearColor];
    shopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [tabContentView_1 addSubview:shopTableView];
    */
    
    
    
    
}


//保养卡
-(void)tabContent_2
{
    [tabContentView_2 removeFromSuperview];

    tabContentView_2=[[UIView alloc] initWithFrame:CGRectMake(WIDTH, 0, WIDTH, tabContentView.frame.size.height)];
    tabContentView_2.backgroundColor=[UIColor clearColor];
    
    //预约
    UIView *orderView=[[UIView alloc] initWithFrame:CGRectMake(0,0, WIDTH, 50)];
    orderView.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [orderView addSubview:[self customLabel:CGRectMake(10, 15, 190, 20) color:[UIColor darkGrayColor] text:@"到过该门店,我也想点评一下!请..." alignment:-1 font:13.0]];
    
    UIView *buttonView=[[UIView alloc] initWithFrame:CGRectMake(210, 10, 100, 30)];
    buttonView.backgroundColor=[UIColor clearColor];
    buttonView.layer.cornerRadius = 5;//(值越大，角就越圆)
    buttonView.layer.masksToBounds = YES;
    buttonView.layer.borderWidth=1.0;
    buttonView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [buttonView addSubview:[self customImageView:CGRectMake(5, 3, 24, 24) image:IMAGE(@"comment")]];
    [buttonView addSubview:[self customLabel:CGRectMake(30,5, 80, 20) color:[UIColor darkGrayColor] text:@"发表评论" alignment:-1 font:16.0]];
    [buttonView addSubview:[self customButton:buttonView.bounds tag:12 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [orderView addSubview:buttonView];
    
    [tabContentView_2 addSubview:orderView];
    
    [tabContentView addSubview:tabContentView_2];

}

//刷新评论
-(void)refreshDisscuss
{
    page=0;
    [commentList removeAllObjects];
    [self comment];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshDisscuss) name:@"refreshDisscuss" object:nil];
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
   
    shopTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height-50)];
    shopTableView.tag=1;
    shopTableView.delegate=self;
    shopTableView.dataSource=self;
    shopTableView.backgroundView=nil;
    shopTableView.backgroundColor=[UIColor clearColor];
    shopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    shopTableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    [mainView addSubview:shopTableView];

    //第三方控件，进行下拉刷新
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = shopTableView;
    _footer.hidden=YES;
    //店铺信息
    UIView *sub1View=[[UIView alloc] initWithFrame:CGRectMake(0, -180, WIDTH, 130)];
    sub1View.backgroundColor=[UIColor clearColor];
    
    //店铺名称
    [sub1View addSubview:[self customLabel:CGRectMake(10, 10, 300, 20) color:[UIColor blackColor] text:[stationInfo objectForKey:@"name"] alignment:-1 font:16.0]];
    
    //图片
    UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(10, 35, 120, 80)];
    [img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[stationInfo objectForKey:@"half_img"]]] placeholderImage:nil];
    [sub1View addSubview:img];
    UILabel *imgbg=[[UILabel alloc] initWithFrame:CGRectMake(90, 95, 40, 20)];
    imgbg.backgroundColor=[UIColor blackColor];
    imgbg.alpha=0.7;
    [sub1View addSubview:imgbg];
    [sub1View addSubview:[self customLabel:CGRectMake(90, 95, 40, 20) color:[UIColor whiteColor] text:[NSString stringWithFormat:@"%d 张",[[stationInfo objectForKey:@"imgcount"]intValue]] alignment:0 font:13.0]];
    [sub1View addSubview:[self customButton:img.frame tag:2 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    //扳手的个数
    float temp=[[stationInfo objectForKey:@"avg_comment"] floatValue]*100.0+0.5;
    int m=temp/20;
    //NSLog(@"m::%d",m);
    for (int i=0; i<m; i++)
    {
        UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(140+16*i, 35, 20, 20)];
        starImageView.image=IMAGE(@"commet");
        [sub1View addSubview:starImageView];
    }
    
    //显示电话图标
    [sub1View addSubview:[self customImageView:CGRectMake(140, 60, 20, 20) image:IMAGE(@"info_phone")]];
    [sub1View addSubview:[self customLabel:CGRectMake(160, 60, 140, 20) color:[UIColor blackColor] text:[stationInfo objectForKey:@"phone"] alignment:-1 font:13.0]];
    [sub1View addSubview:[self customButton:CGRectMake(140, 55, 140, 30) tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    //显示地址
    [sub1View addSubview:[self customImageView:CGRectMake(140, 80, 20, 20) image:IMAGE(@"info_location")]];
    UILabel *lbl=nil;
    if ([[stationInfo objectForKey:@"address"] length]>10)
    {
        lbl=[self customLabel:CGRectMake(160, 80, 140, 40) color:[UIColor blackColor] text:[stationInfo objectForKey:@"address"] alignment:-1 font:13.0];
        [lbl setLineBreakMode:NSLineBreakByCharWrapping];
        [lbl setNumberOfLines:0];
    }
    else if([[stationInfo objectForKey:@"address"] length]>20)
    {
        lbl=[self customLabel:CGRectMake(160, 80, 140, 60) color:[UIColor blackColor] text:[stationInfo objectForKey:@"address"] alignment:-1 font:13.0];
        [lbl setLineBreakMode:NSLineBreakByCharWrapping];
        [lbl setNumberOfLines:0];
    }
    else
    {
        lbl=[self customLabel:CGRectMake(160, 80, 140, 20) color:[UIColor blackColor] text:[stationInfo objectForKey:@"address"] alignment:-1 font:13.0];
    }
    [sub1View addSubview:lbl];
    [shopTableView addSubview:sub1View];
 
    //tab
    tabView=[[UIView alloc] initWithFrame:CGRectMake(0, -50, WIDTH, 50)];
    tabView.backgroundColor=[UIColor clearColor];
    [tabView addSubview:[self customImageView:tabView.bounds image:IMAGE(@"rootbg")]];
    UILabel *label1=[[UILabel alloc] initWithFrame:CGRectMake(160, 10, 1, 30)];
    label1.backgroundColor=[UIColor whiteColor];
    [tabView addSubview:label1];
    
    NSArray *tabArray=[NSArray arrayWithObjects:@"门店详情",@"顾客评价", nil];
    for (int i=0; i<tabArray.count; i++)
    {
        UILabel *label=[[UILabel alloc] initWithFrame:CGRectMake(160*i, 10, 160, 30)];
        label.backgroundColor=[UIColor clearColor];
        label.font=[UIFont systemFontOfSize:16.0];
        label.text=[tabArray objectAtIndex:i];
        label.tag=i+100;
        if (i==0)
        {
            label.textColor=[UIColor yellowColor];
        }
        else
        {
            label.textColor=[UIColor whiteColor];
            
        }
        label.textAlignment=NSTextAlignmentCenter;
        [tabView addSubview:label];
        
        [tabView addSubview:[self customButton:label.frame tag:i+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    }
    
    //指示图标
    tabLine=[[UIView alloc] initWithFrame:CGRectMake(0, 40, 160, 10)];
    tabLine.backgroundColor=[UIColor clearColor];
    [tabLine addSubview:[self customImageView:CGRectMake(73, 0, 15, 10) image:IMAGE(@"sanjiao")]];
    [tabView addSubview:tabLine];
    [shopTableView addSubview:tabView];
    
    
    [ToolLen ShowWaitingView:YES];
    requestTimes=1;
    [[self JsonFactory] getNewServiceListByStation:[stationInfo objectForKey:@"repairstationid"] action:@"getNewServiceListByStation"];
    
    tabContentView=[[UIView alloc] initWithFrame:CGRectMake(0, mainView.frame.size.height-50, WIDTH*2, 50)];
    tabContentView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    [self tabContent_1];//@"门店详情",
    [self tabContent_2];//@"顾客评价",
    
    
    [mainView addSubview:tabContentView];
    [self.view addSubview:mainView];
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        receiveDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        
        shopMutableArray=[[NSMutableArray alloc] init];
        for (int i=0; i<5+[[receiveDic objectForKey:@"serviceList"]count]; i++)
        {
            [shopMutableArray addObject:@"0"];
        }
        
        [shopTableView reloadData];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        
        [commentList addObjectsFromArray:[NSArray arrayWithArray:[responseObject objectForKey:@"repairstationcommentlist"] ]];
        
        //NSLog(@"commentList::%@",commentList);
        [shopTableView reloadData];
        // 结束刷新状态
        [_footer endRefreshing];
    }
}
-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)//拨打电话
    {
       // NSLog(@"拨打电话");
        /*
        NSString *phoneNumber=[stationInfo objectForKey:@"phone"];
        NSURL *phoneUrl=[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
        [[UIApplication sharedApplication] openURL:phoneUrl];
        */
        
        UIWebView*callWebview =[[UIWebView alloc] init] ;
        NSString *phoneNumber=[stationInfo objectForKey:@"phone"];
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebview];
        
        
    }
    else if (sender.tag==2)
    {
        //点击图片
        StationImgViewController *img=[[StationImgViewController alloc] init];
        img.title=@"图片展示";
        img.stationId=[stationInfo objectForKey:@"repairstationid"];
        [self.navigationController pushViewController:img animated:YES];
       
    }
    else if (sender.tag==11)
    {
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            OrderViewController *order=[[OrderViewController alloc] init];
            order.title=@"填写预约单";
            
            if (orderArry.count>0)
            {
                order.orderArray=orderArry;
            }
            order.stationId=[stationInfo objectForKey:@"repairstationid"];
            [self.navigationController pushViewController:order animated:YES];
        }
    
    }
    else if (sender.tag==12)
    {
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            DisscussViewController *diss=[[DisscussViewController alloc]init];
            diss.title=@"发表评论";
            diss.stationId=[stationInfo objectForKey:@"repairstationid"];
            [self.navigationController pushViewController:diss animated:YES];
            
        }
    }
    else if(sender.tag>99)
    {
       // NSLog(@"代办服务");
        for (UIView *subView in[tabView subviews])
        {
            if ([subView isKindOfClass:[UILabel class]])
            {
                UILabel *selectLabel = (UILabel *)[subView viewWithTag:subView.tag];
                if (subView.tag==sender.tag)
                {
                    selectLabel.textColor=[UIColor yellowColor];
                }
                else
                {
                    selectLabel.textColor=[UIColor whiteColor];
                }
            }
        }
        
        [UIView beginAnimations:nil context:nil];//动画开始
        [UIView setAnimationDuration:0.3];
        
        switch (sender.tag)
        {
            case 100:
            {
                tabLine.frame = CGRectMake(0, 40, 160, 10);
                
                tabContentView_1.frame=CGRectMake(0, 0, WIDTH,tabContentView.frame.size.height);
                tabContentView_2.frame=CGRectMake(WIDTH, 0, WIDTH, tabContentView.frame.size.height);
               
                _footer.hidden=YES;
                tabContentView_1.hidden=NO;
                tabContentView_2.hidden=YES;
                
                break;
            }
            case 101:
            {
                tabLine.frame = CGRectMake(160, 40, 160, 10);
                
                tabContentView_1.frame=CGRectMake(-WIDTH, 0, WIDTH, tabContentView.frame.size.height);
                tabContentView_2.frame=CGRectMake(0, 0, WIDTH, tabContentView.frame.size.height);
                _footer.hidden=NO;
                tabContentView_1.hidden=YES;
                tabContentView_2.hidden=NO;
               
                break;
            }
                
            default:
                break;
        }
        
        [UIView commitAnimations];
        
        
        switch (sender.tag)
        {
            case 100:
            {
                [ToolLen ShowWaitingView:YES];
                requestTimes=1;
                [[self JsonFactory] getNewServiceListByStation:[stationInfo objectForKey:@"repairstationid"] action:@"getNewServiceListByStation"];
                
                break;
            }
            case 101:
            {
                [ToolLen ShowWaitingView:YES];
                requestTimes=2;
                page=0;
                commentList=[[NSMutableArray alloc] init];
                
                [self comment];
                
                break;
            }
                
            default:
                break;
        }
    }
    
}

//上拉更新加载更多数据
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer)//上拉刷新
    {
        [self comment];
        
    }
}


-(void)comment
{
    page++;
    [[self JsonFactory] get_getRepairStationCommentList:[stationInfo objectForKey:@"repairstationid"] currentpage:[NSString stringWithFormat:@"%d",page] action:@"getRepairStationCommentList"];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    if (requestTimes==1)
    {
        return [shopMutableArray count];
    }
    else
    {
        return [commentList count];
    }
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (requestTimes==1)
    {
        if ([[shopMutableArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            return 60.0;
        }
        else
        {
            if (indexPath.row==0)
            {
                //动态返回信息高度
                NSString *LabelString=[NSString stringWithFormat:@"%@",[receiveDic objectForKey:@"description"]];
                CGSize constraint = CGSizeMake(280.0f, 20000.0f);//自己设置的要显示的长度
                CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat height = MAX(size.height, 30.0f);//返回最大高度
                
                return 60+height+20;
                
            }
            else if (indexPath.row==1)
            {
                return  [[receiveDic objectForKey:@"toolList"] count]*40+60;
            }
            else
            {
                /*
                //动态返回信息高度
                NSString *LabelString=[NSString stringWithFormat:@"%@",[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-4]  objectForKey:@"part"]];
                CGSize constraint = CGSizeMake(280.0f, 20000.0f);//自己设置的要显示的长度
                CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat height = MAX(size.height, 30.0f);//返回最大高度
                
                return 60+height+10;
                */
                
                NSInteger n=[[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-5]objectForKey:@"partList"] count];
                
                return  n*100+60;
            }
        }
    }
    else
    {
        return 60.0;
    }
  
    return 0;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if(requestTimes==1)
    {
        static NSString *cellIndefiner=@"cellIndefiner2";
        MaintenanceCell *cell=(MaintenanceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MaintenanceCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        //显示前4个图片
        if (indexPath.row<5)
        {
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(150, 25, 80, 10)];
            if (indexPath.row==0)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"技术水平"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"technologyComment"]];
                if ([[receiveDic objectForKey:@"technologyComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"technologyComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
            }
            else if (indexPath.row==1)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"硬件设备"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"hardComment"]];
                if ([[receiveDic objectForKey:@"hardComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"hardComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
                
            }
            else if (indexPath.row==2)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"门店环境"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"envinmentComment"]];
                if ([[receiveDic objectForKey:@"envinmentComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"envinmentComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
            }
            else if (indexPath.row==3)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"服务质量"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"serviceComment"]];
                if ([[receiveDic objectForKey:@"serviceComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"serviceComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
            }
            else if (indexPath.row==4)
            {
                cell.upView.backgroundColor=[UIColor lightGrayColor];
                cell.maintenanceMonth.font=[UIFont systemFontOfSize:15.0];
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"服务套餐"];
                cell.maintenanceMonth.hidden=YES;
            }
            
            [cell.contentView addSubview:img];

        }
        else
        {
            cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-5] objectForKey:@"name"]];
            cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@ %@",[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-5] objectForKey:@"price"],[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-5] objectForKey:@"unit"]];
            
        }
        
        if (indexPath.row==2 || indexPath.row==3 || indexPath.row==4)
        {
            cell.upImageView.hidden=YES;
            cell.upButton.hidden=YES;
            
        }
        else
        {
            cell.upButton.tag=indexPath.row+1;
            [cell.upButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        
        if (indexPath.row>4)
        {
            NSArray *temp=[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-5]objectForKey:@"partList"];
            if (temp.count==0)
            {
                cell.upImageView.hidden=YES;
                cell.upButton.hidden=YES;
                
            }
            else
            {
                cell.upButton.tag=indexPath.row+1;
                [cell.upButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
                
            }
        }
        
        UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
        showLineLabel.backgroundColor=[UIColor lightGrayColor];
        [cell.contentView addSubview:showLineLabel];
        
        if ([[shopMutableArray objectAtIndex:indexPath.row]isEqualToString:@"0"])
        {
            cell.downView.hidden=YES;
            cell.upImageView.image=IMAGE(@"pulldown");
            showLineLabel.hidden=NO;
        }
        else
        {
            cell.downView.hidden=NO;
            cell.upImageView.image=IMAGE(@"pullup");
            showLineLabel.hidden=YES;
            
            if (indexPath.row==0)
            {
                NSString *LabelString=[NSString stringWithFormat:@"%@",[receiveDic objectForKey:@"description"]];
                CGSize constraint = CGSizeMake(280.0, 20000.0f);
                CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat height = MAX(size.height, 30.0f);
                //NSLog(@"height::%f",height);
                
                
                UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, height+10)];
                [desLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
                [desLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
                [desLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
                [desLabel setTag:indexPath.row];
                desLabel.text=LabelString;
                
                cell.downView.frame=CGRectMake(0, 60,WIDTH, desLabel.frame.size.height+20);
                [cell.downView addSubview:desLabel];
                
            }
            else if (indexPath.row==1)
            {
                cell.downView.frame=CGRectMake(0, 60,WIDTH, [[receiveDic objectForKey:@"toolList"] count]*40);
                
                for (int i=0; i<[[receiveDic objectForKey:@"toolList"] count]; i++)
                {
                    UILabel *keyLabel=[[UILabel alloc] initWithFrame:CGRectMake(22, 10+40*i, 180,20)];
                    keyLabel.backgroundColor=[UIColor clearColor];
                    keyLabel.font=[UIFont systemFontOfSize:13.0];
                    keyLabel.textColor=[UIColor darkGrayColor];
                    keyLabel.textAlignment=NSTextAlignmentLeft;
                    keyLabel.text=[[[receiveDic objectForKey:@"toolList"] objectAtIndex:i] objectForKey:@"name"];
                    [cell.downView addSubview:keyLabel];
                    
                    
                    //判断是什么状态
                    UIImageView *flagimg=[[UIImageView alloc] initWithFrame:CGRectMake(270, 8.5+40*i, 20, 20)];
                    //flagimg.image=IMAGE(@"finish");
                    
                    if ([[[[receiveDic objectForKey:@"toolList"] objectAtIndex:i] objectForKey:@"isChecked"] intValue]==0)
                    {
                        flagimg.image=IMAGE(@"check_0");
                    }
                    else
                    {
                        flagimg.image=IMAGE(@"check_1");
                    }
                    
                    
                    [cell.downView addSubview:flagimg];
                    
                    UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 39.5+40*i, WIDTH-40, 0.5)];
                    lineLabel.backgroundColor=[UIColor lightGrayColor];
                    [cell.downView addSubview:lineLabel];
                    
                }
            }
            else
            {
                /*
                NSString *LabelString=[NSString stringWithFormat:@"%@",[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-4]  objectForKey:@"part"]];
                
                CGSize constraint = CGSizeMake(280.0, 20000.0f);
                CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat height = MAX(size.height, 30.0f);
                //NSLog(@"height::%f",height);
                
                
                UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, height+5)];
                [desLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
                [desLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
                [desLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
                [desLabel setTag:indexPath.row];
                desLabel.text=LabelString;
                */
                
                NSArray *temp=[[[receiveDic objectForKey:@"serviceList"] objectAtIndex:indexPath.row-5]objectForKey:@"partList"];
                NSInteger n=[temp count];
                
                cell.downView.frame=CGRectMake(0, 60,WIDTH,100*n);
                
                for (int i=0; i<n; i++)
                {
                    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, i*100, WIDTH, 100)];
                    subView.backgroundColor=[UIColor clearColor];
                    
                    UIImageView *cusImg=[self customImageView:CGRectMake(20, 10, 100, 60) image:nil];
                    [cusImg setImageWithURL:[NSURL URLWithString:[[temp objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
                    //[cusImg setImage:[UIImage imageNamed:@"huang.jpg"]];
                    [subView addSubview:cusImg];
                    
                    UILabel *nameLabel=[self customLabel:CGRectMake(20, 75, 100, 20) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"name"] alignment:0 font:14.0];
                    nameLabel.numberOfLines=0;
                    [subView addSubview:nameLabel];
                    
                    
                    UILabel *des1Label=[self customLabel:CGRectMake(130, 10, 150, 20) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"brand"] alignment:-1 font:13.0];
                    des1Label.numberOfLines=1;
                    [subView addSubview:des1Label];
                    
                    UILabel *des2Label=[self customLabel:CGRectMake(130, 30, 150, 20) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"descriptionPart01"] alignment:-1 font:13.0];
                    des2Label.numberOfLines=1;
                    [subView addSubview:des2Label];
                    
                    UILabel *des3Label=[self customLabel:CGRectMake(130, 50, 150, 40) color:[UIColor darkGrayColor] text:[[temp objectAtIndex:i] objectForKey:@"descriptionPart02"] alignment:-1 font:13.0];
                    des3Label.numberOfLines=2;
                    [subView addSubview:des3Label];
                    
                    UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 99.5, WIDTH-40, 0.5)];
                    lineLabel.backgroundColor=[UIColor lightGrayColor];
                    [subView addSubview:lineLabel];
                    
                    if (i==n-1)
                    {
                        lineLabel.hidden=YES;
                    }
                    else
                    {
                        lineLabel.hidden=NO;
                    }
                
                    [cell.downView addSubview:subView];
                }
            }
        }
        
        
        return cell;
        
/*
        if (indexPath.section==0)
        {
            static NSString *cellIndefiner=@"cellIndefiner2";
            MaintenanceCell *cell=(MaintenanceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MaintenanceCell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            if (indexPath.row<2)
            {
                cell.upButton.tag=indexPath.row+1;
                [cell.upButton addTarget:self action:@selector(touch:) forControlEvents:UIControlEventTouchUpInside];
            }
            else
            {
                cell.upImageView.hidden=YES;
                cell.upButton.hidden=YES;
            }
            
            
            UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
            showLineLabel.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:showLineLabel];
            
            if ([[shopMutableArray objectAtIndex:indexPath.row]isEqualToString:@"0"])
            {
                cell.downView.hidden=YES;
                cell.upImageView.image=IMAGE(@"pulldown");
                showLineLabel.hidden=NO;
            }
            else
            {
                cell.downView.hidden=NO;
                cell.upImageView.image=IMAGE(@"pullup");
                showLineLabel.hidden=YES;
                
                if (indexPath.row==0)
                {
                    NSString *LabelString=[NSString stringWithFormat:@"%@",[receiveDic objectForKey:@"description"]];
                    CGSize constraint = CGSizeMake(280.0, 20000.0f);
                    CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                    CGFloat height = MAX(size.height, 30.0f);
                    //NSLog(@"height::%f",height);
                    
                    
                    UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, height+10)];
                    [desLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
                    [desLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
                    [desLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
                    [desLabel setTag:indexPath.row];
                    desLabel.text=LabelString;
                    
                    cell.downView.frame=CGRectMake(0, 60,WIDTH, desLabel.frame.size.height+20);
                    [cell.downView addSubview:desLabel];
                    
                }
                else if (indexPath.row==1)
                {
                    cell.downView.frame=CGRectMake(0, 60,WIDTH, [[receiveDic objectForKey:@"toolList"] count]*40);
                    
                    for (int i=0; i<[[receiveDic objectForKey:@"toolList"] count]; i++)
                    {
                        UILabel *keyLabel=[[UILabel alloc] initWithFrame:CGRectMake(22, 10+40*i, 180,20)];
                        keyLabel.backgroundColor=[UIColor clearColor];
                        keyLabel.font=[UIFont systemFontOfSize:13.0];
                        keyLabel.textColor=[UIColor darkGrayColor];
                        keyLabel.textAlignment=NSTextAlignmentLeft;
                        keyLabel.text=[[[receiveDic objectForKey:@"toolList"] objectAtIndex:i] objectForKey:@"name"];
                        [cell.downView addSubview:keyLabel];
                        
                        
                        //判断是什么状态
                        UIImageView *flagimg=[[UIImageView alloc] initWithFrame:CGRectMake(270, 8.5+40*i, 20, 20)];
                        //flagimg.image=IMAGE(@"finish");
                        
                         if ([[[[receiveDic objectForKey:@"toolList"] objectAtIndex:i] objectForKey:@"isChecked"] intValue]==0)
                         {
                             flagimg.image=IMAGE(@"check_0");
                         }
                         else
                         {
                             flagimg.image=IMAGE(@"check_1");
                         }
                        
                        
                        [cell.downView addSubview:flagimg];
                        
                        UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 39.5+40*i, WIDTH-40, 0.5)];
                        lineLabel.backgroundColor=[UIColor lightGrayColor];
                        [cell.downView addSubview:lineLabel];
                        
                    }
                }
                else
                {
                    
                }
            }
            
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(150, 25, 80, 10)];
            if (indexPath.row==0)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"技术水平"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"technologyComment"]];
                if ([[receiveDic objectForKey:@"technologyComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"technologyComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
            }
            else if (indexPath.row==1)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"硬件质量"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"hardComment"]];
                if ([[receiveDic objectForKey:@"hardComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"hardComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
                
            }
            else if (indexPath.row==2)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"门店环境"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"envinmentComment"]];
                if ([[receiveDic objectForKey:@"envinmentComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"envinmentComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
            }
            else if (indexPath.row==3)
            {
                cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",@"服务质量"];
                cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"serviceComment"]];
                if ([[receiveDic objectForKey:@"serviceComment"] intValue]<=40)
                {
                    img.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"serviceComment"] intValue]<=70)
                {
                    img.image=IMAGE(@"station2");
                }
                else
                {
                    img.image=IMAGE(@"station1");
                }
            }
            
            [cell.contentView addSubview:img];
            
            return cell;

        }
        else if (indexPath.section==1)
        {
            static NSString *cellIndefiner=@"cellIndefiner3";
            MaintenanceCell *cell=(MaintenanceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MaintenanceCell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",[[content1Array objectAtIndex:indexPath.row] objectForKey:@"name"]];
            cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@ %@",[[content1Array objectAtIndex:indexPath.row]objectForKey:@"price"],[[content1Array objectAtIndex:indexPath.row]objectForKey:@"unit"]];
            
            cell.upButton.tag=indexPath.row+1;
            [cell.upButton addTarget:self action:@selector(touch1:) forControlEvents:UIControlEventTouchUpInside];
           
            
            UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
            showLineLabel.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:showLineLabel];
            
            if ([[taocan1Array objectAtIndex:indexPath.row]isEqualToString:@"0"])
            {
                cell.downView.hidden=YES;
                cell.upImageView.image=IMAGE(@"pulldown");
                showLineLabel.hidden=NO;
            }
            else
            {
                cell.downView.hidden=NO;
                cell.upImageView.image=IMAGE(@"pullup");
                showLineLabel.hidden=YES;
                NSString *LabelString=[NSString stringWithFormat:@"%@",[[content1Array objectAtIndex:indexPath.row] objectForKey:@"part"]];
                CGSize constraint = CGSizeMake(280.0, 20000.0f);
                CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat height = MAX(size.height, 30.0f);
                //NSLog(@"height::%f",height);
                
                
                UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, height+5)];
                [desLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
                [desLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
                [desLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
                [desLabel setTag:indexPath.row];
                desLabel.text=LabelString;
                
                cell.downView.frame=CGRectMake(0, 60,WIDTH, desLabel.frame.size.height+20);
                [cell.downView addSubview:desLabel];
            }
                
            return cell;
        }
        else
        {
            NSString *cellIndefiner=@"cellIndefiner4";
            MaintenanceCell *cell=(MaintenanceCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"MaintenanceCell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            cell.maintenanceTitle.text=[NSString stringWithFormat:@"%@",[[content2Array objectAtIndex:indexPath.row] objectForKey:@"name"]];
            cell.maintenanceMonth.text=[NSString stringWithFormat:@"%@ %@",[[content2Array objectAtIndex:indexPath.row]objectForKey:@"price"],[[content2Array objectAtIndex:indexPath.row]objectForKey:@"unit"]];
            cell.upButton.tag=indexPath.row+1;
            [cell.upButton addTarget:self action:@selector(touch2:) forControlEvents:UIControlEventTouchUpInside];
            
            
            UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59.5, WIDTH, 0.5)];
            showLineLabel.backgroundColor=[UIColor lightGrayColor];
            [cell.contentView addSubview:showLineLabel];
            
            if ([[taocan2Array objectAtIndex:indexPath.row]isEqualToString:@"0"])
            {
                cell.downView.hidden=YES;
                cell.upImageView.image=IMAGE(@"pulldown");
                showLineLabel.hidden=NO;
            }
            else
            {
                cell.downView.hidden=NO;
                cell.upImageView.image=IMAGE(@"pullup");
                showLineLabel.hidden=YES;
                NSString *LabelString=[NSString stringWithFormat:@"%@",[[content2Array objectAtIndex:indexPath.row] objectForKey:@"part"]];
                
                CGSize constraint = CGSizeMake(280.0, 20000.0f);
                CGSize size = [LabelString sizeWithFont:[UIFont systemFontOfSize:15.0] constrainedToSize:constraint lineBreakMode:NSLineBreakByWordWrapping];
                CGFloat height = MAX(size.height, 30.0f);
                //NSLog(@"height::%f",height);
                
                
                UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 5, 280, height+5)];
                [desLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
                [desLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
                [desLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
                [desLabel setTag:indexPath.row];
                desLabel.text=LabelString;
                
                cell.downView.frame=CGRectMake(0, 60,WIDTH, desLabel.frame.size.height+20);
                [cell.downView addSubview:desLabel];
            }
            
            return cell;
        }
 */
        

    }
    else
    {
        
        static NSString *cellIndefiner=@"cellIndefiner3";
        CommentCell *cell=(CommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil];
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
        [cell.img setImageWithURL:[NSURL URLWithString:[[commentList objectAtIndex:indexPath.row] objectForKey:@"image"] ] placeholderImage:nil];
        
        int m=[[[commentList objectAtIndex:indexPath.row] objectForKey:@"satisfaction"] intValue];
       // NSLog(@"m::%d",m);
        for (int i=0; i<m; i++)
        {
            UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(60+16*i, 10, 20, 20)];
            starImageView.image=IMAGE(@"commet");
            [cell.contentView addSubview:starImageView];
        }
        
        cell.commentLabel.text=[NSString stringWithFormat:@"评论:%@",[[commentList objectAtIndex:indexPath.row] objectForKey:@"content"]];
        
        return cell;
        
    }
    
    
    
    return nil;
    
}


-(void)touch:(UIButton *)sender
{
    NSInteger place=[sender tag]-1;   //button 的tag值是cell的哪一行
    NSIndexPath *ip = [NSIndexPath indexPathForRow:place inSection:0];
    
    if ([[shopMutableArray objectAtIndex:place]isEqualToString:@"0"])
    {
        [shopMutableArray removeObjectAtIndex:place];          //如果点击某一行，则把当前行的0删除
        [shopMutableArray insertObject:@"1" atIndex:place];    //在当前行增加1
    }
    else
    {
        [shopMutableArray removeObjectAtIndex:place];         //如果点击某一行，则把当前行的0删除
        [shopMutableArray insertObject:@"0" atIndex:place];   //在当前行增加1
    }
    
    [shopTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:ip] withRowAnimation:UITableViewRowAnimationAutomatic];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
