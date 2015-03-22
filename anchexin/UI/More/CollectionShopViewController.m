//
//  CollectionShopViewController.m
//  anchexin
//
//  Created by cgx on 14-10-22.
//
//

#import "CollectionShopViewController.h"

@interface CollectionShopViewController ()

@end

@implementation CollectionShopViewController

//按排序方式请求数据
-(void)reloadRequest
{
   
    if (pageIndex==0)//如果是第一个页面，显示转子
    {
        [ToolLen ShowWaitingView:YES];
    }
    
    pageIndex++;

    [[self JsonFactory] getUserCollectionList:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20" action:@"getUserCollectionList"];

}



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.

    [self skinOfBackground];
    self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(BGCOLOR);
    
    addArray=[[NSMutableArray alloc]init];
    
    collectTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, mainView.frame.size.height)];
    collectTableView.delegate=self;
    collectTableView.dataSource=self;
    collectTableView.backgroundView=nil;
    collectTableView.backgroundColor=[UIColor clearColor];
    collectTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [mainView addSubview:collectTableView];
    
    [self.view addSubview:mainView];
    
    //第三方控件，进行下拉刷新
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = collectTableView;
    
    pageIndex=0;
    [[self JsonFactory] getUserCollectionList:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20" action:@"getUserCollectionList"];
    
    
    /*

    pageIndex=0;
    [[self JsonFactory] getUserCollectionList:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20" action:@"getUserCollectionList"];
    
    */
    
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    //NSLog(@"responseObject::%@",responseObject);
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        if (pageIndex==0)//如果是第一页，初始化
        {
            addArray=[[NSMutableArray alloc]init];
        }
        
        [addArray addObjectsFromArray:[responseObject objectForKey:@"stationList"]];
     
        [self performSelector:@selector(reloadDeals) withObject:nil];
        
    }
    else
    {
        if (pageIndex==0)
        {
             [self alertOnly:[responseObject objectForKey:@"message"] ];
        }
       
    }

   
    
}

#pragma mark 刷新页面
- (void)reloadDeals
{
    
    [collectTableView reloadData];
    
    // 结束刷新状态
    [_footer endRefreshing];
    if ([addArray count]==0)
    {
        [self alertOnly:@"暂无列表信息"];
    }
}

//上拉更新加载更多数据
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer)//上拉刷新
    {
       [self reloadRequest];
    }
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
    
    return 100;
    
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
    
    //[cell.stationImageView setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[addArray objectAtIndex:indexPath.row] objectForKey:@"half_img"]]] placeholderImage:nil];
    [cell.stationImageView sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[[addArray objectAtIndex:indexPath.row] objectForKey:@"half_img"]]] placeholderImage:nil];
    
    cell.stationNameLabel.text=[[addArray objectAtIndex:indexPath.row] objectForKey:@"name"];
    cell.stationDistanceLabel.text=[NSString stringWithFormat:@"%.1fKm",[[[addArray objectAtIndex:indexPath.row] objectForKey:@"juli"] floatValue]/1000];
    
    if ([[[addArray objectAtIndex:indexPath.row] objectForKey:@"have_pos"] intValue]==1)
    {
        //显示
        cell.stationFlag.hidden=NO;
        for (int i=0; i<4; i++)
        {
            UIImageView *iconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(140+18*i,72, 15,15)];
            NSString *iconStr=[NSString stringWithFormat:@"station_%d",i+1];
            iconImageView.image=IMAGE(iconStr);
            [cell.contentView addSubview:iconImageView];
            
        }
    }
    else
    {
        //隐藏
        cell.stationFlag.hidden=YES    ;
    }
    //好评率
    float temp=[[[addArray objectAtIndex:indexPath.row] objectForKey:@"avg_comment"] floatValue]*100.0+0.5;
    int m=temp/20;
    //NSLog(@"m::%d",m);
    for (int i=0; i<m; i++)
    {
        UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(138+16*i, 40, 20, 20)];
        starImageView.image=IMAGE(@"commet");
        [cell.contentView addSubview:starImageView];
    }
    
    return cell;
    
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    New_StationInfoViewController *stationInfo=[[New_StationInfoViewController alloc] init];
    stationInfo.hidesBottomBarWhenPushed=YES;
    stationInfo.title=@"维修站详情";
    //stationInfo.orderArry=orderArray;
    stationInfo.stationInfo=[addArray objectAtIndex:indexPath.row];//店面信息
    [self.navigationController pushViewController:stationInfo animated:YES];
    
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
