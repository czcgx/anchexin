//
//  New_StationInfoViewController.m
//  anchexin
//
//  Created by cgx on 14-12-7.
//
//

#import "New_StationInfoViewController.h"


#import "AlixLibService.h"//请求你
#import "AlixPayOrder.h"
#import "AlixPayResult.h"//返回结果
#import "DataSigner.h"
#import "DataVerifier.h"


@interface New_StationInfoViewController ()

@end

@implementation New_StationInfoViewController
@synthesize stationInfo;


-(void)showRight
{
    
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        if ([[collectInfo objectForKey:@"haveCollected"] intValue]==0)
        { //添加
            requestTimes=3;
            [[self JsonFactory] collectStation:@"1" station:[stationInfo objectForKey:@"repairstationid"] action:@"collectStation"];
        }
        else
        {//取消
            requestTimes=4;
            [[self JsonFactory] collectStation:@"0" station:[stationInfo objectForKey:@"repairstationid"] action:@"collectStation"];
        }
        
    }
}


-(UIView *)popAlertView
{
    UIView *popAlertView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    popAlertView.backgroundColor=[UIColor clearColor];
    
    UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(20,120, 280, 140)];
    contentView.backgroundColor=kUIColorFromRGB(DARKCOLOR);
    
    contentView.layer.cornerRadius = 1.0f;
    contentView.layer.borderColor = [UIColor clearColor].CGColor;
    contentView.layer.borderWidth = 2.0f;
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew.bundle/Buttons/UMS_shake_close_tap@2x" ofType:@"png" ];
    UIImageView *p=[[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 20, 20)];
    p.image=[UIImage imageWithContentsOfFile:filePath];
    [contentView addSubview:p];
    [contentView addSubview:[self customButton:p.frame tag:20 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_qzone_icon@2x" ofType:@"png" ];
    UIImageView *p1=[[UIImageView alloc] initWithFrame:CGRectMake(30, 40, 60, 60)];
    p1.image=[UIImage imageWithContentsOfFile:filePath1];
    [contentView addSubview:p1];
    [contentView addSubview:[self customLabel:CGRectMake(30, 100, 60, 20) color:kUIColorFromRGB(BGCOLOR) text:@"QQ空间" alignment:0 font:13.0]];
    [contentView addSubview:[self customButton:p1.frame tag:21 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_sina_icon@2x" ofType:@"png" ];
    UIImageView *p2=[[UIImageView alloc] initWithFrame:CGRectMake(110, 40, 60, 60)];
    p2.image=[UIImage imageWithContentsOfFile:filePath2];
    [contentView addSubview:p2];
    [contentView addSubview:[self customLabel:CGRectMake(110, 100, 60, 20) color:kUIColorFromRGB(BGCOLOR) text:@"新浪微博" alignment:0 font:13.0]];
    [contentView addSubview:[self customButton:p2.frame tag:22 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    NSString *filePath3 = [[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew.bundle/SnsPlatform/UMS_wechat_timeline_icon@2x" ofType:@"png" ];
    UIImageView *p3=[[UIImageView alloc] initWithFrame:CGRectMake(190, 40, 60, 60)];
    p3.image=[UIImage imageWithContentsOfFile:filePath3];
    [contentView addSubview:p3];
    [contentView addSubview:[self customLabel:CGRectMake(190, 100, 60, 20) color:kUIColorFromRGB(BGCOLOR) text:@"朋友圈" alignment:0 font:13.0]];
    [contentView addSubview:[self customButton:p3.frame tag:23 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    [popAlertView addSubview:contentView];
    
    return popAlertView;
}

//展示
- (void)show
{
    //self.STAlertView.center = self.view.center;
    [alertView removeFromSuperview];
    
    alertView=[self popAlertView];
    [self.view addSubview:alertView];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [alertView.layer addAnimation:popAnimation forKey:nil];
}


//隐藏
-(void)hiddenShow
{
    [alertView removeFromSuperview];
    
}


//分享
-(void)showRight1
{
    
    //NSLog(@"share");
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        [self show];
    }
    
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==20)
    {
        [self hiddenShow];
    }
    else if (sender.tag==21)
    {
        [self hiddenShow];
        
        if ([QQApi isQQInstalled])
        {
            //设置分享的点击跳转
            [UMSocialData defaultData].extConfig.qzoneData.url = [stationInfo objectForKey:@"shareUrl"];//分享链接
            
            [UMSocialData defaultData].extConfig.qzoneData.title = @" ";
            
            [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToQzone] content:[NSString stringWithFormat:@"%@\n%@\n",[stationInfo objectForKey:@"name"],[stationInfo objectForKey:@"address"]] image:[NSData dataWithContentsOfURL:[NSURL URLWithString:[stationInfo objectForKey:@"half_img"]]] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
                if (response.responseCode == UMSResponseCodeSuccess) {
                    // NSLog(@"分享成功！");
                }
            }];
        }
        else
        {
            [self alertOnly:@"您未安装QQ客户端"];
        }
    }
    else if (sender.tag==22)
    {
        //新浪微博
        //使用UMShareToSina直接分享到新浪微博
        [self hiddenShow];
        
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToSina] content:[NSString stringWithFormat:@"%@\n%@\n",[stationInfo objectForKey:@"name"],[stationInfo objectForKey:@"address"]] image:[NSData dataWithContentsOfURL:[NSURL URLWithString:[stationInfo objectForKey:@"half_img"]]] location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            
            // NSLog(@"分享：%d",response.responseCode);
            
            if (response.responseCode == UMSResponseCodeSuccess) {
                
                //NSLog(@"分享成功！：%d",response.responseCode);
                
                [self alertOnly:@"分享成功"];
            }
        }];
        
    }
    else if (sender.tag==23)
    {
        [self hiddenShow];
        
        //微信朋友圈
        //在分享代码前设置微信分享应用类型，用户点击消息将跳转到应用，或者到下载页面
        //UMSocialWXMessageTypeImage 为纯图片类型
        //[UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeApp;
        //分享图文样式到微信朋友圈显示字数比较少，只显示分享标题
        //[UMSocialData defaultData].extConfig.title = @"安车信";
        //[UMSocialData defaultData].extConfig.wxMessageType = UMSocialWXMessageTypeImage;
        
        //设置微信好友或者朋友圈的分享url,下面是微信好友，微信朋友圈对应wechatTimelineData
        [UMSocialData defaultData].extConfig.wechatTimelineData.url = [stationInfo objectForKey:@"shareUrl"];
        
        //直接分享到微信
        //使用UMShareToWechatSession,UMShareToWechatTimeline,UMShareToWechatFavorite分别代表微信好友、微信朋友圈、微信收藏
        [[UMSocialDataService defaultDataService]  postSNSWithTypes:@[UMShareToWechatTimeline] content:[NSString stringWithFormat:@"%@\n%@\n",[stationInfo objectForKey:@"name"],[stationInfo objectForKey:@"address"]]  image:[NSData dataWithContentsOfURL:[NSURL URLWithString:[stationInfo objectForKey:@"half_img"]]]  location:nil urlResource:nil presentedController:self completion:^(UMSocialResponseEntity *response){
            if (response.responseCode == UMSResponseCodeSuccess) {
                // NSLog(@"分享成功！");
            }
        }];
        
        
    }
    else if (sender.tag==121)
    {
        //微信支付
        //NSLog(@"微信支付");
        [self hiddenShow];
        
    }
    else if (sender.tag==122)
    {
        [self hiddenShow];
        //支付宝支付
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            [ToolLen ShowWaitingView:YES];
            requestTimes=10;
            
            NSMutableString *payCode=[[NSMutableString alloc]initWithCapacity:0];
            
            for (int i=0; i<chooseArray.count; i++)
            {
                [payCode appendString:[[chooseArray objectAtIndex:i] objectForKey:@"code"]];
                if (i<chooseArray.count-1) {
                    [payCode appendString:@","];
                }
            }
            
            [[self JsonFactory] addOrder:[stationInfo objectForKey:@"repairstationid"] serviceList:payCode paySource:@"1" action:@"addOrder"];
        }
    }

}

-(void)refreshProduct:(NSNotification *)productObject
{
   // NSLog(@"productObject:%@",productObject.object);
    
    chooseArray=[[NSArray alloc] initWithArray:productObject.object];
    appendString=[[NSMutableString alloc]initWithCapacity:0];
    
    for (int i=0; i<chooseArray.count; i++)
    {
        [appendString appendString:[[chooseArray objectAtIndex:i] objectForKey:@"name"]];
        if (i<chooseArray.count-1) {
            [appendString appendString:@","];
        }
        
    }
    
    [shopTableView reloadData];

}

//支付成功的回调
-(void)refreshPay
{
    //进入我的订单列表
    MyOrderViewController *myorder=[[MyOrderViewController alloc] init];
    myorder.title=@"我的订单";
    myorder.state=0;
    myorder.selected=1;
    [self.navigationController pushViewController:myorder animated:YES];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshProduct:) name:@"refreshProduct" object:nil];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshPay) name:@"refreshPay" object:nil];
    
    
    //收藏
    if ([[stationInfo objectForKey:@"haveCollected"] intValue]==0)//未收藏
    {
        image1=IMAGE(@"icon14");
    }
    else
    {
        image1=IMAGE(@"collectIcon14");
    }
    btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 40,40);
    [btn setBackgroundImage:image1 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showRight) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    //self.navigationItem.rightBarButtonItem=backItem;
    
    //分享
    UIImage *image2=IMAGE(@"share");
    UIButton *btn2=[UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame=CGRectMake(40, 0, 25,25);
    [btn2 setBackgroundImage:image2 forState:UIControlStateNormal];
    [btn2 addTarget:self action:@selector(showRight1) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem2 = [[UIBarButtonItem alloc] initWithCustomView:btn2];
    
    self.navigationItem.rightBarButtonItems=[NSArray arrayWithObjects:backItem2,backItem, nil];
    
    //testStr=@"网上银行查询网在本文中提供邮政储蓄银行信用卡余额查询,邮政信用卡余额查询常见的几种方法,希望对你查中国邮政储蓄信用卡余额提供帮助 很多朋友在使用邮政信用卡的时候,不懂得怎么查询余额。那么邮政信用卡余额查询有什么方法?邮政信用卡余额怎么查询?下面由小编为大家介绍一下很多朋友在使用邮政信用卡的时候,不懂得怎么查询余额。那么邮政信用卡余额查询有什么方法?邮政信用卡余额怎么查询?下面由小编为大家介绍一下";
    testStr=@"网上银行查询网在本文中提";
    
    
    //收藏店铺修改状态
    collectInfo=[[NSMutableDictionary alloc] initWithDictionary:stationInfo];
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(0xf7f8f8);
    
    
    shopTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height)];
    shopTableView.tag=1;
    shopTableView.delegate=self;
    shopTableView.dataSource=self;
    shopTableView.backgroundView=nil;
    shopTableView.backgroundColor=[UIColor clearColor];
    shopTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    //shopTableView.contentInset = UIEdgeInsetsMake(180, 0, 0, 0);
    [mainView addSubview:shopTableView];

    [self.view addSubview:mainView];
    
   // [ToolLen ShowWaitingView:YES];
    requestTimes=1;
    [[self JsonFactory] getNewServiceListByStation:[stationInfo objectForKey:@"repairstationid"]  action:@"getStation"];
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        receiveDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        
        [shopTableView reloadData];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==3)
    {
        image1=IMAGE(@"collectIcon14");
        [btn setBackgroundImage:image1 forState:UIControlStateNormal];
        [collectInfo removeObjectForKey:@"haveCollected"];
        [collectInfo setObject:@"1" forKey:@"haveCollected"];
        
        [self alertOnly:@"收藏成功"];
        
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==4)
    {
        image1=IMAGE(@"icon14");
        [btn setBackgroundImage:image1 forState:UIControlStateNormal];
        [collectInfo removeObjectForKey:@"haveCollected"];
        [collectInfo setObject:@"0" forKey:@"haveCollected"];
        
        [self alertOnly:@"取消收藏"];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==10)
    {
        payInfo=[[NSDictionary alloc] initWithDictionary:responseObject];
        [self pay];//支付
    }
     
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 5;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0:
        {
            return 130.0;
            break;
        }
        case 1:
        {
            /*
            NSString *LabelString=[NSString stringWithFormat:@"%@",[receiveDic objectForKey:@"description"]];
            CGSize constraint = CGSizeMake(290.0, 20000.0f);
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
            CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            CGFloat height = MAX(size.height, 30.0f);
            
            return 20+50+height+10+140+5;
             */
            
            int count=[[receiveDic objectForKey:@"descriptionList"] count];//描述
            
            if (count==0)
            {
                return 20+40+35+140;
            }
            else if (count==3)
            {
                return 280.0;
            }
            else
            {
                return 60+35*count+140;
            }
            
            break;
        }
        case 2:
        {
            if (chooseArray.count>0)
            {
                 return 210.0;
            }
            else
            {
                return 120.0;
            }
           
            break;
        }
        case 3:
        {
            if ([[receiveDic objectForKey:@"activity"] count]>0)
            {
                return 160.0;
            }
            else
            {
                return 120.0;
            }
            
            break;
        }
        case 4:
        {
            NSString *LabelString=[[receiveDic objectForKey:@"stationComment"] objectForKey:@"content"];
            CGSize constraint = CGSizeMake(290.0, 20000.0f);
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
            CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            CGFloat height = MAX(size.height, 30.0f);
            
            //NSLog(@"111111:%f",20+40+30+height+10);
            return 20+40+30+height+10;
            //return 120.0;
            break;
        }
            
        default:
            break;
    }
    
    return 0.0;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    switch (indexPath.row)
    {
        case 0://维修站信息
        {
            static NSString *cellIndefiner=@"Station1Cell";
            Station1Cell *cell=(Station1Cell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"Station1Cell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            //维修站图片
           // [cell.shopImg setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[stationInfo objectForKey:@"half_img"]]] placeholderImage:nil];
            [cell.shopImg sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[stationInfo objectForKey:@"half_img"]]] placeholderImage:nil];
            [cell.shopBtn addTarget:self action:@selector(clickPicMore) forControlEvents:UIControlEventTouchUpInside];//点击图片查看更多图片
            //店铺的张图数
            [cell.pageNumLabel setText:[NSString stringWithFormat:@"%d 张",[[stationInfo objectForKey:@"imgcount"]intValue]]];
            //店铺名称
            [cell.shopNameLabel setText:[stationInfo objectForKey:@"name"]];
            //店铺星级
            float temp=[[stationInfo objectForKey:@"avg_comment"] floatValue]*100.0+0.5;
            int m=temp/20;
            //NSLog(@"m::%d",m);
            for (int i=0; i<m; i++)
            {
                UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20*i, 0, 20, 20)];
                starImageView.image=IMAGE(@"commet");
                [cell.starView addSubview:starImageView];
            }
            
            //店铺电话
            [cell.shopPhoneLabel setText:[stationInfo objectForKey:@"phone"]];
            [cell.shopPhoneBtn addTarget:self action:@selector(clickPhoneBtn) forControlEvents:UIControlEventTouchUpInside];
            
            //店铺地址
            NSString *LabelString=[stationInfo objectForKey:@"address"];
            CGSize constraint = CGSizeMake(170.0, 20000.0f);
            NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
            CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
            
            CGFloat height = MAX(size.height, 19.0f);
            //NSLog(@"height::%f",height);
            cell.shopAddressLabel.frame=CGRectMake(139, 69, 170, height);
            cell.shopAddressLabel.numberOfLines=0;
            cell.shopAddressLabel.lineBreakMode=NSLineBreakByWordWrapping;
            cell.shopAddressLabel.font=[UIFont systemFontOfSize:13.0];
            cell.shopAddressLabel.text=[stationInfo objectForKey:@"address"];
            //[cell.shopAddressLabel setText:[stationInfo objectForKey:@"address"]];
            [cell.shopAddressBtn addTarget:self action:@selector(clickAddressBtn) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
            break;
        }
        case 1://本店擅长/特色
        {
            static NSString *cellIndefiner=@"Station2Cell";
            Station2Cell *cell=(Station2Cell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"Station2Cell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            //质保
            [cell.zhibaoBtn addTarget:self action:@selector(zhibaoBtn) forControlEvents:UIControlEventTouchUpInside];
        
           // CGFloat height=0.0;
            if (receiveDic)
            {
                /*
                //店铺描述
                NSString *LabelString=[NSString stringWithFormat:@"%@",[receiveDic objectForKey:@"description"]];
                CGSize constraint = CGSizeMake(290.0, 20000.0f);
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
                CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                
                height = MAX(size.height, 30.0f);
                //NSLog(@"height::%f",height);
                cell.layerView.frame=CGRectMake(0, 20, WIDTH, 50+height+10+140+5);
                cell.layerView.backgroundColor=[UIColor whiteColor];
                
                cell.shopDesLabel.frame=CGRectMake(15, 50, 290, height+10);
                cell.shopDesLabel.numberOfLines=0;
                cell.shopDesLabel.lineBreakMode=NSLineBreakByWordWrapping;
                cell.shopDesLabel.font=[UIFont systemFontOfSize:13.0];
                cell.shopDesLabel.text=LabelString;
                
                cell.scoreView.frame=CGRectMake(10, height+10+50, WIDTH-20, 140);
                 */
                
                
                
                for (int i=0; i<[[receiveDic objectForKey:@"descriptionList"] count]; i++)
                {
                    if (i==0)
                    {
                         cell.shopDesLabel.text=[NSString stringWithFormat:@"● %@",[[receiveDic objectForKey:@"descriptionList"]objectAtIndex:0]];
                    }
                    else if (i==1)
                    {
                        cell.shopDesLabel1.text=[NSString stringWithFormat:@"● %@",[[receiveDic objectForKey:@"descriptionList"]objectAtIndex:1]];
                    }
                    else
                    {
                        cell.shopDesLabel2.text=[NSString stringWithFormat:@"● %@",[[receiveDic objectForKey:@"descriptionList"]objectAtIndex:2]];
                    }
                }
            }
            
            if ([[receiveDic objectForKey:@"descriptionList"] count]==0)
            {
                cell.scoreView.frame=CGRectMake(10, 40+35, 300, 140);
                
                cell.shopDesLabel.text=@"暂无店面说明";
            }
            else if([[receiveDic objectForKey:@"descriptionList"] count]==3)
            {
                cell.scoreView.frame=CGRectMake(10, 40+80, 300, 140);
            }
            else
            {
                cell.scoreView.frame=CGRectMake(10, 40+35*[[receiveDic objectForKey:@"descriptionList"] count], 300, 140);
            }
            
            cell.layerView.frame=CGRectMake(0, 20, WIDTH, cell.scoreView.frame.size.height+cell.scoreView.frame.origin.y);
            cell.layerView.backgroundColor=[UIColor whiteColor];
            
            /*
            UILabel *desLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 10, 280, height+10)];
            [desLabel setNumberOfLines:0];//将label的行数设置为0，可以自动适应行数
            [desLabel setLineBreakMode:NSLineBreakByWordWrapping];//label可换行
            [desLabel setFont:[UIFont systemFontOfSize:15.0]];//字体设置为14号
            [desLabel setTag:indexPath.row];
            desLabel.text=LabelString;
            */
            
           
            
            if (receiveDic)
            {
                //技术水平
                cell.jishuLabel.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"technologyComment"]];
                if ([[receiveDic objectForKey:@"technologyComment"] intValue]<=40)
                {
                    cell.jishuImg.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"technologyComment"] intValue]<=70)
                {
                    cell.jishuImg.image=IMAGE(@"station2");
                }
                else
                {
                    cell.jishuImg.image=IMAGE(@"station1");
                }
                
                //硬件质量
                cell.yingjianLabel.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"hardComment"]];
                if ([[receiveDic objectForKey:@"hardComment"] intValue]<=40)
                {
                    cell.yingjianImg.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"hardComment"] intValue]<=70)
                {
                    cell.yingjianImg.image=IMAGE(@"station2");
                }
                else
                {
                    cell.yingjianImg.image=IMAGE(@"station1");
                }
                
                //门店环境
                cell.mendianLabel.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"envinmentComment"]];
                if ([[receiveDic objectForKey:@"envinmentComment"] intValue]<=40)
                {
                    cell.mendianImg.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"envinmentComment"] intValue]<=70)
                {
                    cell.mendianImg.image=IMAGE(@"station2");
                }
                else
                {
                    cell.mendianImg.image=IMAGE(@"station1");
                }
                
                //服务质量
                cell.fuwuLabel.text=[NSString stringWithFormat:@"%@分",[receiveDic objectForKey:@"serviceComment"]];
                if ([[receiveDic objectForKey:@"serviceComment"] intValue]<=40)
                {
                    cell.fuwuImg.image=IMAGE(@"station3");
                }
                else if ([[receiveDic objectForKey:@"serviceComment"] intValue]<=70)
                {
                    cell.fuwuImg.image=IMAGE(@"station2");
                }
                else
                {
                    cell.fuwuImg.image=IMAGE(@"station1");
                }

            }
            /*
            UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 20+height+10+50+140+4, WIDTH, 1)];
            lineLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
            [cell.contentView addSubview:lineLabel];
            */
            
            return cell;
            
            break;
        }
        case 2://产品/套餐
        {
            static NSString *cellIndefiner=@"Station3Cell";
            Station3Cell *cell=(Station3Cell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"Station3Cell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            cell.layerView.backgroundColor=[UIColor whiteColor];
            [cell.taocanBtn addTarget:self action:@selector(productPackage) forControlEvents:UIControlEventTouchUpInside];
            
            if (chooseArray.count>0)
            {
                cell.subView.hidden=NO;
                cell.layerView.frame=CGRectMake(0, 20, WIDTH, 190);
                cell.chooseNumLabel.text=[NSString stringWithFormat:@"您已经选择了%lu项套餐",(unsigned long)chooseArray.count];
                
                
                NSString *LabelString=[NSString stringWithFormat:@"%@",appendString];
                CGSize constraint = CGSizeMake(290.0, 20000.0f);
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
                CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                
                CGFloat height = MAX(size.height, 30.0f);
               
                cell.chooseNameLabel.frame=CGRectMake(15, 60, 290, height+10);
                cell.chooseNameLabel.numberOfLines=0;
                cell.chooseNameLabel.lineBreakMode=NSLineBreakByWordWrapping;
                cell.chooseNameLabel.font=[UIFont systemFontOfSize:13.0];
                cell.chooseNameLabel.text=LabelString;
                
                //cell.youhuiDesLabel.text=@"";
                int total=0;
                if (chooseArray)
                {
                    for (int i=0; i<[chooseArray count]; i++)
                    {
                        //计算总价格
                        total=total+[[[chooseArray objectAtIndex:i]objectForKey:@"price"]intValue];
                    }
                    cell.shopPayLabel.text=[NSString stringWithFormat:@"¥%d",total];
                }
                
               // cell.youhuiDesLabel.text=[NSString stringWithFormat:@"在线支付立减%d折",(int)([[receiveDic objectForKey:@"discount"]floatValue]*100)];
                
                //线上付款金额
                cell.linePayLabel.text=[NSString stringWithFormat:@"¥%d",(int)(total*[[receiveDic objectForKey:@"discount"]floatValue])];
                
                //总价
                payCountPrice=(int)(total*[[receiveDic objectForKey:@"discount"]floatValue]);
                
                //预约按钮
                [cell.orderBtn addTarget:self action:@selector(shopOrder) forControlEvents:UIControlEventTouchUpInside];
                
                //线上付款按钮
                [cell.linePayBtn addTarget:self action:@selector(linePay) forControlEvents:UIControlEventTouchUpInside];
                
                cell.subView.frame=CGRectMake(0, 110, WIDTH, 80);
                UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 209, WIDTH, 1)];
                lineLabel.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
                [cell.contentView addSubview:lineLabel];
            }
            else
            {
                /*
                cell.youhuiDesLabel.hidden=YES;
                cell.shopPayLabel.hidden=YES;
                cell.shopPayBtn.hidden=YES;
                cell.linePayLabel.hidden=YES;
                cell.linePayBtn.hidden=YES;
                */
                cell.subView.hidden=YES;
                
                /*
                UIButton *onlineOrder=[UIButton buttonWithType:UIButtonTypeCustom];
                onlineOrder.frame=CGRectMake(20, 150, 120, 35);
                [onlineOrder setBackgroundImage:IMAGE(@"orderOnLinePay") forState:UIControlStateNormal];
                [onlineOrder addTarget:self action:@selector(productPackage) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:onlineOrder];
                
                
                UIButton *order=[UIButton buttonWithType:UIButtonTypeCustom];
                order.frame=CGRectMake(180, 150, 120, 35);
                [order setBackgroundImage:IMAGE(@"orderOnLine") forState:UIControlStateNormal];
                [order addTarget:self action:@selector(shopPay) forControlEvents:UIControlEventTouchUpInside];
                [cell.contentView addSubview:order];
                 */
                
                
                //店铺地址
                NSString *LabelString=[NSString stringWithFormat:@"本店产品明码标价,在线支付立享%d折,同时享受安车信提供的7天质量担保。",(int)([[receiveDic objectForKey:@"discount"]floatValue]*100)];
                CGSize constraint = CGSizeMake(290.0, 20000.0f);
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:16.0]};
                CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                
                CGFloat height = MAX(size.height, 19.0f);
                //NSLog(@"height::%f",height);
            
                cell.chooseNumLabel.textColor=kUIColorFromRGB(0xffae00);
                cell.chooseNumLabel.font=[UIFont systemFontOfSize:16.0];
                cell.chooseNumLabel.frame=CGRectMake(15, 50, 290, height);
                cell.chooseNumLabel.numberOfLines=0;
                cell.chooseNumLabel.lineBreakMode=NSLineBreakByWordWrapping;
                cell.chooseNumLabel.text=[NSString stringWithFormat:@"本店产品明码标价,在线支付立享%d折,同时享受安车信提供的7天质量担保。",(int)([[receiveDic objectForKey:@"discount"]floatValue]*100)];
                
                
                UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 119, WIDTH, 1)];
                lineLabel.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
                [cell.contentView addSubview:lineLabel];

            }
            
            return cell;
            
            break;
        }
        case 3://活动
        {
            static NSString *cellIndefiner=@"Station4Cell";
            Station4Cell *cell=(Station4Cell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"Station4Cell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            if ([[receiveDic objectForKey:@"activity"] count]>0)
            {
                cell.activityView.hidden=NO;
                cell.arrowImg.hidden=NO;
                //点击进入活动列表
                [cell.activityBtn addTarget:self action:@selector(clickActivityBtn) forControlEvents:UIControlEventTouchUpInside];
                //活动图像
                //[cell.activityIcon setImageWithURL:[NSURL URLWithString:[[receiveDic objectForKey:@"activity"]objectForKey:@"imagePath"] ]placeholderImage:nil];
                [cell.activityIcon sd_setImageWithURL:[NSURL URLWithString:[[receiveDic objectForKey:@"activity"]objectForKey:@"imagePath"] ]placeholderImage:nil];
                
                cell.activityNameLabel.text=[[receiveDic objectForKey:@"activity"]objectForKey:@"title"];
                
                
                [cell.contentView addSubview:[self customLabel:CGRectMake(125, 120, 50, 30) color:[UIColor orangeColor] text:[NSString stringWithFormat:@"¥%@",[[receiveDic objectForKey:@"activity"] objectForKey:@"discountPrice"] ] alignment:-1 font:Font_60pt]];
                
                [cell.contentView addSubview:[self customLabel:CGRectMake(10+100+10+70, 125, 40, 20) color:[UIColor grayColor] text:[NSString stringWithFormat:@"¥%@",[[receiveDic objectForKey:@"activity"] objectForKey:@"marketPrice"] ] alignment:-1 font:Font_48pt]];
                
                [cell.contentView addSubview:[self drawLine:CGRectMake(10+100+10+70, 135, [[NSString stringWithFormat:@"¥%@",[[receiveDic objectForKey:@"activity"] objectForKey:@"marketPrice"]]length]*10, 1) drawColor:[UIColor lightGrayColor]]];
                
                
                /*
                cell.activityDesLabel.text=[[receiveDic objectForKey:@"activity"]objectForKey:@"summary"];
                cell.activityZheLabel.text=[[receiveDic objectForKey:@"activity"]objectForKey:@"discountDescription"];
                */
                
                //点击进入单个活动内容
                [cell.activitySingleBtn addTarget:self action:@selector(clickActivitySingleBtn) forControlEvents:UIControlEventTouchUpInside];

                
            }
            else
            {
                cell.activityView.hidden=YES;
                cell.arrowImg.hidden=YES;
                UIView *cusView=[[UIView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, 60)];
                cusView.backgroundColor=[UIColor whiteColor];
                
                UILabel *tishiLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
                tishiLabel.backgroundColor=[UIColor clearColor];
                tishiLabel.textAlignment=NSTextAlignmentLeft;
                tishiLabel.text=@"暂无活动内容";
                tishiLabel.textColor=[UIColor blackColor];
                tishiLabel.font=[UIFont systemFontOfSize:15.0];
                [cusView addSubview:tishiLabel];
                UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59, WIDTH, 1)];
                lineLabel.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
                [cusView addSubview:lineLabel];
                
                [cell.contentView addSubview:cusView];
                
            }
            
            
            return cell;
            
            break;
        }
        case 4://客户评价
        {
            static NSString *cellIndefiner=@"Station5Cell";
            Station5Cell *cell=(Station5Cell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
            
            if (cell==nil)
            {
                NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"Station5Cell" owner:self options:nil];
                cell=[xib objectAtIndex:0];
                
                [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            }
            
            if ([[receiveDic objectForKey:@"stationComment"] count]>0)
            {
                
                cell.disscussView.hidden=NO;
                
                cell.disscussNameLabel.text=[NSString stringWithFormat:@"%@xxxx%@",[[[receiveDic objectForKey:@"stationComment"] objectForKey:@"mobile"] substringToIndex:4],[[[receiveDic objectForKey:@"stationComment"] objectForKey:@"mobile"] substringFromIndex:8]];
                
                int m=[[[receiveDic objectForKey:@"stationComment"]objectForKey:@"satisfaction"] intValue];
                // NSLog(@"m::%d",m);
                for (int i=0; i<m; i++)
                {
                    UIImageView *starImageView=[[UIImageView alloc] initWithFrame:CGRectMake(100+16*i, 55+10, 20, 20)];
                    starImageView.image=IMAGE(@"commet");
                    [cell.contentView addSubview:starImageView];
                }
                
                cell.disscussTimeLabel.text=[[[receiveDic objectForKey:@"stationComment"] objectForKey:@"create_time"] substringToIndex:10];
                
                NSString *LabelString=[[receiveDic objectForKey:@"stationComment"] objectForKey:@"content"];
                CGSize constraint = CGSizeMake(290.0, 20000.0f);
                NSDictionary *attribute = @{NSFontAttributeName: [UIFont systemFontOfSize:13.0]};
                CGSize size = [LabelString boundingRectWithSize:constraint options: NSStringDrawingTruncatesLastVisibleLine | NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:attribute context:nil].size;
                
                CGFloat height = MAX(size.height, 30.0f);
                //NSLog(@"height::%f",height);
                
                // cell.frame=CGRectMake(0, 0, WIDTH, 20+40+30+height+10);
                // cell.backgroundColor=[UIColor blackColor];
                cell.disscussView.frame=CGRectMake(0, 60, WIDTH, 30+height+10);
                cell.disscussView.backgroundColor=[UIColor whiteColor];
                
                cell.disscussContentLabel.frame=CGRectMake(15, 0, 290, height+10+50);
                cell.disscussContentLabel.numberOfLines=0;
                cell.disscussContentLabel.lineBreakMode=NSLineBreakByWordWrapping;
                cell.disscussContentLabel.font=[UIFont systemFontOfSize:13.0];
                cell.disscussContentLabel.text=LabelString;
                
                UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 20+40+30+height+10-1, WIDTH, 1)];
                lineLabel.backgroundColor=[UIColor colorWithRed:241/255.0 green:241/255.0 blue:241/255.0 alpha:1.0];
                [cell.contentView addSubview:lineLabel];
            }
            else
            {
                cell.disscussView.hidden=YES;
                
                /*
                UILabel *tishiLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 80, 200, 20)];
                tishiLabel.backgroundColor=[UIColor clearColor];
                tishiLabel.textAlignment=NSTextAlignmentLeft;
                tishiLabel.text=@"暂无评论消息";
                tishiLabel.textColor=[UIColor blackColor];
                tishiLabel.font=[UIFont systemFontOfSize:15.0];
                
                [cell.contentView addSubview:tishiLabel];
                */
                
                UIView *cusView=[[UIView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, 60)];
                cusView.backgroundColor=[UIColor whiteColor];
                
                UILabel *tishiLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 20, 200, 20)];
                tishiLabel.backgroundColor=[UIColor clearColor];
                tishiLabel.textAlignment=NSTextAlignmentLeft;
                tishiLabel.text=@"暂无评论消息";
                tishiLabel.textColor=[UIColor blackColor];
                tishiLabel.font=[UIFont systemFontOfSize:15.0];
                [cusView addSubview:tishiLabel];
                UILabel *lineLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 59, WIDTH, 1)];
                lineLabel.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
                [cusView addSubview:lineLabel];
                
                [cell.contentView addSubview:cusView];
            }
          
            
            //点击进入活动列表
            [cell.disscussBtn addTarget:self action:@selector(disscussBtn) forControlEvents:UIControlEventTouchUpInside];
            
            return cell;
            
            
            break;
        }
            
        default:
            break;
    }
    
    return nil;
}

