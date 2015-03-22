//
//  ActivityListViewController.m
//  anchexin
//
//  Created by cgx on 14-12-12.
//
//

#import "ActivityListViewController.h"

#define CELLHeight 80

@interface ActivityListViewController ()

@end

@implementation ActivityListViewController
@synthesize type;
@synthesize searchString;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
  
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
    
    activityListTableView=[[UITableView alloc] initWithFrame:mainView.bounds];
    activityListTableView.backgroundColor=[UIColor clearColor];
    activityListTableView.backgroundView=nil;
    activityListTableView.delegate=self;
    activityListTableView.dataSource=self;
    activityListTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //[activityTableView setContentInset:UIEdgeInsetsMake(340 , 0, 0, 0)];
    [mainView addSubview:activityListTableView];

    //第三方控件，进行下拉刷新
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = activityListTableView;
    
    [self.view addSubview:mainView];
    
    activityArray=[[NSMutableArray alloc] initWithCapacity:0];
    pageIndex=0;
    
    if (type==1)//获取已领取的优惠券列表
    {
        [ToolLen ShowWaitingView:YES];
        
        [[self JsonFactory] getActivityListHaveReceived:@"0" pageSize:@"20" action:@"getActivityListHaveReceived"];
        
    }
    else if(type==2)//模糊列表
    {
        [ToolLen ShowWaitingView:YES];
        
        [[self JsonFactory] searchActivityList:@"0" pageSize:@"20" title:searchString action:@"searchActivityList"];
        
    }
    else if(type==3)//tag列表
    {
        
        countFlagArray=[[NSMutableArray alloc] initWithCapacity:0];
        [ToolLen ShowWaitingView:YES];
        //[[self JsonFactory] searchActivityList:@"0" pageSize:@"20" title:searchString action:@"searchActivityList"];
        
        //lat=[AppDelegate setGlobal].currentLatitude;
        //lng=[AppDelegate setGlobal].currentLongitude;
        
        [[self JsonFactory] getActivityListByTag:@"0" pageSize:@"20" tag:searchString lng:[AppDelegate setGlobal].currentLongitude lat:[AppDelegate setGlobal].currentLatitude action:@"getActivityListByTag"];
        
        /*
        //countArray中的数字表示产品的个数
        countArray=[[NSArray alloc] initWithObjects:@"1",@"3",@"4",@"2", nil];
        countFlagArray=[[NSMutableArray alloc] initWithCapacity:0];
        for (int i=0; i<countArray.count; i++)
        {
            if ([[countArray objectAtIndex:i] intValue]>2)
            {
                [countFlagArray addObject:@"0"];
            }
            else
            {
                [countFlagArray addObject:@"1"];
            }
        }

        [activityListTableView reloadData];
        */
        
    }
    else if(type==4)//维修详情列表
    {
        [[self JsonFactory] getActivityListByStation:@"0" pageSize:@"20" station:searchString action:@"getActivityListByStation"];
    }
        
}


//上拉更新加载更多数据
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer)//上拉刷新
    {
        [self refreshActivity];//刷新活动
    }
}


