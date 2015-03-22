//
//  HomeViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "HomeViewController.h"

@interface HomeViewController ()

@end

@implementation HomeViewController
@synthesize homeTableView;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//展示
- (void)show
{
    //self.STAlertView.center = self.view.center;
    popView=[self popAlertView];
    [self.view addSubview:popView];
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
    
    [popView.layer addAnimation:popAnimation forKey:nil];
}


//隐藏
-(void)hiddenShow
{
    /*
    CAKeyframeAnimation *hideAnimation = [CAKeyframeAnimation animationWithKeyPath:@"transform"];
    hideAnimation.duration = 0.4;
    hideAnimation.values = @[[NSValue valueWithCATransform3D:CATransform3DMakeScale(1.1f, 1.1f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.9f, 0.9f, 1.0f)],
                             [NSValue valueWithCATransform3D:CATransform3DMakeScale(0.3f, 0.3f, 0.00f)],[NSValue valueWithCATransform3D:CATransform3DIdentity]];
    hideAnimation.keyTimes = @[@0.2f, @0.5f, @0.75f ,@1.0f];
    hideAnimation.timingFunctions = @[[CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut],
                                      [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut]];
    hideAnimation.delegate = self;
    [popView.layer addAnimation:hideAnimation forKey:nil];
    
     */
    
     [popView removeFromSuperview];
}

/*
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag
{
    
    [popView removeFromSuperview];
    
}
*/






-(void)tab_More
{
    if (![AppDelegate setGlobal].token)
    {
        [self alertLogin];
    }
    else
    {
        [[AppDelegate setGlobal].rootController showLeftController:YES];
    }
  

}