//产品套餐
-(void)productPackage
{
    ProductPackageViewController *product=[[ProductPackageViewController alloc] init];
    product.title=@"产品套餐";
    product.stationInfo=stationInfo;
    product.chooseArray=chooseArray;//将选择的项目替换
    product.serviceListArray=[receiveDic objectForKey:@"serviceList"];
    
    [self.navigationController pushViewController:product animated:YES];
    
}


//预约
-(void)shopOrder
{
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        //NSLog(@"shopPay");
        OrderViewController *order=[[OrderViewController alloc] init];
        order.title=@"填写预约单";
        
        if (chooseArray)
        {
            order.orderArray=chooseArray;
        }
        
        order.stationId=[stationInfo objectForKey:@"repairstationid"];
        [self.navigationController pushViewController:order animated:YES];
    
    }

}


-(UIView *)popPayView
{
    UIView *popAlertView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    popAlertView.backgroundColor=[UIColor clearColor];
    //popAlertView.alpha=0.8;
    
    
    UIView *bgView=[[UIView alloc] initWithFrame:popAlertView.bounds];
    bgView.backgroundColor=[UIColor blackColor];
    bgView.alpha=0.4;
    [popAlertView addSubview:bgView];
    
    UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(20,120, 280, 140)];
    contentView.backgroundColor=[UIColor whiteColor];
    
    contentView.layer.cornerRadius = 8.0;//(值越大，角就越圆)
    contentView.layer.masksToBounds = YES;
    contentView.layer.borderWidth=2.0;
    contentView.layer.borderColor=[[UIColor clearColor] CGColor];
    /*
    contentView.layer.cornerRadius = 1.0f;
    contentView.layer.borderColor = [UIColor clearColor].CGColor;
    contentView.layer.borderWidth = 2.0f;
    */
    
    NSString *filePath = [[NSBundle mainBundle] pathForResource:@"UMSocialSDKResourcesNew.bundle/Buttons/UMS_shake_close_tap@2x" ofType:@"png" ];
    UIImageView *p=[[UIImageView alloc] initWithFrame:CGRectMake(240, 15, 20, 20)];
    p.image=[UIImage imageWithContentsOfFile:filePath];
    [contentView addSubview:p];
    [contentView addSubview:[self customButton:p.frame tag:20 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    [contentView addSubview:[self customLabel:CGRectMake(20, 40, 100, 20) color:[UIColor blackColor] text:@"支付方式：" alignment:-1 font:15.0]];
    NSString *filePath1 = [[NSBundle mainBundle] pathForResource:@"weixinPay" ofType:@"png" ];
    UIImageView *p1=[[UIImageView alloc] initWithFrame:CGRectMake(30, 80, 100, 32)];
    p1.image=[UIImage imageWithContentsOfFile:filePath1];
    [contentView addSubview:p1];
    [contentView addSubview:[self customButton:p1.frame tag:21+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    NSString *filePath2 = [[NSBundle mainBundle] pathForResource:@"zhifubaoPay" ofType:@"png" ];
    UIImageView *p2=[[UIImageView alloc] initWithFrame:CGRectMake(150, 80, 100, 32)];
    p2.image=[UIImage imageWithContentsOfFile:filePath2];
    [contentView addSubview:p2];
    [contentView addSubview:[self customButton:p2.frame tag:22+100 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    [popAlertView addSubview:contentView];
    
    return popAlertView;
}

//在线付
-(void)linePay
{
    /*
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        NSLog(@"linePay");
        OrderViewController *order=[[OrderViewController alloc] init];
        order.title=@"填写预约单";
        
        if (chooseArray || chooseArray.count>0)
        {
            order.orderArray=chooseArray;
        }
        
        order.stationId=[stationInfo objectForKey:@"repairstationid"];
        [self.navigationController pushViewController:order animated:YES];

    }
     */
    
    
    //NSLog(@"share");
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        [ToolLen ShowWaitingView:YES];
        requestTimes=10;
        
        NSMutableString *payCode=[[NSMutableString alloc]initWithCapacity:0];
        
        for (int i=0; i<chooseArray.count; i++)
        {
            [payCode appendString:[[chooseArray objectAtIndex:i] objectForKey:@"code"]];
            if (i<chooseArray.count-1) {
                [payCode appendString:@","];
            }
        }
        
        [[self JsonFactory] addOrder:[stationInfo objectForKey:@"repairstationid"] serviceList:payCode paySource:@"1" action:@"addOrder"];
    }
    
     
     /*
    
    //self.STAlertView.center = self.view.center;
    [alertView removeFromSuperview];
    
    alertView=[self popPayView];
    [self.view addSubview:alertView];
    CAKeyframeAnimation *popAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    popAnimation.duration = 0.4;
    popAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(0.01f, 0.01f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                            [NSValue valueWithCATransform3D:CATransform3DIdentity]];
    popAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f, @1.0f];
    popAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                     [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    
    [alertView.layer addAnimation:popAnimation forKey:nil];
     */
    
  
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//点击查看更多图片
-(void)clickPicMore
{
    //NSLog(@"点击查看更多图片");
    //点击图片
    StationImgViewController *img=[[StationImgViewController alloc] init];
    img.title=@"图片展示";
    img.stationId=[stationInfo objectForKey:@"repairstationid"];
    [self.navigationController pushViewController:img animated:YES];
}

//点击拨打电话
-(void)clickPhoneBtn
{
    //NSLog(@"点击拨打电话");
    
    UIWebView*callWebview =[[UIWebView alloc] init] ;
    NSString *phoneNumber=[stationInfo objectForKey:@"phone"];
    NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",phoneNumber]];
    [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
    [self.view addSubview:callWebview];
}

//点击查看地图
-(void)clickAddressBtn
{
    //NSLog(@"点击查看地图");
    //地理位置
    MapViewController *address=[[MapViewController alloc] init];
    address.title=@"维修站位置";
    //address.stationId=[stationInfo objectForKey:@"repairstationid"];
    address.stationInfo=stationInfo;
    [self.navigationController pushViewController:address animated:YES];
}

//质保
-(void)zhibaoBtn
{
    //NSLog(@"zhibaoBtn");
}

//点击进入列表
-(void)clickActivityBtn
{
    //NSLog(@"点击进入活动列表");
    ActivityListViewController *list=[[ActivityListViewController alloc] init];
    list.title=@"活动列表";
    list.searchString=[stationInfo objectForKey:@"repairstationid"];
    list.type=4;//表明是从维修详情列表进入的
    [self.navigationController pushViewController:list animated:YES];
    
}


//点击进入单个内容
-(void)clickActivitySingleBtn
{
    ActivitiyInfoViewController *info=[[ActivitiyInfoViewController alloc] init];
    info.activityInfo=[receiveDic objectForKey:@"activity"];

    [self.navigationController pushViewController:info animated:YES];
    
}

//点击进入评论列表
-(void)disscussBtn
{
    DisscussListViewController *list=[[DisscussListViewController alloc] init];
    list.title=@"评论列表";
    list.stationInfo=stationInfo;
    [self.navigationController pushViewController:list animated:YES];
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



//wap回调函数
-(void)paymentResult:(NSString *)resultd
{
    //结果处理
    AlixPayResult * result = [[AlixPayResult alloc] initWithString:resultd];
    //NSLog(@"result::%@",result);
    
    if (result)
    {
        if (result.statusCode == 9000)
        {
            /*
             *用公钥验证签名 严格验证请使用result.resultString与result.signString验签
             */
            //交易成功
            NSString* key =AlipayPubKey;//签约帐户后获取到的支付宝公钥
            id<DataVerifier> verifier;
            verifier = CreateRSADataVerifier(key);
            if ([verifier verifyString:result.resultString withSign:result.signString])
            {
                //验证签名成功，交易结果无篡改
                [self refreshPay];
            }
        }
        else
        {
            //交易失败
        }
    }
    else
    {
        //失败
    }
    
}


-(void)pay
{
    NSString *appScheme=nil;
    
    appScheme = @"anchexinPay";//在plist中设置的回调地址
    
    NSString* orderInfo = [self getOrderInfo];//订单
    // NSLog(@"orderInfo:%@",orderInfo);
    
    NSString* signedStr = [self doRsa:orderInfo];
    //NSLog(@"signedStr:%@",signedStr);
    
    NSString *orderString = [NSString stringWithFormat:@"%@&sign=\"%@\"&sign_type=\"%@\"",
                             orderInfo, signedStr, @"RSA"];
    
    // NSLog(@"order:%@",orderString);
    [AlixLibService payOrder:orderString AndScheme:appScheme seletor:@selector(paymentResult:) target:self];
    
}

-(NSString*)getOrderInfo
{
    /*
     *点击获取prodcut实例并初始化订单信息
     */
    AlixPayOrder *order = [[AlixPayOrder alloc] init];
    order.partner = PartnerID;
    order.seller = SellerID;
    order.tradeNO = [payInfo objectForKey:@"orderNo"]; //订单ID（由商家自行制定）
    order.productName = [payInfo objectForKey:@"title"]; //商品标题
    order.productDescription=[payInfo objectForKey:@"description"]; //商品描述
    order.amount = [NSString stringWithFormat:@"%d",payCountPrice]; //商品价格
    order.notifyURL =  [payInfo objectForKey:@"url"]; //回调URL
    
    return [order description];
}

-(NSString*)doRsa:(NSString*)orderInfo
{
    id<DataSigner> signer;
    signer = CreateRSADataSigner(PartnerPrivKey);
    NSString *signedString = [signer signString:orderInfo];
    return signedString;
}



// 构造订单参数列表
- (NSDictionary *)getProductArgs
{
    //self.timeStamp = [self genTimeStamp];   // 获取时间戳
    //self.nonceStr = [self genNonceStr];     // 获取32位内的随机串, 防重发
    //self.traceId = [self genTraceId];       // 获取商家对用户的唯一标识
    
    NSMutableDictionary *params = [NSMutableDictionary dictionary];
    
    //[params setObject:WXAppId forKey:@"appid"];//公众账号ID
    //?[params setObject:WXAppKey forKey:@"appkey"];
    //[params setObject:self.timeStamp forKey:@"noncestr"];//随机字符串
    //?[params setObject:self.timeStamp forKey:@"timestamp"];
   // [params setObject:self.traceId forKey:@"traceid"];
    //[params setObject:[self genPackage] forKey:@"package"];
   // [params setObject:[self genSign:params] forKey:@"app_signature"];
   // [params setObject:@"sha1" forKey:@"sign_method"];
    
    return params;
}



-(void)weixinPay
{
    
    //拼接详细的订单数据
   // NSDictionary *postDict = [self getProductArgs];
    
    //NSLog(@"postDict::%@",postDict);
    
 
    PayReq *request = [[PayReq alloc] init];
    
    /** 商家向财付通申请的商家id */
    request.partnerId = @"10000100";
    /** 预支付订单 */
    request.prepayId= @"1101000000140415649af9fc314aa427";
    /** 商家根据财付通文档填写的数据和签名 */
    request.package = @"prepay_id=1101000000140415649af9fc314aa427";
    /** 随机串，防重发 */
    request.nonceStr= @"a462b76e7436e98e0ed6e13c64b4fd1c";
    /** 时间戳，防重发 */
    request.timeStamp=1397527777;
    /** 商家根据微信开放平台文档对数据做的签名 */
    request.sign= @"582282d72dd2b03ad892830965f428cb16e7a256";
    
    [WXApi sendReq:request];
    
}




@end
