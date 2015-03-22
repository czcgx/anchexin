//
//  DisscussListViewController.m
//  anchexin
//
//  Created by cgx on 14-12-12.
//
//

#import "DisscussListViewController.h"

@interface DisscussListViewController ()

@end

@implementation DisscussListViewController
@synthesize stationInfo;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
     [self skinOfBackground];
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
    
    dissTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height-50)];
    dissTableView.tag=1;
    dissTableView.delegate=self;
    dissTableView.dataSource=self;
    dissTableView.backgroundView=nil;
    dissTableView.backgroundColor=[UIColor clearColor];
    dissTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //shopTableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    [mainView addSubview:dissTableView];
    
    //第三方控件，进行下拉刷新
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = dissTableView;
    
    
    _header = [[MJRefreshHeaderView alloc] init];
    _header.delegate = self;
    _header.scrollView = dissTableView;
    
     UILabel *line=[[UILabel alloc] initWithFrame:CGRectMake(0, mainView.frame.size.height-50, 320.0, 1)];
     line.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
     [mainView addSubview:line];
    
    //预约
    UIView *orderView=[[UIView alloc] initWithFrame:CGRectMake(0,mainView.frame.size.height-50, WIDTH, 50)];
    orderView.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [orderView addSubview:[self customLabel:CGRectMake(10, 15, 190, 20) color:[UIColor darkGrayColor] text:@"到过该门店,我也想点评一下!" alignment:-1 font:13.0]];
    
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
    [mainView addSubview:orderView];

    
    [self.view addSubview:mainView];
    
    [ToolLen ShowWaitingView:YES];
    dissListArray=[[NSMutableArray alloc] init];
    
    page=0;
    [self comment];

}


//上拉更新加载更多数据
#pragma mark - 刷新的代理方法---进入下拉刷新\上拉加载更多都有可能调用这个方法
- (void)refreshViewBeginRefreshing:(MJRefreshBaseView *)refreshView
{
    if (refreshView == _footer)//上拉刷新
    {
        [self comment];
        
    }
    else if(refreshView == _header)//下拉刷新
    {
        page=0;
        [self comment];
    }
}


-(void)comment
{
    page++;
    [[self JsonFactory] get_getRepairStationCommentList:[stationInfo objectForKey:@"repairstationid"] currentpage:[NSString stringWithFormat:@"%d",page] action:@"getStationCommentList"];
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    // 结束刷新状态
    [_footer endRefreshing];
    [_header endRefreshing];
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        if (page==1)
        {
            [dissListArray removeAllObjects];
        }
        
        [dissListArray addObjectsFromArray:[NSArray arrayWithArray:[responseObject objectForKey:@"stationCommentList"] ]];
        
        //NSLog(@"commentList::%@",commentList);
        [dissTableView reloadData];
        
    }
}




-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [dissListArray count];
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
   
    NSString *LabelString=[[dissListArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    CGSize constraint = CGSizeMake(290.0, 20000.0f);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    CGFloat height = MAX(size.height, 30.0f);
    
   // NSLog(@"111111:%f",30+height+10);
    return 30+height+10;

}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"Station5Cell";
    CommentCell *cell=(CommentCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CommentCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.commentNameLabel.text=[NSString stringWithFormat:@"%@xxxx%@",[[[dissListArray objectAtIndex:indexPath.row] objectForKey:@"mobile"] substringToIndex:4],[[[dissListArray objectAtIndex:indexPath.row] objectForKey:@"mobile"] substringFromIndex:8]];
    cell.commentDateLabel.text=[[[dissListArray objectAtIndex:indexPath.row] objectForKey:@"create_time"] substringToIndex:10];
    
    int m=[[[dissListArray objectAtIndex:indexPath.row] objectForKey:@"satisfaction"] intValue];
    // NSLog(@"m::%d",m);
    for (int i=0; i<m; i++)
    {
        UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(100+16*i, 6, 20, 20)];
        starImageView.image=IMAGE(@"commet");
        [cell.contentView addSubview:starImageView];
    }

    
    
    NSString *LabelString=[[dissListArray objectAtIndex:indexPath.row] objectForKey:@"content"];
    CGSize constraint = CGSizeMake(290.0, 20000.0f);
    NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
    CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
    
    CGFloat height = MAX(size.height, 30.0f);
    //NSLog(@"height::%f",height);
    
    // cell.frame=CGRectMake(0, 0, WIDTH, 20+40+30+height+10);
    // cell.backgroundColor=[UIColor blackColor];
    cell.commentView.frame=CGRectMake(0, 0, WIDTH, 30+height+10);
    cell.commentView.backgroundColor=[UIColor whiteColor];
    
    cell.commentContentLabel.frame=CGRectMake(15, 30, 290, height+10);
    cell.commentContentLabel.numberOfLines=0;
    cell.commentContentLabel.lineBreakMode=NSLineBreakByWordWrapping;
    cell.commentContentLabel.font=[UIFont systemFontOfSize:13.0];
    cell.commentContentLabel.text=LabelString;
    
    UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0,30+height+10-1, WIDTH, 1)];
    lineLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
    [cell.contentView addSubview:lineLabel];
    

    return cell;
}

//发表评论
-(void)customEvent:(UIButton *)sender
{
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        if (sender.tag==12)
        {
            DisscussViewController *diss=[[DisscussViewController alloc]init];
            diss.title=@"发表评论";
            diss.stationId=[stationInfo objectForKey:@"repairstationid"];
            [self.navigationController pushViewController:diss animated:YES];
        }

    }
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (buttonIndex==1)
    {
        // NSLog(@"登录");
        LoginAndResigerViewController *guide=[[LoginAndResigerViewController alloc] init];
        [self.navigationController pushViewController:guide animated:YES];
    }
}



@end