-(void)homeSkin
{
    /*
    NSString *png=[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultBackground"];
    if (png)
    {
        backgroundView.image = IMAGE(png);
    }
    else
    {
        backgroundView.image = IMAGE(@"bg_1");
    }
     */
    
    
   // backgroundView=[[ANBlurredImageView alloc] initWithFrame:self.view.bounds];
    NSString *png=[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultBackground"];
    if (png)
    {
        backgroundView.image = IMAGE(png);
    }
    else
    {
        backgroundView.image = IMAGE(@"bg_1");
    }
    
    [backgroundView refreshLayout:backgroundView.image];
    
}

-(void)viewWillAppear:(BOOL)animated
{
   
}


-(void)initUI
{
    //导航栏上的更多按钮
    UIImage *image=IMAGE(@"tab_more");//返回按钮的背景
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 25,25);
    [btn setBackgroundImage:image forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(tab_More) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    self.navigationItem.leftBarButtonItem=backItem;
    
    
    requestTimes=1;
    if (userDic)
    {
        [ToolLen ShowWaitingView:YES];
        [[self JsonFactory] get_login:[userDic objectForKey:@"mobile"] secret: [[NSUserDefaults standardUserDefaults]objectForKey:@"checkCode"] action:@"login"];//登录
    }
    else
    {
        //体验账户
        [ToolLen ShowWaitingView:YES];
        [[self JsonFactory] test:nil action:@"getInvalidUser"];
        
    }
 
    
    if (homeTableView)
    {
        [homeTableView removeObserver:self forKeyPath: @"contentOffset"];
        homeTableView=nil;
    }
    
    homeTableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, CGRectGetWidth(self.view.bounds),480+(iPhone5?88:0)) style:UITableViewStylePlain];
    homeTableView.tag=1;
    homeTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
   // homeTableView.dataSource = self;
   // homeTableView.delegate = self;
    homeTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    homeTableView.separatorColor = [UIColor clearColor];
    homeTableView.backgroundColor = [UIColor clearColor];
    homeTableView.showsHorizontalScrollIndicator=NO;
    homeTableView.showsVerticalScrollIndicator=NO;
    homeTableView.scrollEnabled=NO;
    homeTableView.contentInset = UIEdgeInsetsMake((480+(iPhone5?88:0))*2, 0, 0, 0);
    
    backgroundView=[[ANBlurredImageView alloc] initWithFrame:self.view.bounds];
    NSString *png=[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultBackground"];
    if (png)
    {
        backgroundView.image = IMAGE(png);
    }
    else
    {
        backgroundView.image = IMAGE(@"bg_1");
    }
    
    [backgroundView setFramesCount:10];
    [backgroundView setBlurAmount:1];
    
    /*
    backgroundView = [[DKLiveBlurView alloc] initWithFrame:self.view.bounds];
    backgroundView.scrollView = homeTableView;
    backgroundView.isGlassEffectOn = YES;
    NSString *png=[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultBackground"];
    if (png)
    {
        backgroundView.originalImage = IMAGE(png);
    }
    else
    {
        backgroundView.originalImage = IMAGE(@"bg_1");
    }
    */
    
    homeTableView.backgroundView=backgroundView;
    
    [homeTableView setContentOffset:CGPointMake(0, -(480+(iPhone5?88:0))*2)];//定位
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, -(480+(iPhone5?88:0))*2, WIDTH, (480+(iPhone5?88:0)))];
    mainView.backgroundColor=[UIColor clearColor];
    
    
    //当前车辆图标
    carIconImageView=[[UIImageView alloc] initWithFrame:CGRectMake(10, 10, 50, 50)];
    if (carDic.count>0)
    {
        //[carIconImageView setImageWithURL:[NSURL URLWithString:[carDic objectForKey:@"iconimg"]] placeholderImage:nil];
        [carIconImageView sd_setImageWithURL:[NSURL URLWithString:[carDic objectForKey:@"iconimg"]] placeholderImage:nil];
    }
    [mainView addSubview:carIconImageView];
        
    //当前车辆车牌号
    carIconLabel=[[UILabel alloc] initWithFrame:CGRectMake(70, 25, 100, 20)];
    carIconLabel.backgroundColor=[UIColor clearColor];
    carIconLabel.textAlignment=NSTextAlignmentLeft;
    carIconLabel.textColor=[UIColor whiteColor];
    carIconLabel.font=[UIFont systemFontOfSize:15.0];
    if (carDic.count>0)
    {
        carIconLabel.text=[carDic objectForKey:@"license_number"];//@"沪A38H281";
    }
    [mainView addSubview:carIconLabel];
    
   
    /*
     carChooseListTableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 60, 300, 100)];
     carChooseListTableView.tag=2;
     carChooseListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
     carChooseListTableView.dataSource = self;
     carChooseListTableView.delegate = self;
     carChooseListTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
     carChooseListTableView.separatorColor = [UIColor clearColor];
     carChooseListTableView.backgroundColor = [UIColor clearColor];
     carChooseListTableView.showsHorizontalScrollIndicator=NO;
     carChooseListTableView.showsVerticalScrollIndicator=NO;
     carChooseListTableView.hidden=YES;
     carChooseListTableView.scrollEnabled=NO;
     [mainView addSubview:carChooseListTableView];
     */
    
    
    //下拉按钮图标
    UIImageView *pullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(280, 20, 25, 25)];
    pullImageView.image=IMAGE(@"pull");
    [mainView addSubview:pullImageView];
    UIButton *pullButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pullButton.frame=CGRectMake(270, 20, 50, 50);
    [pullButton addTarget:self action:@selector(pullOut) forControlEvents:UIControlEventTouchUpInside];
    [mainView addSubview:pullButton];
    
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 480+(iPhone5?88:0)-NavigationBar-250, WIDTH, 250+NavigationBar)];
    subView.backgroundColor=[UIColor clearColor];
    //subView.alpha=0.4;
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:subView.bounds];
    bgImageView.image=IMAGE(@"rootbg");
    [subView addSubview:bgImageView];
    
    
    //健康指数
    root_healthIndexLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 0, 90, 90)];
    root_healthIndexLabel.textAlignment=NSTextAlignmentCenter;
    root_healthIndexLabel.backgroundColor=[UIColor clearColor];
    root_healthIndexLabel.textColor=[UIColor whiteColor];
    root_healthIndexLabel.font=[UIFont systemFontOfSize:70];
    if (carDic.count>0)
    {
        root_healthIndexLabel.text=[[[carDic objectForKey:@"healthCheck"] objectForKey:@"totalScore"] stringValue];
    }
    else
    {
        root_healthIndexLabel.text=@"0";
    }
    [subView addSubview:root_healthIndexLabel];
    
    
    UILabel *healthIndexDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 90, 20)];
    healthIndexDesLabel.textAlignment=NSTextAlignmentCenter;
    healthIndexDesLabel.backgroundColor=[UIColor clearColor];
    healthIndexDesLabel.textColor=[UIColor whiteColor];
    healthIndexDesLabel.font=[UIFont systemFontOfSize:20];
    healthIndexDesLabel.text=@"健康指数";
    [subView addSubview:healthIndexDesLabel];
    if (carDic.count>0)
    {
         [subView addSubview:[self customButton:root_healthIndexLabel.frame tag:2 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    }

    UIImageView *wetherBg=[[UIImageView alloc] initWithFrame:CGRectMake(10, 130, 140, 50)];
    wetherBg.image=IMAGE(@"home_btnbg");
    [subView addSubview:wetherBg];
    
    //天气
    root_weatherImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 130, 58, 50)];
    if (weatheOilDic)
    {
        NSString *icon=[self getImageNameFromString:[weatheOilDic objectForKey:@"weather"]];
        root_weatherImageView.image=IMAGE(icon);
    }
    else
    {
        root_weatherImageView.image=IMAGE(@"1");
    }
    [subView addSubview:root_weatherImageView];
     
    root_upWeatherLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 135, 60, 20)];
    root_upWeatherLabel.backgroundColor=[UIColor clearColor];
    root_upWeatherLabel.textAlignment=NSTextAlignmentCenter;
    root_upWeatherLabel.textColor=[UIColor whiteColor];
    root_upWeatherLabel.font=[UIFont systemFontOfSize:20];
    if (weatheOilDic)
    {
        //NSLog(@"ssssss::%@",[weatheOilDic objectForKey:@"onedate"]);
        
        NSRange range=[[weatheOilDic objectForKey:@"onedate"] rangeOfString:@"℃"];
        
        //NSLog(@"range::%lu....%d",(unsigned long)range.location,range.length);
        if (range.length>0)
        {
            //root_upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[weatheOilDic objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:2]];
            if ([[[[weatheOilDic objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:1] isEqualToString:@"："])
            {
                root_upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[weatheOilDic objectForKey:@"onedate"] substringFromIndex:range.location-1] substringToIndex:1]];
            }
            else
            {
                root_upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[weatheOilDic objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:2]];
            }
        }
        else
        {
            root_upWeatherLabel.text=@"20℃";
        }
        
    }
    else
    {
        root_upWeatherLabel.text=@"32℃";
    }
    [subView addSubview:root_upWeatherLabel];
     
    root_downWeatherLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 155, 70, 20)];
    root_downWeatherLabel.backgroundColor=[UIColor clearColor];
    root_downWeatherLabel.textAlignment=NSTextAlignmentCenter;
    root_downWeatherLabel.textColor=[UIColor whiteColor];
    root_downWeatherLabel.font=[UIFont systemFontOfSize:14];
    if (weatheOilDic)
    {
        if ([[weatheOilDic objectForKey:@"tmp"] rangeOfString:@"~"].length>0)
        {
            /*
            //温度范围
            root_downWeatherLabel.text=[NSString stringWithFormat:@"%@℃/%@℃",[[[weatheOilDic objectForKey:@"tmp"] substringFromIndex:0] substringToIndex:2],[[[weatheOilDic objectForKey:@"tmp"] substringFromIndex:5] substringToIndex:2]];
             */
            
            root_downWeatherLabel.text=[weatheOilDic objectForKey:@"tmp"];
            
        }
        else
        {
            root_downWeatherLabel.text=[NSString stringWithFormat:@"%@/",[weatheOilDic objectForKey:@"tmp"]];
        }
    }
    else
    {
        root_downWeatherLabel.text=@"24℃/38℃";
    }
    
    
    [subView addSubview:root_downWeatherLabel];
    UIButton *weatherButton=[UIButton buttonWithType:UIButtonTypeCustom];
    weatherButton.frame=CGRectMake(20, 120, 140, 80);
   // weatherButton.backgroundColor=[UIColor whiteColor];
    [weatherButton addTarget:self action:@selector(weatherButton) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:weatherButton];
    
    //中间分割线
    UILabel *sepLabel=[[UILabel alloc] initWithFrame:CGRectMake(160, 130, 1, 50)];
    sepLabel.backgroundColor=[UIColor whiteColor];
    [subView addSubview:sepLabel];
    
   
    
    
    UIImageView *engineOilBg=[[UIImageView alloc] initWithFrame:CGRectMake(170, 130, 140, 50)];
    engineOilBg.image=IMAGE(@"home_btnbg");
    [subView addSubview:engineOilBg];
    
    //机油
    UIImageView *engineOilImageView=[[UIImageView alloc] initWithFrame:CGRectMake(180, 130, 58, 50)];
    engineOilImageView.image=IMAGE(@"engineOil");
    [subView addSubview:engineOilImageView];
    root_upEngineOilLabel=[[UILabel alloc] initWithFrame:CGRectMake(240, 135, 60, 20)];
    root_upEngineOilLabel.backgroundColor=[UIColor clearColor];
    root_upEngineOilLabel.textAlignment=NSTextAlignmentCenter;
    root_upEngineOilLabel.textColor=[UIColor whiteColor];
    root_upEngineOilLabel.font=[UIFont systemFontOfSize:20];
    if (weatheOilDic)
    {
        root_upEngineOilLabel.text=[NSString stringWithFormat:@"%@天",[weatheOilDic objectForKey:@"time"]];//调价天数
    }
    else
    {
         root_upEngineOilLabel.text=@"12天";
    }
    [subView addSubview:root_upEngineOilLabel];
    root_downEngineOilLabel=[[UILabel alloc] initWithFrame:CGRectMake(240, 155, 70, 20)];
    root_downEngineOilLabel.backgroundColor=[UIColor clearColor];
    root_downEngineOilLabel.textAlignment=NSTextAlignmentCenter;
    root_downEngineOilLabel.textColor=[UIColor whiteColor];
    root_downEngineOilLabel.font=[UIFont systemFontOfSize:14];
    if (weatheOilDic)
    {
        root_downEngineOilLabel.text=[NSString stringWithFormat:@"%@/%@",[weatheOilDic objectForKey:@"qiyouone"],[weatheOilDic objectForKey:@"qiyoutwo"]];//调价范围
    }
    else
    {
        root_downEngineOilLabel.text=@"7.75/8.24";
    }
    
    [subView addSubview:root_downEngineOilLabel];
    UIButton *engineOilButton=[UIButton buttonWithType:UIButtonTypeCustom];
    engineOilButton.frame=CGRectMake(180, 120, 140, 80);
    //engineOilButton.backgroundColor=[UIColor whiteColor];
    [engineOilButton addTarget:self action:@selector(engineOilButton) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:engineOilButton];
    
    
    [mainView addSubview:subView];
    [homeTableView addSubview:mainView];
    
    [self.view addSubview:homeTableView];

    
}


