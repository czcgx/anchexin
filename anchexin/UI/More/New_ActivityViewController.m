//
//  New_ActivityViewController.m
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import "New_ActivityViewController.h"

#import "BWMCoverView.h"

#define CELLHeight 80

@interface New_ActivityViewController ()

@end

@implementation New_ActivityViewController

//领取优惠券
-(void)getTitck
{
    //NSLog(@"优惠券");
    
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        ActivityListViewController *list=[[ActivityListViewController alloc] init];
        list.title=@"已领取活动列表";
        list.type=1;
        [self.navigationController pushViewController:list animated:YES];
    }
    
}


- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    [MobClick event:@"activityPage"];//统计活动页面

    /*
    UIBarButtonItem *bar=[[UIBarButtonItem alloc] initWithTitle:@"已领取"
                                                          style:UIBarButtonItemStyleDone target:self
                                                         action:@selector(getTitck)];
    
    self.navigationController.navigationBar.tintColor=[UIColor whiteColor];
    self.navigationItem.rightBarButtonItem=bar;
    */
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
    
    activityTableView=[[UITableView alloc] initWithFrame:mainView.bounds];
    activityTableView.backgroundColor=[UIColor clearColor];
    activityTableView.backgroundView=nil;
    activityTableView.delegate=self;
    activityTableView.dataSource=self;
    activityTableView.separatorStyle=UITableViewCellSeparatorStyleNone;//分割线
    [mainView addSubview:activityTableView];
    
    //第三方控件，进行下拉刷新
    _footer = [[MJRefreshFooterView alloc] init];
    _footer.delegate = self;
    _footer.scrollView = activityTableView;
    
    UITapGestureRecognizer *tap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(handleTap:)];
    [activityTableView addGestureRecognizer:tap];
    
    [self.view addSubview:mainView];
    
    
    requestArray=[[NSMutableArray alloc] init];
    countFlagArray=[[NSMutableArray alloc] initWithCapacity:0];
    
    [ToolLen ShowWaitingView:YES];
    pageIndex=0;
    //获取所有活动接口
    [[self JsonFactory]getActivityList:@"0" pageSize:@"20" lng:[AppDelegate setGlobal].currentLongitude lat:[AppDelegate setGlobal].currentLatitude action:@"getActivityList"];

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
   
    //获取所有活动接口
    [[self JsonFactory]getActivityList:[NSString stringWithFormat:@"%d",pageIndex] pageSize:@"20"  lng:[AppDelegate setGlobal].currentLongitude lat:[AppDelegate setGlobal].currentLatitude action:@"getActivityList"];
    

}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    
    // 结束刷新状态
    [_footer endRefreshing];
    
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        if (pageIndex==0)
        {
            //推荐，滚动视图
            scrollArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"activityListRecommend"]];
        }
        
        //其他
        [requestArray addObjectsFromArray:[responseObject objectForKey:@"groupList"]];
        
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
        
        [activityTableView reloadData];
    }


}



/*
-(BOOL)textFieldShouldBeginEditing:(UITextField *)textField
{
    [activityTableView setContentOffset:CGPointMake(0, 0)];
    return YES;
}
 */

-(void)customEvent:(UIButton *)sender
{
   // :,,@"",@""
    
    if (sender.tag<10)
    {
        //NSLog(@"sneder:%ld",(long)sender.tag);
        ActivityListViewController *list=[[ActivityListViewController alloc] init];
        
        if (sender.tag==0)//产品
        {
            list.title=@"产品列表";
            list.searchString=@"产品";
        }
        else if (sender.tag==1)//@"服务"
        {
            list.title=@"服务列表";
            list.searchString=@"服务";
        }
        else if (sender.tag==2)//附近
        {
            list.title=@"附近列表";
            list.searchString=@"附近";
        }
        else if (sender.tag==3)//产品
        {
            list.title=@"其他列表";
            list.searchString=@"其他";
        }
        
        list.type=3;
        [self.navigationController pushViewController:list animated:YES];
    }
    else if (sender.tag>=1000)
    {
       // NSLog(@"点击更多");
       // NSLog(@"sender::%d",sender.tag);
        [countFlagArray removeObjectAtIndex:sender.tag-1000-1];
        [countFlagArray insertObject:@"1" atIndex:sender.tag-1000-1];
        
        NSIndexPath *reloadIndexPath = [NSIndexPath indexPathForRow:sender.tag-1000-1 inSection:0];
        
        [activityTableView reloadData];
        
        [activityTableView reloadRowsAtIndexPaths:[NSArray arrayWithObject:reloadIndexPath]
         
                                 withRowAnimation:UITableViewRowAnimationFade];
        
        
    }

    
}
-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    //return requestArray.count+1;
    return requestArray.count+1;
}