-(void)refreshActivity
{
    pageIndex++;
    
    if (type==1)//获取已领取的优惠券列表
    {
        [[self JsonFactory] getActivityListHaveReceived:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20" action:@"getActivityListHaveReceived"];
        
    }
    else if(type==2)//模糊列表
    {
        [[self JsonFactory] searchActivityList:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20" title:searchString action:@"searchActivityList"];
        
    }
    else if(type==3)//tag列表
    {
    
        [[self JsonFactory] getActivityListByTag:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20" tag:searchString lng:[AppDelegate setGlobal].currentLongitude lat:[AppDelegate setGlobal].currentLatitude action:@"getActivityListByTag"];
    }
    else if(type==4)//维修详情列表
    {
        [[self JsonFactory] getActivityListByStation:@"0" pageSize:@"20" station:searchString action:@"getActivityListByStation"];
    }
    
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    // 结束刷新状态
    [_footer endRefreshing];
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && type==1)
    {
        [activityArray addObjectsFromArray:[responseObject objectForKey:@"activityList"]];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && type==2)
    {
        [activityArray addObjectsFromArray:[responseObject objectForKey:@"activityList"]];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && type==3)
    {
        [activityArray addObjectsFromArray:[responseObject objectForKey:@"groupList"]];
        
        for (int i=0; i<[[responseObject objectForKey:@"groupList"] count]; i++)
        {
            if ([[[[responseObject objectForKey:@"groupList"] objectAtIndex:i] objectForKey:@"activityList"] count]>2)
            {
                [countFlagArray addObject:@"0"];
            }
            else
            {
                [countFlagArray addObject:@"1"];
            }
            
        }
        
        //[activityTableView reloadData];
        
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && type==4)
    {
        [activityArray addObjectsFromArray:[responseObject objectForKey:@"activityList"]];
        
    }
    else
    {
        if([[responseObject objectForKey:@"errorcode"] intValue]==-2)
        {
            [self alertOnly:@"没有获取数据"];
            
        }
        else if([[responseObject objectForKey:@"errorcode"] intValue]==-4)
        {
            [self alertOnly:@"请在设置中打开定位,方可搜索附近活动"];
            
        }
    }
    
    [activityListTableView reloadData];
    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
   /*
    if (type==3)
    {
        return countArray.count;
    }
    */
    
    return activityArray.count;
    
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{

    if (type==3)
    {
        if ([[countFlagArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            return 30+CELLHeight*2+30+10;
        }
        else
        {
            return 30+CELLHeight*[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] count]+10;
        }

    }
    else
    {
        return 100.0;
    }
    
    
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (type==3)
    {
        static NSString *cellIndefiner=@"bussinessCell";
        BussinessCell*cell=(BussinessCell*)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        
        if (cell==nil)
        {
            
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"BussinessCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        [cell.headView addSubview:[self drawLinebg:CGRectMake(0, 0, cell.headView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
        cell.shopNameLabel.textColor=kUIColorFromRGB(0x333333);
        cell.shopNameLabel.font=[UIFont systemFontOfSize:Font_42pt];
        cell.shopNameLabel.text=[[activityArray objectAtIndex:indexPath.row] objectForKey:@"stationName"];//@"车车翔汽车服务有限公司";
        // [cell.headView addSubview:[self customImageView:CGRectMake(cell.headView.frame.size.width-5-12*4-10, 10, 15, 10) image:IMAGE(@"icon_09")]];
        if ([[[activityArray objectAtIndex:indexPath.row] objectForKey:@"distance"]floatValue]>0.0)
        {
             [cell.headView addSubview:[self customLabel:CGRectMake(cell.headView.frame.size.width-5-80, 5, 80, 20) color:kUIColorFromRGB(common_blue) text:[NSString stringWithFormat:@"%.1fkm",[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"distance"] floatValue]/1000 ]alignment:1 font:Font_42pt]];
        }
       
        [cell.headView addSubview:[self drawLinebg:CGRectMake(0, cell.headView.frame.size.height-0.5, cell.headView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
        
        
        if ([[countFlagArray objectAtIndex:indexPath.row] isEqualToString:@"0"])
        {
            //画布
            cell.bussinessInfoView.frame=CGRectMake(0, 30, cell.bussinessInfoView.frame.size.width, CELLHeight*2+30);
            //cell.bussinessInfoView.backgroundColor=[UIColor greenColor];
            for (int i=0; i<2; i++)
            {
                UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, CELLHeight*i, cell.bussinessInfoView.frame.size.width, CELLHeight)];
                subView.backgroundColor=[UIColor whiteColor];
                
                UIImageView *iconImg=[self customImageView:CGRectMake(15, 10,90 ,CELLHeight-10*2 ) image:nil];
                [iconImg sd_setImageWithURL:[NSURL URLWithString:[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
                [subView addSubview:iconImg];
                
                UILabel *subLabel=[self customLabel:CGRectMake(10+100+10, 10, subView.frame.size.width-(10+100+10)-10, 30) color:kUIColorFromRGB(0x333333) text:[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"title"] alignment:-1 font:Font_42pt];
                subLabel.numberOfLines=2;
                [subView addSubview:subLabel];
                
                [subView addSubview:[self customLabel:CGRectMake(10+100+10, subView.frame.size.height-15-20, 50, 30) color:[UIColor orangeColor] text:[NSString stringWithFormat:@"¥%@",[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"discountPrice"] ] alignment:-1 font:Font_60pt]];
                [subView addSubview:[self customLabel:CGRectMake(10+100+10+70, subView.frame.size.height-15-13, 40, 20) color:[UIColor grayColor] text:[NSString stringWithFormat:@"¥%@",[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"] ]  alignment:-1 font:Font_48pt]];
                
                [subView addSubview:[self drawLine:CGRectMake(10+100+10+70, subView.frame.size.height-15-3, [[NSString stringWithFormat:@"%@",[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"]]length]*10, 1) drawColor:[UIColor lightGrayColor]]];
                //[subView addSubview:[self customLabel:CGRectMake(subView.frame.size.width-15-50, subView.frame.size.height-10-20, 50, 20) color:kUIColorFromRGB(0x888888) text:@"已售 63" alignment:1 font:Font_30pt]];
                
                [subView addSubview:[self drawLinebg:CGRectMake(0, subView.frame.size.height-0.5, subView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=subView.bounds;
                btn.tag=100*indexPath.row+i;
                [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
                [subView addSubview:btn];
                //[subView addSubview:[self customButton:subView.bounds tag:100+indexPath.row+i title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
                [cell.bussinessInfoView addSubview:subView];
            }
            
            UIView *moreView=[[UIView alloc] initWithFrame:CGRectMake(0,CELLHeight*2, cell.bussinessInfoView.frame.size.width, 30)];
            moreView.backgroundColor=[UIColor whiteColor];
            
            [moreView addSubview:[self customLabel:CGRectMake(0, 5, cell.frame.size.width, 20) color:kUIColorFromRGB(0x888888) text:[NSString stringWithFormat:@"查看其他%d个优惠券",[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] count]-2] alignment:0 font:Font_42pt]];
            
            //[moreView addSubview:[self customImageView:CGRectMake(220, (moreView.frame.size.height-8)/2, 12, 8) image:IMAGE(@"icon_15")]];
            
            [moreView addSubview:[self drawLinebg:CGRectMake(0, moreView.frame.size.height-0.5, moreView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
            
            
            [moreView addSubview:[self customButton:moreView.bounds tag:1000+indexPath.row title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
            
            [cell.bussinessInfoView addSubview:moreView];
        }
        else
        {
            //画布
            cell.bussinessInfoView.frame=CGRectMake(0, 30, cell.bussinessInfoView.frame.size.width, CELLHeight*[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] count]);
            
            for (int i=0; i<[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] count]; i++)
            {
                UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, CELLHeight*i, cell.bussinessInfoView.frame.size.width, CELLHeight)];
                subView.backgroundColor=[UIColor whiteColor];
                
                //[subView addSubview:[self customImageView:CGRectMake(15, 15,100 ,100-15*2 ) image:IMAGE(@"bgp")]];
                UIImageView *iconImg=[self customImageView:CGRectMake(15, 10,90 ,CELLHeight-10*2 ) image:nil];
                [iconImg sd_setImageWithURL:[NSURL URLWithString:[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
                [subView addSubview:iconImg];
                
                UILabel *subLabel=[self customLabel:CGRectMake(10+100+10, 10, subView.frame.size.width-(10+100+10)-10, 30) color:kUIColorFromRGB(0x333333) text:[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"title"] alignment:-1 font:Font_42pt];
                subLabel.numberOfLines=2;
                [subView addSubview:subLabel];
                
                //[subView addSubview:[self customLabel:CGRectMake(10+100+10, subView.frame.size.height-15-20, 20, 20) color:kUIColorFromRGB(common_blue) text:@"¥" alignment:-1 font:Font_96pt]];
                // [subView addSubview:[self customLabel:CGRectMake(10+100+10+20, subView.frame.size.height-10-35, 50, 35) color:kUIColorFromRGB(common_blue) text:@"85" alignment:-1 font:Font_120pt]];
                [subView addSubview:[self customLabel:CGRectMake(10+100+10, subView.frame.size.height-15-20, 50, 30) color:[UIColor orangeColor] text:[NSString stringWithFormat:@"¥%@",[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"discountPrice"] ] alignment:-1 font:Font_60pt]];
                [subView addSubview:[self customLabel:CGRectMake(10+100+10+70, subView.frame.size.height-15-13, 40, 20) color:[UIColor grayColor] text:[NSString stringWithFormat:@"¥%@",[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"] ]  alignment:-1 font:Font_48pt]];
                
                [subView addSubview:[self drawLine:CGRectMake(10+100+10+70, subView.frame.size.height-15-3, [[NSString stringWithFormat:@"%@",[[[[activityArray objectAtIndex:indexPath.row] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"]]length]*10+10, 1) drawColor:[UIColor lightGrayColor]]];
                // [subView addSubview:[self customLabel:CGRectMake(subView.frame.size.width-15-50, subView.frame.size.height-10-20, 50, 20) color:kUIColorFromRGB(0x888888) text:@"已售 63" alignment:1 font:Font_30pt]];
                
                [subView addSubview:[self drawLinebg:CGRectMake(0, subView.frame.size.height-0.5, subView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
                
                UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
                btn.frame=subView.bounds;
                btn.tag=100*indexPath.row+i;
                [btn addTarget:self action:@selector(btn:) forControlEvents:UIControlEventTouchUpInside];
                [subView addSubview:btn];
                
                // [subView addSubview:[self customButton:subView.bounds tag:100*indexPath.row+i title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
                
                [cell.bussinessInfoView addSubview:subView];
                
            }
            
        }
        
        return cell;

    }
    else
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
            cell.backgroundColor=kUIColorFromRGB(0xe7e7e7);
            
        }
        else
        {
            cell.backgroundColor=[UIColor whiteColor];
        }
        
        
        
        //[cell.shopImageView setImageWithURL:[NSURL URLWithString:[[activityArray objectAtIndex:indexPath.row]objectForKey:@"imagePath"]] placeholderImage:nil];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString:[[activityArray objectAtIndex:indexPath.row]objectForKey:@"imagePath"]] placeholderImage:nil];
        
        cell.activityNameLabel.text=[[activityArray objectAtIndex:indexPath.row]objectForKey:@"title"];
        
        //描述
        cell.activitydesLabel.text=[[activityArray objectAtIndex:indexPath.row]objectForKey:@"summary"];
        
        cell.activityDiscountLabel.text=[NSString stringWithFormat:@"%@",[[activityArray objectAtIndex:indexPath.row]objectForKey:@"discountDescription"]];
        
        /*
         //折扣
         cell.activityDiscountLabel.textColor=[UIColor redColor];
         if ([[[activityArray objectAtIndex:indexPath.row]objectForKey:@"discountType"] isEqualToString:@"立减"])
         {
         cell.activityDiscountLabel.text=[NSString stringWithFormat:@"%@%@元",[[activityArray objectAtIndex:indexPath.row]objectForKey:@"discountType"],[[activityArray objectAtIndex:indexPath.row]objectForKey:@"discountValue"] ];
         }
         else
         {
         cell.activityDiscountLabel.text=[NSString stringWithFormat:@"打%d折",[[[activityArray objectAtIndex:indexPath.row]objectForKey:@"discountValue"] intValue] ];
         }
         */
        
        
        return cell;

    }
    
}


-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //活动详细内容
    ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
    info.activityInfo=[activityArray objectAtIndex:indexPath.row];
    
    [self.navigationController pushViewController:info animated:YES];
    
}

-(void)btn:(UIButton *)sender
{
    int num=sender.tag/100;//第几个数组
    int row=sender.tag%100;//数组中的第几个
    
   // NSLog(@"num::%d",num);
   // NSLog(@"row::%d",row);
    
    //活动详细内容
    ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
    info.activityInfo=[[[activityArray objectAtIndex:num] objectForKey:@"activityList"] objectAtIndex:row];
    
    [self.navigationController pushViewController:info animated:YES];
    
}


-(void)customEvent:(UIButton *)sender
{
    if (sender.tag>=1000)
    {
       // NSLog(@"点击更多");
       // NSLog(@"sender::%d",sender.tag);
        [countFlagArray removeObjectAtIndex:sender.tag-1000];
        [countFlagArray insertObject:@"1" atIndex:sender.tag-1000];
        
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:sender.tag-1000 inSection:0];
        
        [activityListTableView reloadData];
        
        [activityListTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath]
         
                                 withRowAnimation:UITableViewRowAnimationFade];
        
        
    }

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