-(UIView *)popAlertView
{
    UIView *popAlertView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 480+(iPhone5?88:0))];
    popAlertView.backgroundColor=[UIColor clearColor];

    UIView *contentView=[[UIView alloc] initWithFrame:CGRectMake(20,120, 280, 200)];
    contentView.backgroundColor=kUIColorFromRGB(0x222222);

    /*
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:contentView.bounds];
    bgImageView.image=IMAGE(@"rootbg");
    [contentView addSubview:bgImageView];
    */
    
    contentView.layer.cornerRadius = 1.0f;
    contentView.layer.borderColor = [UIColor clearColor].CGColor;
    contentView.layer.borderWidth = 2.0f;
    
    carChooseListTableView=[[UITableView alloc] initWithFrame:CGRectMake(10, 0, 260,150)];
    carChooseListTableView.tag=2;
    carChooseListTableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    carChooseListTableView.dataSource = self;
    carChooseListTableView.delegate = self;
    carChooseListTableView.autoresizingMask = UIViewAutoresizingFlexibleHeight | UIViewAutoresizingFlexibleWidth;
    carChooseListTableView.separatorColor = [UIColor clearColor];
    carChooseListTableView.backgroundColor = [UIColor clearColor];
    carChooseListTableView.showsHorizontalScrollIndicator=NO;
    carChooseListTableView.showsVerticalScrollIndicator=NO;
    carChooseListTableView.scrollEnabled=YES;
    [contentView addSubview:carChooseListTableView];
    [carChooseListTableView reloadData];
    
    [contentView addSubview:[self customView:CGRectMake(40, 155, 200, 40) labelTitle:@"取消" buttonTag:1]];
    
    
    [popAlertView addSubview:contentView];
    
    return popAlertView;
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        [self hiddenShow];
    }
    else if (sender.tag==2)
    {
        if (![AppDelegate setGlobal].token)
        {
            [self alertLogin];
        }
        else
        {
            for (int i=0;i<5; i++)
            {
                int random=arc4random() % (100-[[[carDic   objectForKey:@"healthCheck"] objectForKey:@"totalScore"]intValue]);
                // NSLog(@"random::%d",random);
                root_healthIndexLabel.text=[NSString stringWithFormat:@"%d",random];
            }
            
            [ToolLen ShowWaitingView:YES];
            requestTimes=2;
            [[self JsonFactory] get_healthCheck:[carDic objectForKey:@"carid"] action:@"healthCheck"];
        }
    }
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    //设置通知
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(homeSkin) name:@"homeSkin" object:nil];
    
   [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeCar) name:@"changeCar" object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(alertLogin) name:@"alertLogin" object:nil];
    
    [self initUI];
    
}



-(void)JSONSuccess:(id)responseObject
{
    //NSLog(@"rs:%@",responseObject);
    
    
    if (responseObject && requestTimes==11)//表明是天气
    {
        [ToolLen ShowWaitingView:NO];
        weatherDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        
        if ([[weatherDic allKeys] containsObject:@"xc"])
        {
            // contains key
            [self initWeatherUI:1];//初始化天气UI
        }
    }
    else if (responseObject && requestTimes==12)//表明是汽油
    {
        [ToolLen ShowWaitingView:NO];
        oilDic=[[NSDictionary alloc] initWithDictionary:responseObject];
        if ([[oilDic allKeys] containsObject:@"trade"])
        {
            // contains key
            [self initEngineOilUI:1];
        }
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
       // [ToolLen ShowWaitingView:YES];
        [[NSUserDefaults standardUserDefaults] setInteger:1 forKey:@"vaild"];//保存有效
        
        //保存用户信息
        [document saveDataToDocument:@"user" fileData:[responseObject objectForKey:@"user"]];
        //保存车辆信息
        [document saveDataToDocument:@"car" fileData:[responseObject objectForKey:@"car"]];
        //保存天气油价信息
        [document saveDataToDocument:@"weatherOil" fileData:responseObject];
        
        //发送通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshAccount" object:nil];
        
       // NSLog(@"ssssdddd::%@",[[responseObject objectForKey:@"user"] objectForKey:@"userid"]);
        
        //设置极光推送标志
        //[APService setAlias:[[responseObject objectForKey:@"user"] objectForKey:@"userid"] callbackSelector:@selector(tagsAliasCallback:tags:alias:) object:nil];
        
        [APService setTags:nil alias:[NSString stringWithFormat:@"anchexin_%@",[[responseObject objectForKey:@"user"] objectForKey:@"id"]] callbackSelector:@selector(tagsAliasCallback:tags:alias:) target:self];
        
        [AppDelegate setGlobal].token=[[responseObject objectForKey:@"user"] objectForKey:@"token"];
        
        [AppDelegate setGlobal].uid=[[responseObject objectForKey:@"user"]  objectForKey:@"id"];
        
        if ([[responseObject objectForKey:@"car"] count]>0)
        {
            //当前车辆图标
            //[carIconImageView setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"car"] objectForKey:@"iconimg"]] placeholderImage:nil];
            [carIconImageView sd_setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"car"] objectForKey:@"iconimg"]] placeholderImage:nil];
          
            //当前车辆车牌号
            carIconLabel.text=[[responseObject objectForKey:@"car"] objectForKey:@"license_number"];
        }
        
        if ([[responseObject objectForKey:@"car"] count]>0)
        {
            root_healthIndexLabel.text=[[[[responseObject objectForKey:@"car"] objectForKey:@"healthCheck"] objectForKey:@"totalScore"] stringValue];//健康指数
        }
        
        
        //NSLog(@"scccssss::%@",[responseObject objectForKey:@"weather"]);
        
        NSString *icon=[self getImageNameFromString:[responseObject objectForKey:@"weather"]];
        root_weatherImageView.image=IMAGE(icon);//天气图标
        
        NSRange range=[[responseObject objectForKey:@"onedate"] rangeOfString:@"℃"];
        //NSLog(@"nslog::%@",[responseObject objectForKey:@"onedate"]);
        
        if (range.length>0)
        {
            //root_upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[responseObject objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:2]];
            
            if ([[[[responseObject objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:1] isEqualToString:@"："])
            {
                root_upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[responseObject objectForKey:@"onedate"] substringFromIndex:range.location-1] substringToIndex:1]];
            }
            else
            {
                root_upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[responseObject objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:2]];
            }
        }
        else
        {
            root_upWeatherLabel.text=@"20℃";
        }
        
        if ([[responseObject objectForKey:@"tmp"] rangeOfString:@"~"].length>0)
        {
            //温度范围
            /*
            root_downWeatherLabel.text=[NSString stringWithFormat:@"%@℃/%@℃",[[[responseObject objectForKey:@"tmp"] substringFromIndex:0] substringToIndex:2],[[[responseObject objectForKey:@"tmp"] substringFromIndex:5] substringToIndex:2]];
            */
            
            root_downWeatherLabel.text=[responseObject objectForKey:@"tmp"];
            
        }
        else
        {
            root_downWeatherLabel.text=[NSString stringWithFormat:@"%@/",[responseObject objectForKey:@"tmp"]];
        }
        
        
        root_upEngineOilLabel.text=[NSString stringWithFormat:@"%@天",[responseObject objectForKey:@"time"]];//调价天数
        root_downEngineOilLabel.text=[NSString stringWithFormat:@"%@/%@",[responseObject objectForKey:@"qiyouone"],[responseObject objectForKey:@"qiyoutwo"]];//调价范围
        
        requestTimes=3;
        [[self JsonFactory] getCarList:@"getCarList"];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==3)
    {
        [ToolLen ShowWaitingView:NO];
        
        //车辆列表
        carListArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"carlist"]];
        
        [carChooseListTableView reloadData];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        [ToolLen ShowWaitingView:NO];
        
        root_healthIndexLabel.text=[[[responseObject objectForKey:@"healthCheck"] objectForKey:@"totalScore"] stringValue];//健康指数
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==5)
    {
        [ToolLen ShowWaitingView:NO];
        
        //保存车辆信息
        [document saveDataToDocument:@"car" fileData:[responseObject objectForKey:@"car"]];
       
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshAccount" object:nil];
        
        //刷新健康卡界面
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUI" object:nil];
        
        //刷新通知提醒
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshUI2" object:nil];
        
        //当前车辆图标
        //[carIconImageView setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"car"] objectForKey:@"iconimg"]] placeholderImage:nil];
        [carIconImageView sd_setImageWithURL:[NSURL URLWithString:[[responseObject objectForKey:@"car"] objectForKey:@"iconimg"]] placeholderImage:nil];
        //当前车辆车牌号
        carIconLabel.text=[[responseObject objectForKey:@"car"] objectForKey:@"license_number"];
        
        root_healthIndexLabel.text=[[[[responseObject objectForKey:@"car"] objectForKey:@"healthCheck"] objectForKey:@"totalScore"] stringValue];//健康指数
      
    }
    else if(responseObject && requestTimes==1)
    {
        [ToolLen ShowWaitingView:NO];
        if ([[responseObject objectForKey:@"errorcode"] intValue]==1)
        {
            [self alertOnly:[responseObject objectForKey:@"message"]];
            
            // NSLog(@"登录");
            LoginAndResigerViewController *guide=[[LoginAndResigerViewController alloc] init];
            guide.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:guide animated:YES];

            
        }
        else
        {
            [self alertLogin];
        }
    }
    else
    {
        [ToolLen ShowWaitingView:NO];
    }

}