-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==0)
    {
        //return 340.0;
        return 290.0;
    }
    else
    {
        if ([[countFlagArray objectAtIndex:indexPath.row-1] isEqualToString:@"0"])
        {
            return 30+80*2+30+10;
        }
        else
        {
            return 30+80*[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] count]+10;
        }
    }
    //return 100.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (indexPath.row==0)
    {
        static NSString *cellIndefiner=@"cellIndefiner";
        
        UITableViewCell *cell=(UITableViewCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            cell=[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellIndefiner];
            
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        }
        
        //UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 340)];
        UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 290)];
        subView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
        [cell.contentView addSubview:subView];
        
        /*
        //搜索区域视图
        UIView *searchView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 50)];
        searchView.backgroundColor=[UIColor clearColor];
        UIImageView *searchbg=[[UIImageView alloc] initWithFrame:CGRectMake(15, 10, 290, 35)];
        searchbg.image=IMAGE(@"ac_bg");
        [searchView addSubview:searchbg];
        
        UIImageView *searchIcon=[[UIImageView alloc] initWithFrame:CGRectMake(270, 17, 20, 20)];
        searchIcon.image=IMAGE(@"ac_icon");
        [searchView addSubview:searchIcon];
        
        txt=[[UITextField alloc] initWithFrame:CGRectMake(25, 13, 250, 30)];
        txt.backgroundColor=[UIColor clearColor];
        txt.delegate=self;
        txt.borderStyle=UITextBorderStyleNone;
        txt.placeholder=@"搜索优惠活动...";
        txt.font=[UIFont systemFontOfSize:13.0];
        txt.textColor=[UIColor blackColor];
        txt.returnKeyType=UIReturnKeySearch;
        [searchView addSubview:txt];
        
        [subView addSubview:searchView];
        */
        
        //筛选视图
        UIView *screenView=[[UIView alloc] initWithFrame:CGRectMake(0, 50-50, WIDTH, 100)];
        screenView.backgroundColor=[UIColor clearColor];
        NSArray *lblArray=[NSArray arrayWithObjects:@"产品",@"服务",@"附近",@"其他", nil];
        for (int i=0; i<4; i++)
        {
            UIView *sub=[[UIView alloc] initWithFrame:CGRectMake(16+(60+16)*i, 10, 60, 80)];
            sub.backgroundColor=[UIColor clearColor];
            UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 60, 60)];
            NSString *imgStr=[NSString stringWithFormat:@"ac_%d",i+1];
            img.image=IMAGE(imgStr);
            [sub addSubview:img];
            
            UILabel *lbl=[[UILabel alloc] initWithFrame:CGRectMake(0, 60, 60, 20)];
            lbl.backgroundColor=[UIColor clearColor];
            lbl.font=[UIFont systemFontOfSize:14.0];
            lbl.textAlignment=NSTextAlignmentCenter;
            lbl.textColor=[UIColor blackColor];
            lbl.text=[lblArray objectAtIndex:i];
            [sub addSubview:lbl];
            
            [sub addSubview:[self customButton:sub.bounds tag:i title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
            
            [screenView addSubview:sub];
        }
        [subView addSubview:screenView];
        
        //轮询视图
        UIView *lunxunView=[[UIView alloc] initWithFrame:CGRectMake(0, 150-50, WIDTH, 150)];
        lunxunView.backgroundColor=[UIColor clearColor];
        
        // 此数组用来保存BWMCoverViewModel
        NSMutableArray *realArray = [[NSMutableArray alloc] init];
        for (int i = 0; i<scrollArray.count; i++)
        {
            NSString *imageStr = [[scrollArray objectAtIndex:i] objectForKey:@"imagePathLevel"];
            NSString *imageTitle = @"";
            
            BWMCoverViewModel *model = [[BWMCoverViewModel alloc] initWithImageURLString:imageStr imageTitle:imageTitle];
            [realArray addObject:model];
        }
        
        // 以上代码只为了构建一个包含BWMCoverViewModel的数组而已——realArray
        /**
         * 快速创建BWMCoverView
         * models是一个包含BWMCoverViewModel的数组
         * placeholderImageNamed为图片加载前的本地占位图片名
         */
        BWMCoverView *coverView = [BWMCoverView coverViewWithModels:realArray andFrame:lunxunView.bounds andPlaceholderImageNamed:nil andClickdCallBlock:^(NSInteger index) {
            
            //NSLog(@"你点击了第%ld个图片", (long)index);
            //活动详细内容
            ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
            info.activityInfo=[scrollArray objectAtIndex:index];
            
            [self.navigationController pushViewController:info animated:YES];
            
        }];
        [lunxunView addSubview:coverView];
        
        // 只需以上两句即可创建BWMCoverView了，也可以继续往下看，自定义更多效果
        /*
         // 滚动视图每一次滚动都会回调此方法
         [coverView setScrollViewCallBlock:^(NSInteger index) {
         NSLog(@"当前滚动到第%ld个页面", (long)index);
         }];
         */
        // 请打开下面的东西逐个调试
        [coverView setAutoPlayWithDelay:3.0]; // 设置自动播放
        coverView.imageViewsContentMode = UIViewContentModeScaleAspectFit; // 图片显示内容模式模式
        // [coverView stopAutoPlayWithBOOL:YES]; // 停止自动播放
        // [coverView stopAutoPlayWithBOOL:NO]; // 恢复自动播放
        // [coverView setAnimationOption:UIViewAnimationOptionTransitionCurlUp]; // 设置切换动画
        coverView.pageControl.backgroundColor=[UIColor clearColor];
        coverView.titleLabel.hidden = YES; //隐藏TitleLabel
        [coverView updateView]; //修改属性后必须调用updateView方法，更新视图
        
        /*
         // 你也可以试着调用init方法创建BWMCoverView
         BWMCoverView *coverView2 = [[BWMCoverView alloc] initWithFrame:self.view.frame];
         [self.view addSubview:coverView2];
         
         coverView2.models = realArray;
         coverView2.placeholderImageNamed = BWMCoverViewDefaultImage;
         coverView2.animationOption = UIViewAnimationOptionTransitionCurlUp;
         
         [coverView2 setCallBlock:^(NSInteger index) {
         NSLog(@"你点击了第%d个图片", index);
         }];
         
         [coverView2 setScrollViewCallBlock:^(NSInteger index) {
         NSLog(@"当前滚动到第%d个页面", index);
         }];
         
         #warning 修改属性后必须调用updateView方法
         */
        
        [subView addSubview:lunxunView];
        
        //猜你喜欢
        UIView *desLabelView=[[UIView alloc] initWithFrame:CGRectMake(0, 300-50, WIDTH, 40)];
        desLabelView.backgroundColor=[UIColor clearColor];
        UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 10, 100, 20)];
        desLabel.backgroundColor=[UIColor clearColor];
        desLabel.font=[UIFont boldSystemFontOfSize:14.0];
        desLabel.textAlignment=NSTextAlignmentLeft;
        desLabel.textColor=[UIColor blackColor];
        desLabel.text=@"猜你喜欢";
        [desLabelView addSubview:desLabel];
        
        [subView addSubview:desLabelView];
        
        return cell;
        
    }
    else if(indexPath.row>0)
    {
        /*
        static NSString *cellIndefiner=@"cellIn";
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
        
        
        //[cell.shopImageView setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",[[requestArray objectAtIndex:indexPath.row-1]objectForKey:@"imagePath"]]]placeholderImage:nil];
        [cell.shopImageView sd_setImageWithURL:[NSURL URLWithString: [NSString stringWithFormat:@"%@",[[requestArray objectAtIndex:indexPath.row-1]objectForKey:@"imagePath"]]] placeholderImage:nil];
        
        cell.activityNameLabel.text=[[requestArray objectAtIndex:indexPath.row-1]objectForKey:@"title"];
        
        //描述
        cell.activitydesLabel.text=[[requestArray objectAtIndex:indexPath.row-1]objectForKey:@"summary"];
        
        cell.activityDiscountLabel.text=[NSString stringWithFormat:@"%@",[[requestArray objectAtIndex:indexPath.row-1]objectForKey:@"discountDescription"]];
        
        UIButton *activityBtn=[UIButton buttonWithType:UIButtonTypeCustom];
        activityBtn.frame=CGRectMake(0, 0, WIDTH, 100);
        activityBtn.tag=indexPath.row;
        [activityBtn addTarget:self action:@selector(clickActivity:) forControlEvents:UIControlEventTouchUpInside];
        [cell.contentView addSubview:activityBtn];
        
        return cell;
         */
        
        
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
        cell.shopNameLabel.text=[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"stationName"];//@"车车翔汽车服务有限公司";
       // [cell.headView addSubview:[self customImageView:CGRectMake(cell.headView.frame.size.width-5-12*4-10, 10, 15, 10) image:IMAGE(@"icon_09")]];
        if ([[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"distance"]floatValue]>0.0)
        {
            [cell.headView addSubview:[self customLabel:CGRectMake(cell.headView.frame.size.width-5-80, 5, 80, 20) color:kUIColorFromRGB(common_blue) text:[NSString stringWithFormat:@"%.1fkm",[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"distance"] floatValue]/1000 ]alignment:1 font:Font_42pt]];
        }
        
        [cell.headView addSubview:[self drawLinebg:CGRectMake(0, cell.headView.frame.size.height-0.5, cell.headView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
        
        
        if ([[countFlagArray objectAtIndex:indexPath.row-1] isEqualToString:@"0"])
        {
            //画布
            cell.bussinessInfoView.frame=CGRectMake(0, 30, cell.bussinessInfoView.frame.size.width, CELLHeight*2+30);
            //cell.bussinessInfoView.backgroundColor=[UIColor greenColor];
            for (int i=0; i<2; i++)
            {
                UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, CELLHeight*i, cell.bussinessInfoView.frame.size.width, CELLHeight)];
                subView.backgroundColor=[UIColor whiteColor];
                
                UIImageView *iconImg=[self customImageView:CGRectMake(15, 10,90 ,CELLHeight-10*2 ) image:nil];
                [iconImg sd_setImageWithURL:[NSURL URLWithString:[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
                [subView addSubview:iconImg];
                
                UILabel *subLabel=[self customLabel:CGRectMake(10+100+10, 10, subView.frame.size.width-(10+100+10)-10, 30) color:kUIColorFromRGB(0x333333) text:[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"title"] alignment:-1 font:Font_42pt];
                subLabel.numberOfLines=2;
                [subView addSubview:subLabel];
                
                //折扣价
                [subView addSubview:[self customLabel:CGRectMake(10+100+10, subView.frame.size.height-15-20, 90, 30) color:[UIColor orangeColor] text:[NSString stringWithFormat:@"¥%@",[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"discountPrice"] ] alignment:-1 font:Font_60pt]];
                //市场价
                [subView addSubview:[self customLabel:CGRectMake(10+100+10+70+20, subView.frame.size.height-15-13,90, 20) color:[UIColor grayColor] text:[NSString stringWithFormat:@"¥%@",[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"] ]  alignment:-1 font:Font_48pt]];
                //横线
                [subView addSubview:[self drawLine:CGRectMake(10+100+10+70+20, subView.frame.size.height-15-3, [[NSString stringWithFormat:@"%@",[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"]]length]*10, 1) drawColor:[UIColor lightGrayColor]]];
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
            
            [moreView addSubview:[self customLabel:CGRectMake(0, 5, cell.frame.size.width, 20) color:kUIColorFromRGB(0x888888) text:[NSString stringWithFormat:@"查看其他%d个优惠券",[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] count]-2] alignment:0 font:Font_42pt]];
            
            //[moreView addSubview:[self customImageView:CGRectMake(220, (moreView.frame.size.height-8)/2, 12, 8) image:IMAGE(@"icon_15")]];
            
            [moreView addSubview:[self drawLinebg:CGRectMake(0, moreView.frame.size.height-0.5, moreView.frame.size.width, 0.5) lineColor:kUIColorFromRGB(common_line_color)]];
            
            
            [moreView addSubview:[self customButton:moreView.bounds tag:1000+indexPath.row title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
            
            [cell.bussinessInfoView addSubview:moreView];
        }
        else
        {
            //画布
            cell.bussinessInfoView.frame=CGRectMake(0, 30, cell.bussinessInfoView.frame.size.width, CELLHeight*[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] count]);
            
            for (int i=0; i<[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] count]; i++)
            {
                UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, CELLHeight*i, cell.bussinessInfoView.frame.size.width, CELLHeight)];
                subView.backgroundColor=[UIColor whiteColor];
                
               //[subView addSubview:[self customImageView:CGRectMake(15, 15,100 ,100-15*2 ) image:IMAGE(@"bgp")]];
                UIImageView *iconImg=[self customImageView:CGRectMake(15, 10,90 ,CELLHeight-10*2 ) image:nil];
                [iconImg sd_setImageWithURL:[NSURL URLWithString:[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"imagePath"]] placeholderImage:nil];
                [subView addSubview:iconImg];
                
                UILabel *subLabel=[self customLabel:CGRectMake(10+100+10, 10, subView.frame.size.width-(10+100+10)-10, 30) color:kUIColorFromRGB(0x333333) text:[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"title"] alignment:-1 font:Font_42pt];
                subLabel.numberOfLines=2;
                [subView addSubview:subLabel];
                
                //[subView addSubview:[self customLabel:CGRectMake(10+100+10, subView.frame.size.height-15-20, 20, 20) color:kUIColorFromRGB(common_blue) text:@"¥" alignment:-1 font:Font_96pt]];
               // [subView addSubview:[self customLabel:CGRectMake(10+100+10+20, subView.frame.size.height-10-35, 50, 35) color:kUIColorFromRGB(common_blue) text:@"85" alignment:-1 font:Font_120pt]];
                //折扣价
                 [subView addSubview:[self customLabel:CGRectMake(10+100+10, subView.frame.size.height-15-20, 90, 30) color:[UIColor orangeColor] text:[NSString stringWithFormat:@"¥%@",[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"discountPrice"] ] alignment:-1 font:Font_60pt]];
                //市场价
                [subView addSubview:[self customLabel:CGRectMake(10+100+10+70+20, subView.frame.size.height-15-13, 90, 20) color:[UIColor grayColor] text:[NSString stringWithFormat:@"¥%@",[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"] ]  alignment:-1 font:Font_48pt]];
                //横线
                [subView addSubview:[self drawLine:CGRectMake(10+100+10+70+20, subView.frame.size.height-15-3, [[NSString stringWithFormat:@"%@",[[[[requestArray objectAtIndex:indexPath.row-1] objectForKey:@"activityList"] objectAtIndex:i] objectForKey:@"marketPrice"]]length]*10+10, 1) drawColor:[UIColor lightGrayColor]]];
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
    
    return nil;
    
}


-(void)clickActivity:(UIButton *)sender
{

    //活动详细内容
    ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
    info.activityInfo=[requestArray objectAtIndex:sender.tag-1];
    
    [self.navigationController pushViewController:info animated:YES];

}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    if (textField.text.length>0)
    {
        
        ActivityListViewController *list=[[ActivityListViewController alloc] init];
        list.title=[NSString stringWithFormat:@"搜索'%@'列表",txt.text];
        list.searchString=txt.text;
        list.type=2;
        [self.navigationController pushViewController:list animated:YES];
        

    }
    return YES;
}

#pragma mark ---触摸关闭键盘----
-(void)handleTap:(UIGestureRecognizer *)gesture
{
    [self.view endEditing:YES];
    /*
    [UIView animateWithDuration:0.5f animations:^{
        
    } completion:^(BOOL finished) {
        
        [txt resignFirstResponder];
        
    }];
    */
    
    [txt resignFirstResponder];
    
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        //NSLog(@"登录");
        LoginAndResigerViewController *guide=[[LoginAndResigerViewController alloc] init];
        guide.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:guide animated:YES];
    }

}




-(void)btn:(UIButton *)sender
{
    int num=sender.tag/100;//第几个数组
    int row=sender.tag%100;//数组中的第几个
    
   // NSLog(@"num::%d",num);
   // NSLog(@"row::%d",row);
    
    //活动详细内容
    ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
    info.activityInfo=[[[requestArray objectAtIndex:num-1] objectForKey:@"activityList"] objectAtIndex:row];
    
    [self.navigationController pushViewController:info animated:YES];
    
}



@end