//弹出登录对话框
-(void)alertLogin
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil message:@"由于网络不稳定,登录失败,是否重新登录" delegate:self cancelButtonTitle:@"取消"
                                        otherButtonTitles:@"登录", nil];
    
    [alert show];
}

/*
-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        requestTimes=1;
        
        if (userDic)
        {
            //NSLog(@"userDic:%@",userDic);
            //NSLog(@"weather:%@",weatheOilDic);
            [ToolLen ShowWaitingView:YES];
            //[[self JsonFactory] get_login:[userDic objectForKey:@"mobile"] loginpwd:[userDic objectForKey:@"userpwd"] action:@"login"];//登录
        }
        else
        {
            //体验账户
            [ToolLen ShowWaitingView:YES];
            //[[self JsonFactory] get_login:@"anchexin" loginpwd:@"111111" action:@"login"];
            
        }
    }
}
 */

//下拉车辆管理
-(void)pullOut
{
    //carChooseListTableView.hidden=!carChooseListTableView.hidden;
    
    if (![AppDelegate setGlobal].token)
    {
        [self alertLogin];
    }
    else
    {
        requestTimes=3;
        [[self JsonFactory] getCarList:@"getCarList"];
        
        [self show];
    }
}

//行程分析
-(void)strokeAnalysis
{
    //NSLog(@"strokeAnalysis");
}

//车况诊断
-(void)vehicleDiagnosis
{
    //NSLog(@"vehicleDiagnosis");
}

-(NSString *)getWeekByWeek:(NSString *)week andIndex:(int)index
{
    NSArray *weeklist=[NSArray arrayWithObjects:@"周一",@"周二",@"周三",@"周四",@"周五",@"周六",@"周日", nil];
    NSUInteger weekIndex=[weeklist indexOfObject:week];
    return [weeklist objectAtIndex:(weekIndex+index)%7];
    
}

//根据获取天气的关键字返回相应的图片名称
-(NSString *)getImageNameFromString:(NSString *)weather
{
    if(weather==nil)
    {
       // NSLog(@"传入的天气名称为nil");
        return nil;
    }
    NSString *weatherString=[NSString stringWithString:weather];
    NSUInteger location=[weatherString rangeOfString:@"转"].location;
    
    if(location<100)
    {
        weatherString=[[weatherString substringFromIndex:0] substringToIndex:location];
    }
    if([weatherString isEqualToString:@"晴"])
    {
        return @"3";
    }
    
    if([weatherString isEqualToString:@"多云"])
    {
        return @"20";
    }
    
    if([weatherString isEqualToString:@"阴"])
    {
        return @"20";
    }
    
    if([weatherString isEqualToString:@"雾"])
    {
        return @"4";
    }
    
    //------------雨
    if([weatherString isEqualToString:@"阵雨"])
    {
        return @"16";
    }
    
    if([weatherString isEqualToString:@"雷阵雨"])
    {
        return @"12";
    }
    
    if([weatherString isEqualToString:@"雨夹雪"])
    {
        return @"16";
    }
    
    if([weatherString isEqualToString:@"小雨"])
    {
        return @"16";
    }
    
    if(([weatherString isEqualToString:@"中雨"])||([weatherString isEqualToString:@"大雨"]))
    {
        return @"2";
    }
    
    if(([weatherString isEqualToString:@"暴雨"])||([weatherString isEqualToString:@"大暴雨"])||([weatherString isEqualToString:@"特大暴雨"]))
    {
        return @"8";
    }
    
    //-------------雪
    if([weatherString isEqualToString:@"阵雪"])
    {
        return @"18";
    }
    
    if([weatherString isEqualToString:@"小雪"])
    {
        return @"13";
    }
    
    if([weatherString isEqualToString:@"中雪"])
    {
        return @"13";
    }
    
    if([weatherString isEqualToString:@"大雪"])
    {
        return @"18";
    }
    
    if([weatherString isEqualToString:@"暴雪"])
    {
        return @"18";
    }
    
    return nil;
}


//初始化天气UI
-(void)initWeatherUI:(int)adjust
{
    [subContentView removeFromSuperview];
    
    NSDateComponents *componets = [[NSCalendar autoupdatingCurrentCalendar] components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    int weekday = (int)[componets weekday];
    //NSLog(@"weee::%d",weekday);
    NSString *todayStr=nil;
    if (weekday==1)
    {
        todayStr=@"周日";
    }
    else if (weekday==2)
    {
        todayStr=@"周一";
    }
    else if (weekday==3)
    {
        todayStr=@"周二";
    }
    else if (weekday==4)
    {
        todayStr=@"周三";
    }
    else if (weekday==5)
    {
        todayStr=@"周四";
    }
    else if (weekday==6)
    {
        todayStr=@"周五";
    }
    else if (weekday==7)
    {
        todayStr=@"周六";
    }
    
    NSDate *currentDate=[NSDate date];
    NSDateFormatter *dateformatter=[[NSDateFormatter alloc] init];
    [dateformatter setDateFormat:@"MM-dd"];
    NSString *currentTime=[dateformatter stringFromDate:currentDate];
    //NSLog(@"locationString:%@",currentTime);
 
    
    subContentView=[[UIView alloc] initWithFrame:CGRectMake(0, -(480+(iPhone5?88:0)), WIDTH, 480+(iPhone5?88:0))];
    subContentView.backgroundColor=[UIColor clearColor];
    //背景
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:subContentView.bounds];
    bgImageView.image=IMAGE(@"rootbg");
    [subContentView addSubview:bgImageView];
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0))];
    subView.backgroundColor=[UIColor clearColor];
    
    //下拉按钮图标
    UIImageView *pullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(280,30, 25, 25)];
    pullImageView.image=IMAGE(@"pull");
    [subView addSubview:pullImageView];
    UIButton *pullButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pullButton.frame=CGRectMake(270, 20, 50, 50);
    [pullButton addTarget:self action:@selector(pullOutPage) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:pullButton];
    
    if (adjust==0)
    {
        requestLabel=[self customLabel:CGRectMake(50, (480+(iPhone5?88:0))/2-50, 220, 20) color:[UIColor whiteColor] text:@"正在加载中..." alignment:0 font:15.0];
        
        [subView addSubview:requestLabel];
        
    }
    else
    {
        
        //当日天气
        UIImageView *weatherImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 58, 50)];
        
        NSString *current=[self getImageNameFromString:[weatherDic objectForKey:@"oneweather"]];
        weatherImageView.image=IMAGE(current);
        [subView addSubview:weatherImageView];
        
        root_weatherImageView.image=IMAGE(current);//天气图标
        
        UILabel *upWeatherLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 25, 70, 20)];
        upWeatherLabel.textAlignment=NSTextAlignmentCenter;
        upWeatherLabel.textColor=[UIColor whiteColor];
        upWeatherLabel.font=[UIFont systemFontOfSize:20];
        
        NSRange range=[[weatherDic objectForKey:@"onedate"] rangeOfString:@"℃"];
        //NSLog(@"11111::%@",[weatherDic objectForKey:@"onedate"]);
        
        //NSLog(@"%@::%d",[weatherDic objectForKey:@"onedate"],range.location);
        if(range.length>0)
        {
         
            if ([[[[weatherDic objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:1] isEqualToString:@"："])
            {
               upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[weatherDic objectForKey:@"onedate"] substringFromIndex:range.location-1] substringToIndex:1]];
            }
            else
            {
                upWeatherLabel.text=[NSString stringWithFormat:@"%@℃",[[[weatherDic objectForKey:@"onedate"] substringFromIndex:range.location-2] substringToIndex:2]];
            }
            
        }
        else
        {
            upWeatherLabel.text=@"20℃";
        }
        [subView addSubview:upWeatherLabel];
        
        root_upWeatherLabel.text=upWeatherLabel.text;
        
        
        
        UILabel *downWeatherLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 45,70, 20)];
        downWeatherLabel.textAlignment=NSTextAlignmentCenter;
        downWeatherLabel.textColor=[UIColor whiteColor];
        downWeatherLabel.font=[UIFont systemFontOfSize:14];
        if ([[weatherDic objectForKey:@"onetmp"] rangeOfString:@"~"].length>0)
        {
            //downWeatherLabel.text=[NSString stringWithFormat:@"%@℃/%@℃",[[[weatherDic objectForKey:@"onetmp"] substringFromIndex:0] substringToIndex:2],[[[weatherDic objectForKey:@"onetmp"] substringFromIndex:5] substringToIndex:2]];
            
            downWeatherLabel.text=[weatherDic objectForKey:@"onetmp"];
        }
        else
        {
            downWeatherLabel.text=[NSString stringWithFormat:@"%@/",[weatherDic objectForKey:@"onetmp"]];
        }
        
        [subView addSubview:downWeatherLabel];
        root_downWeatherLabel.text=downWeatherLabel.text;
        
        
        //当天日期
        UILabel *timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 70, 100, 20)];
        timeLabel.textAlignment=NSTextAlignmentLeft;
        timeLabel.textColor=[UIColor whiteColor];
        timeLabel.font=[UIFont systemFontOfSize:14];
        timeLabel.text=[NSString stringWithFormat:@"%@ %@",currentTime,todayStr];
        [subView addSubview:timeLabel];
        
        UIImageView *breakLineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 95, 280, 1)];
        breakLineImageView.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView];
        
        //天气情况
        UILabel *weatherDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 105+(iPhone5?5:0), 100, 20)];
        weatherDesLabel.textAlignment=NSTextAlignmentLeft;
        weatherDesLabel.textColor=[UIColor whiteColor];
        weatherDesLabel.font=[UIFont systemFontOfSize:16];
        weatherDesLabel.text=@"天气情况";
        [subView addSubview:weatherDesLabel];
        
        UILabel *weatherValueLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 105+(iPhone5?5:0), 150, 20)];
        weatherValueLabel.textAlignment=NSTextAlignmentRight;
        weatherValueLabel.textColor=[UIColor whiteColor];
        weatherValueLabel.font=[UIFont systemFontOfSize:16];
        weatherValueLabel.text=[weatherDic objectForKey:@"oneweather"];
        [subView addSubview:weatherValueLabel];
        
        
        UIImageView *breakLineImageView1=[[UIImageView alloc] initWithFrame:CGRectMake(20,130+(iPhone5?10:0), 280, 1)];
        breakLineImageView1.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView1];
        
        //pm2.5
        UILabel *pmDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 140+(iPhone5?15:0), 100, 20)];
        pmDesLabel.textAlignment=NSTextAlignmentLeft;
        pmDesLabel.textColor=[UIColor whiteColor];
        pmDesLabel.font=[UIFont systemFontOfSize:16];
        pmDesLabel.text=@"PM2.5指数";
        [subView addSubview:pmDesLabel];
        
        int pm=[[weatherDic objectForKey:@"pm25"] intValue];
        NSString *pmValue=nil;
        if (pm>0 && pm<51)
        {
            pmValue=@"优";
        }
        else if (pm>=51 && pm<101)
        {
            pmValue=@"良";
        }
        else if (pm>=101 && pm<151)
        {
            pmValue=@"轻度污染";
        }
        else if (pm>=151 && pm<201)
        {
            pmValue=@"中度污染";
        }
        else if (pm>=201 && pm<301)
        {
            pmValue=@"重度污染";
        }
        else if (pm>=301 && pm<501)
        {
            pmValue=@"严重污染";
        }
        else
        {
            pmValue=@"爆表";
        }
        
        UILabel *pmValueLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 140+(iPhone5?15:0), 150, 20)];
        pmValueLabel.textAlignment=NSTextAlignmentRight;
        pmValueLabel.textColor=[UIColor whiteColor];
        pmValueLabel.font=[UIFont systemFontOfSize:16];
        pmValueLabel.text=[NSString stringWithFormat:@"%@ %@",[weatherDic objectForKey:@"pm25"],pmValue];
        [subView addSubview:pmValueLabel];
        
        UIImageView *breakLineImageView2=[[UIImageView alloc] initWithFrame:CGRectMake(20,165+(iPhone5?20:0), 280, 1)];
        breakLineImageView2.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView2];
        
        
        NSDateFormatter *formatter=[[NSDateFormatter alloc] init];
        [formatter setDateFormat:@"MM-dd"];
        
        NSTimeInterval day1 = 24 * 60 * 60;
        NSDate *date_day1 = [[NSDate alloc] initWithTimeIntervalSinceNow:day1];
        NSString *day_1=[formatter stringFromDate:date_day1];
        // NSLog(@"day_1:%@",day_1);
        
        NSTimeInterval day2 = 24 * 60 * 60 *2 ;
        NSDate *date_day2 = [[NSDate alloc] initWithTimeIntervalSinceNow:day2];
        NSString *day_2=[formatter stringFromDate:date_day2];
        // NSLog(@"day_2:%@",day_2);
        
        NSTimeInterval day3 = 24 * 60 * 60 *3;
        NSDate *date_day3 = [[NSDate alloc] initWithTimeIntervalSinceNow:day3];
        NSString *day_3=[formatter stringFromDate:date_day3];
        // NSLog(@"day_3:%@",day_3);
        
        //未来天气
        NSArray *dateArray=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@ %@",day_1,[self getWeekByWeek:todayStr andIndex:1]],[NSString stringWithFormat:@"%@ %@",day_2,[self getWeekByWeek:todayStr andIndex:2]],[NSString stringWithFormat:@"%@ %@",day_3,[self getWeekByWeek:todayStr andIndex:3]], nil];
        /*
         NSArray *dateArray=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@-%@ %@",[[[weatherDic objectForKey:@"onedate"] substringFromIndex:3] substringToIndex:2],[[[weatherDic objectForKey:@"onedate"] substringFromIndex:6] substringToIndex:2],[self getWeekByWeek:todayStr andIndex:1]],[NSString stringWithFormat:@"%@-%@ %@",[[[weatherDic objectForKey:@"twodate"] substringFromIndex:3] substringToIndex:2],[[[weatherDic objectForKey:@"twodate"] substringFromIndex:6] substringToIndex:2],[self getWeekByWeek:todayStr andIndex:2]],[NSString stringWithFormat:@"%@-%@ %@",[[[weatherDic objectForKey:@"threedate"] substringFromIndex:3] substringToIndex:2],[[[weatherDic objectForKey:@"threedate"] substringFromIndex:6] substringToIndex:2],[self getWeekByWeek:todayStr andIndex:3]], nil];
         */
        
        /*
        NSArray *tmpArray=[NSArray arrayWithObjects:[NSString stringWithFormat:@"%@℃/%@℃",[[[weatherDic objectForKey:@"twotmp"] substringFromIndex:0] substringToIndex:2],[[[weatherDic objectForKey:@"twotmp"] substringFromIndex:5] substringToIndex:2]],[NSString stringWithFormat:@"%@℃/%@℃",[[[weatherDic objectForKey:@"threetmp"] substringFromIndex:0] substringToIndex:2],[[[weatherDic objectForKey:@"threetmp"] substringFromIndex:5] substringToIndex:2]],[NSString stringWithFormat:@"%@℃/%@℃",[[[weatherDic objectForKey:@"fourtmp"] substringFromIndex:0] substringToIndex:2],[[[weatherDic objectForKey:@"fourtmp"] substringFromIndex:5] substringToIndex:2]], nil];
        */
         NSArray *tmpArray=[NSArray arrayWithObjects:
                            [NSString stringWithFormat:@"%@",[weatherDic objectForKey:@"twotmp"]],
                            [NSString stringWithFormat:@"%@",[weatherDic objectForKey:@"threetmp"]],
                            [NSString stringWithFormat:@"%@",[weatherDic objectForKey:@"fourtmp"]], nil];
        
        NSArray *wethArray=[NSArray arrayWithObjects:[self getImageNameFromString:[weatherDic objectForKey:@"twoweather"]],[self getImageNameFromString:[weatherDic objectForKey:@"threeweather"]],[self getImageNameFromString:[weatherDic objectForKey:@"fourweather"]], nil];
        
        for (int i=0; i<3; i++)
        {
            UILabel *dateDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20+95*i, 180+(iPhone5?30:0), 90, 20)];
            dateDesLabel.textAlignment=NSTextAlignmentCenter;
            dateDesLabel.textColor=[UIColor whiteColor];
            dateDesLabel.font=[UIFont systemFontOfSize:13.0];
            dateDesLabel.text=[dateArray objectAtIndex:i];
            [subView addSubview:dateDesLabel];
            
            UIImageView *wethImageView=[[UIImageView alloc] initWithFrame:CGRectMake(35+95*i, 200+(iPhone5?30:0), 58, 50)];
            NSString *str=[wethArray objectAtIndex:i];
            wethImageView.image=IMAGE(str);
            [subView addSubview:wethImageView];
            
            UILabel *tmpDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20+95*i, 250+(iPhone5?30:0), 90, 20)];
            tmpDesLabel.textAlignment=NSTextAlignmentCenter;
            tmpDesLabel.textColor=[UIColor whiteColor];
            tmpDesLabel.font=[UIFont systemFontOfSize:13.0];
            tmpDesLabel.text=[tmpArray objectAtIndex:i];
            [subView addSubview:tmpDesLabel];
            
        }
        
        UIImageView *breakLineImageView3=[[UIImageView alloc] initWithFrame:CGRectMake(20,280+(iPhone5?40:0), 280, 1)];
        breakLineImageView3.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView3];
        
        
        
        UILabel *xicheDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 290+(iPhone5?60:0), 200, 20)];
        xicheDesLabel.textAlignment=NSTextAlignmentLeft;
        xicheDesLabel.textColor=[UIColor whiteColor];
        xicheDesLabel.font=[UIFont systemFontOfSize:15];
        xicheDesLabel.text=[NSString stringWithFormat:@"洗车指数  %@",[weatherDic objectForKey:@"xc"]];
        [subView addSubview:xicheDesLabel];
        
        UILabel *xicheDesLabel1=[[UILabel alloc] initWithFrame:CGRectMake(20, 310+(iPhone5?60:0), 280, 40+(iPhone5?40:20))];
        xicheDesLabel1.textAlignment=NSTextAlignmentLeft;
        xicheDesLabel1.textColor=[UIColor whiteColor];
        xicheDesLabel1.font=[UIFont systemFontOfSize:13.0];
        [xicheDesLabel1 setLineBreakMode:NSLineBreakByWordWrapping];
        [xicheDesLabel1 setNumberOfLines:0];
        xicheDesLabel1.text=[weatherDic objectForKey:@"xcdes"];
        [subView addSubview:xicheDesLabel1];
        
        

    }
    
    [subContentView addSubview:subView];
    
    //添加手势
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [homeTableView addGestureRecognizer:recognizer];
    
    [homeTableView addSubview:subContentView];

}
//天气详情
-(void)weatherButton
{
    //NSLog(@"天气详情");
    [MobClick event:@"weather"];//统计天气页面
 
    [self initWeatherUI:0];//初始化天气UI
    
    [UIView animateWithDuration:1.0 animations:^{
    
        [backgroundView blurInAnimationWithDuration:1.0];
        [homeTableView setContentOffset:CGPointMake(0,-(480+(iPhone5?88:0))) animated:NO];
        
    }];
    
    
    requestTimes=11;
    if (![AppDelegate setGlobal].currentLatitude || ![AppDelegate setGlobal].currentLongitude)
    {
        [AppDelegate setGlobal].currentLatitude=@"";
        [AppDelegate setGlobal].currentLongitude=@"";
    }
    
    [[self JsonFactory] weather:[AppDelegate setGlobal].currentLatitude lng:[AppDelegate setGlobal].currentLongitude action:@"weather"];
    
}


-(void)handleSwipeFrom:(UISwipeGestureRecognizer *)recognizer
{
    if(recognizer.direction==UISwipeGestureRecognizerDirectionDown)
    {
       // NSLog(@"swipe up");
        [UIView animateWithDuration:1.0 animations:^{
            [backgroundView blurOutAnimationWithDuration:1.0f];
            
            [homeTableView setContentOffset:CGPointMake(0,-(480+(iPhone5?88:0))*2-NavigationBar) animated:NO];
        }];
    
    }
    
    //[self performSelector:@selector(<#selector#>) withObject:nil afterDelay:1.0];
}


//初始化机油界面
-(void)initEngineOilUI:(int)adjust
{
    [subContentView removeFromSuperview];
    subContentView=[[UIView alloc] initWithFrame:CGRectMake(0, -(480+(iPhone5?88:0)), WIDTH, 480+(iPhone5?88:0))];
    subContentView.backgroundColor=[UIColor clearColor];
    
    //背景
    UIImageView *bgImageView=[[UIImageView alloc] initWithFrame:subContentView.bounds];
    bgImageView.image=IMAGE(@"rootbg");
    [subContentView addSubview:bgImageView];
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0))];
    subView.backgroundColor=[UIColor clearColor];
    
    //下拉按钮图标
    UIImageView *pullImageView=[[UIImageView alloc] initWithFrame:CGRectMake(280,30, 25, 25)];
    pullImageView.image=IMAGE(@"pull");
    [subView addSubview:pullImageView];
    UIButton *pullButton=[UIButton buttonWithType:UIButtonTypeCustom];
    pullButton.frame=CGRectMake(270, 20, 50, 50);
    [pullButton addTarget:self action:@selector(pullOutPage) forControlEvents:UIControlEventTouchUpInside];
    [subView addSubview:pullButton];
    
    if (adjust==0)
    {
        requestLabel=[self customLabel:CGRectMake(50, (480+(iPhone5?88:0))/2-50, 220, 20) color:[UIColor whiteColor] text:@"正在加载中..." alignment:0 font:15.0];
        
        [subView addSubview:requestLabel];
        
    }
    else
    {
        //机油
        UIImageView *engineOilImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 20, 58, 50)];
        engineOilImageView.image=IMAGE(@"engineOil");
        [subView addSubview:engineOilImageView];
        UILabel *upEngineOilLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 25, 60, 20)];
        upEngineOilLabel.textAlignment=NSTextAlignmentCenter;
        upEngineOilLabel.textColor=[UIColor whiteColor];
        upEngineOilLabel.font=[UIFont systemFontOfSize:20];
        upEngineOilLabel.text=[NSString stringWithFormat:@"%@天",[oilDic objectForKey:@"time"]];
        [subView addSubview:upEngineOilLabel];
        UILabel *downEngineOilLabel=[[UILabel alloc] initWithFrame:CGRectMake(80, 45, 70, 20)];
        downEngineOilLabel.textAlignment=NSTextAlignmentCenter;
        downEngineOilLabel.textColor=[UIColor whiteColor];
        downEngineOilLabel.font=[UIFont systemFontOfSize:14];
        downEngineOilLabel.text=@"距下次调价";
        [subView addSubview:downEngineOilLabel];
        
        
        //油价情况
        UILabel *timeLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 80, 100, 20)];
        timeLabel.textAlignment=NSTextAlignmentLeft;
        timeLabel.textColor=[UIColor whiteColor];
        timeLabel.font=[UIFont systemFontOfSize:16];
        timeLabel.text=@"油价情况";
        [subView addSubview:timeLabel];
        
        UIImageView *breakLineImageView=[[UIImageView alloc] initWithFrame:CGRectMake(20, 110, 280, 1)];
        breakLineImageView.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView];
        
        //92号油
        UILabel *weatherDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 120+(iPhone5?5:0), 100, 20)];
        weatherDesLabel.textAlignment=NSTextAlignmentLeft;
        weatherDesLabel.textColor=[UIColor whiteColor];
        weatherDesLabel.font=[UIFont systemFontOfSize:16];
        weatherDesLabel.text=@"92号油";
        [subView addSubview:weatherDesLabel];
        
        UILabel *weatherValueLabel=[[UILabel alloc] initWithFrame:CGRectMake(200, 120+(iPhone5?5:0), 100, 20)];
        weatherValueLabel.textAlignment=NSTextAlignmentRight;
        weatherValueLabel.textColor=[UIColor whiteColor];
        weatherValueLabel.font=[UIFont systemFontOfSize:16];
        weatherValueLabel.text=[NSString stringWithFormat:@"%@元/升",[oilDic objectForKey:@"qiyouone"]];
        [subView addSubview:weatherValueLabel];
        
        
        UIImageView *breakLineImageView1=[[UIImageView alloc] initWithFrame:CGRectMake(20,145+(iPhone5?10:0), 280, 1)];
        breakLineImageView1.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView1];
        
        //95号油
        UILabel *pmDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 155+(iPhone5?15:0), 100, 20)];
        pmDesLabel.textAlignment=NSTextAlignmentLeft;
        pmDesLabel.textColor=[UIColor whiteColor];
        pmDesLabel.font=[UIFont systemFontOfSize:16];
        pmDesLabel.text=@"95号油";
        [subView addSubview:pmDesLabel];
        
        UILabel *pmValueLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 155+(iPhone5?15:0), 150, 20)];
        pmValueLabel.textAlignment=NSTextAlignmentRight;
        pmValueLabel.textColor=[UIColor whiteColor];
        pmValueLabel.font=[UIFont systemFontOfSize:16];
        pmValueLabel.text=[NSString stringWithFormat:@"%@元/升",[oilDic objectForKey:@"qiyoutwo"] ];
        [subView addSubview:pmValueLabel];
        
        UIImageView *breakLineImageView2=[[UIImageView alloc] initWithFrame:CGRectMake(20,180+(iPhone5?20:0), 280, 1)];
        breakLineImageView2.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView2];
        
        
        //下次油价趋势
        UILabel *nextDesLabel=[[UILabel alloc] initWithFrame:CGRectMake(20, 190+(iPhone5?25:0), 100, 20)];
        nextDesLabel.textAlignment=NSTextAlignmentLeft;
        nextDesLabel.textColor=[UIColor whiteColor];
        nextDesLabel.font=[UIFont systemFontOfSize:16];
        nextDesLabel.text=@"下次油价趋势";
        [subView addSubview:nextDesLabel];
        
        if ([[oilDic objectForKey:@"trade"] isEqualToString:@"on"])
        {
            [subView addSubview:[self customImageView:CGRectMake(260, 185+(iPhone5?25:0), 30, 30) image:IMAGE(@"on")]];
        }
        else if ([[oilDic objectForKey:@"trade"] isEqualToString:@"up"])
        {
            [subView addSubview:[self customImageView:CGRectMake(260, 185+(iPhone5?25:0), 30, 30) image:IMAGE(@"up")]];
        }
        else
        {
            [subView addSubview:[self customImageView:CGRectMake(260, 185+(iPhone5?25:0), 30, 30) image:IMAGE(@"down")]];
        }
        
        /*
         UILabel *nextValueLabel=[[UILabel alloc] initWithFrame:CGRectMake(150, 190+(iPhone5?15:0), 150, 20)];
         nextValueLabel.textAlignment=NSTextAlignmentRight;
         nextValueLabel.textColor=[UIColor whiteColor];
         nextValueLabel.font=[UIFont systemFontOfSize:16];
         
         nextValueLabel.text=@"下调";
         [subView addSubview:nextValueLabel];
         */
        
        
        UIImageView *breakLineImageView3=[[UIImageView alloc] initWithFrame:CGRectMake(20,215+(iPhone5?30:0), 280, 1)];
        breakLineImageView3.image=IMAGE(@"rootline");
        [subView addSubview:breakLineImageView3];
        
        
        UIImageView *img=[[UIImageView alloc] initWithFrame:CGRectMake(20, 230+(iPhone5?40:0), 280, 130+(iPhone5?30:0))];
        //[img setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[oilDic objectForKey:@"img"]]] placeholderImage:nil];
        [img sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[oilDic objectForKey:@"img"]]] placeholderImage:nil];
        [subView addSubview:img];

    }
    
    
    [subContentView addSubview:subView];
    
    //添加手势
    UISwipeGestureRecognizer *recognizer;
    recognizer = [[UISwipeGestureRecognizer alloc]initWithTarget:self action:@selector(handleSwipeFrom:)];
    [recognizer setDirection:(UISwipeGestureRecognizerDirectionDown)];
    [homeTableView addGestureRecognizer:recognizer];
    
    
    [homeTableView addSubview:subContentView];
    
}
//油价详情
-(void)engineOilButton
{
    //NSLog(@"油价详情");
    [MobClick event:@"oil"];//统计油价页面
    
    [self initEngineOilUI:0];//初始化天气UI
    
    [UIView animateWithDuration:1.0 animations:^{
        
        [backgroundView blurInAnimationWithDuration:1.0];
        [homeTableView setContentOffset:CGPointMake(0,-(480+(iPhone5?88:0))) animated:NO];
        
    }];
    
    requestTimes=12;
    if (![AppDelegate setGlobal].currentLatitude || ![AppDelegate setGlobal].currentLongitude)
    {
        [AppDelegate setGlobal].currentLatitude=@"";
        [AppDelegate setGlobal].currentLongitude=@"";
    }
    [[self JsonFactory] oil:[AppDelegate setGlobal].currentLatitude lng:[AppDelegate setGlobal].currentLongitude action:@"oil"];
    
}

/*
-(void)scrollViewDidScroll:(UIScrollView *)scrollView
{
    
    homeTableView.scrollEnabled=NO;
    [UIView animateWithDuration:1.5 animations:^{
        [homeTableView setContentOffset:CGPointMake(0,-(480+(iPhone5?88:0))*2-NavigationBar) animated:NO];
    }];
    
}
*/


//下拉页面
-(void)pullOutPage
{
    
    [UIView animateWithDuration:1.0 animations:^{
        [backgroundView blurOutAnimationWithDuration:1.0f];
        
        [homeTableView setContentOffset:CGPointMake(0,-(480+(iPhone5?88:0))*2-NavigationBar) animated:NO];
    }];
    
    
}



- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    // Return the number of rows in the section.
    if (tableView.tag==2)
    {
        return [carListArray count];
    }
    return 1;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        return 40.0;
    }
    return 0.0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        static NSString *cellIndefiner=@"cellIndefiner";
        CarChooseCell *cell=(CarChooseCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
        if (cell==nil)
        {
            NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CarChooseCell" owner:self options:nil];
            cell=[xib objectAtIndex:0];
            [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
            
        }
        
        if ([[carDic objectForKey:@"license_number"] isEqualToString:[[carListArray objectAtIndex:indexPath.row] objectForKey:@"licenseNumber"]])
        {
            cell.checkImageView.hidden=NO;
        }
        else
        {
            cell.checkImageView.hidden=YES;
        }
        
        cell.carNumberLabel.text=[[carListArray objectAtIndex:indexPath.row] objectForKey:@"licenseNumber"];

        return cell;

    }
    return nil;
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (tableView.tag==2)
    {
        if ([[[carListArray objectAtIndex:indexPath.row] objectForKey:@"current_mileage"] intValue]==0 || [[[carListArray objectAtIndex:indexPath.row]objectForKey:@"license_number"] isEqualToString:@""])
        {
            CarInfoViewController *car=[[CarInfoViewController alloc] init];
            car.title=@"车辆信息";
            car.carInfo=[carListArray objectAtIndex:indexPath.row];
            car.hidesBottomBarWhenPushed=YES;
            car.flag=true;
            [self.navigationController pushViewController:car animated:YES];
        }
        else
        {
            [ToolLen ShowWaitingView:YES];
            requestTimes=5;
            [[self JsonFactory] changeCarToValid:[[carListArray objectAtIndex:indexPath.row] objectForKey:@"carid"] action:@"changeCarToValid"];//切换车辆
            
            [carChooseListTableView reloadData];
            
            //切换车辆
            [popView removeFromSuperview];
            
        }
    }
}

//切换车辆
-(void)changeCar
{
    [ToolLen ShowWaitingView:YES];
    requestTimes=5;
    [[self JsonFactory] changeCarToValid:[AppDelegate setGlobal].changCarId action:@"changeCarToValid"];//切换车辆
}

- (void)tagsAliasCallback:(int)iResCode tags:(NSSet*)tags alias:(NSString*)alias
{
    NSLog(@"rescode: %d, \ntags: %@, \nalias: %@\n", iResCode, tags , alias);
}

@end
