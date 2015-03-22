//
//  OrderInfoViewController.m
//  anchexin
//
//  Created by cgx on 14-8-29.
//
//

#import "OrderInfoViewController.h"

@interface OrderInfoViewController ()

@end

@implementation OrderInfoViewController
@synthesize stationInfo;
@synthesize state;

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
    self.title=@"安车信";
    infoScrollView=[[UIScrollView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0))];
    infoScrollView.backgroundColor=kUIColorFromRGB(Commonbg);
    [self.view addSubview:infoScrollView];
    
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, infoScrollView.frame.size.height)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 50)];
    subView.backgroundColor=[UIColor whiteColor];
    UILabel *lbl1=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
    lbl1.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lbl1];
    
    if (state==0)
    {
        if ([[stationInfo objectForKey:@"status"] intValue]==1)
        {
            //已受理
            [subView addSubview:[self customImageView:CGRectMake(15, 5, 40, 40) image:IMAGE(@"order_1")]];
        }
        else if ([[stationInfo objectForKey:@"status"] intValue]==-2)
        {
            //已过期(包括待受理超时和已受理超时)
            [subView addSubview:[self customImageView:CGRectMake(15, 5, 40, 40) image:IMAGE(@"order_5")]];
        }
        else if ([[stationInfo objectForKey:@"status"] intValue]==-1)
        {
            //撤销请求(客户取消待受理)
            [subView addSubview:[self customImageView:CGRectMake(15, 5, 40, 40) image:IMAGE(@"order_2")]];
        }
        else if ([[stationInfo objectForKey:@"status"] intValue]==0)
        {
            //待受理
            [subView addSubview:[self customImageView:CGRectMake(15, 5, 40, 40) image:IMAGE(@"order_0")]];
        }
        else if ([[stationInfo objectForKey:@"status"] intValue]==2)
        {
            //拒绝受理(维修点拒绝受理)
            [subView addSubview:[self customImageView:CGRectMake(15, 5, 40, 40) image:IMAGE(@"order_5")]];
        }
        else if ([[stationInfo objectForKey:@"status"] intValue]==3)
        {
            //已经消费
            [subView addSubview:[self customImageView:CGRectMake(15, 5, 40, 40) image:IMAGE(@"order_3")]];
            
        }
        
        [subView addSubview:[self customLabel:CGRectMake(65, 5, 230, 40) color:[UIColor darkGrayColor] text:[stationInfo objectForKey:@"stationName"] alignment:-1 font:15.0]];
    }
    else
    {
        if ([[stationInfo objectForKey:@"type"] intValue]==0)
        {
            [subView addSubview:[self customLabel:CGRectMake(15, 5, 290, 40) color:[UIColor darkGrayColor] text:[[stationInfo objectForKey:@"station"] objectForKey:@"name"]alignment:-1 font:15.0]];
        }
        else
        {
            [subView addSubview:[self customLabel:CGRectMake(15, 5, 290, 40) color:[UIColor darkGrayColor] text:[[stationInfo objectForKey:@"activity"] objectForKey:@"title"]alignment:-1 font:15.0]];
        }
        
    }

    
    UILabel *lbl2=[[UILabel alloc] initWithFrame:CGRectMake(0, 49, WIDTH, 1)];
    lbl2.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [subView addSubview:lbl2];
    [mainView addSubview:subView];
   
    UIView *bottomView=nil;
    if (state==0)
    {
        NSArray *temp=[stationInfo objectForKey:@"serviceList"];
        bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, WIDTH, 200+20*temp.count+20)];
        bottomView.backgroundColor=[UIColor whiteColor];
        
        UILabel *lbl_=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
        lbl_.backgroundColor=kUIColorFromRGB(CommonLinebg);
        [bottomView addSubview:lbl_];
        
        UILabel *lbl_2=[[UILabel alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height-1, WIDTH, 1)];
        lbl_2.backgroundColor=kUIColorFromRGB(CommonLinebg);
        [bottomView addSubview:lbl_2];
        
        NSArray *titleArray=[NSArray arrayWithObjects:@"车型",@"时间",@"联系人",@"电话",@"预约项目", nil];
        NSArray *valueArray=[NSArray arrayWithObjects:[stationInfo objectForKey:@"carName"],[stationInfo objectForKey:@"startTime"],[stationInfo objectForKey:@"contact"],[stationInfo objectForKey:@"mobile"], nil];
        for (int i=0; i<5; i++)
        {
            [bottomView addSubview:[self customLabel:CGRectMake(15, 5+50*i,60, 40) color:[UIColor darkGrayColor] text:[titleArray objectAtIndex:i] alignment:-1 font:15.0]];
            
            
            if (i<4)
            {
                UILabel *lblm=[[UILabel alloc] initWithFrame:CGRectMake(10, 49.5+(50*i), WIDTH-20, 0.5)];
                lblm.backgroundColor=kUIColorFromRGB(CommonLinebg);
                [bottomView addSubview:lblm];
            }
            
            if (i==4)
            {
                for (int j=0; j<[[stationInfo objectForKey:@"serviceList"] count]; j++)
                {
                    [bottomView addSubview:[self customLabel:CGRectMake(80, 5+50*i+20*j, 210, 20) color:[UIColor darkGrayColor] text:[[[stationInfo objectForKey:@"serviceList"] objectAtIndex:j] objectForKey:@"name"] alignment:-1 font:13.0]];
                }
            }
            else
            {
                [bottomView addSubview:[self customLabel:CGRectMake(80, 5+50*i,210, 40) color:[UIColor darkGrayColor] text:[valueArray objectAtIndex:i] alignment:-1 font:15.0]];
            }
        }

    }
    else
    {
        NSArray *temp=nil;
        if ([[stationInfo objectForKey:@"type"] intValue]==0)
        {
            temp=[stationInfo objectForKey:@"serviceList"];
        }
        else
        {
            temp=[stationInfo objectForKey:@"stationList"];
        }
        
        //订单号，金额，预约项目，
        bottomView=[[UIView alloc] initWithFrame:CGRectMake(0, 80, WIDTH,150+20*temp.count+20)];
        bottomView.backgroundColor=[UIColor clearColor];
        
        UILabel *lbl_=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 1)];
        lbl_.backgroundColor=kUIColorFromRGB(CommonLinebg);
        [bottomView addSubview:lbl_];
        
        UILabel *lbl_2=[[UILabel alloc] initWithFrame:CGRectMake(0, bottomView.frame.size.height-1, WIDTH, 1)];
        lbl_2.backgroundColor=kUIColorFromRGB(CommonLinebg);
        [bottomView addSubview:lbl_2];

        NSArray *titleArray=nil;
        NSArray *valueArray=nil;
        if ([[stationInfo objectForKey:@"type"] intValue]==0)
        {
            titleArray=[NSArray arrayWithObjects:@"订单号",@"金额",@"串号",@"预约项目", nil];
            valueArray=[NSArray arrayWithObjects:[stationInfo objectForKey:@"no"],[NSString stringWithFormat:@"¥%@",[[stationInfo objectForKey:@"totalFee"] stringValue] ],[stationInfo objectForKey:@"qrValue"], nil];
        }
        else
        {
            titleArray=[NSArray arrayWithObjects:@"订单号",@"金额",@"串号",@"预约店铺", nil];
            valueArray=[NSArray arrayWithObjects:[stationInfo objectForKey:@"no"],[NSString stringWithFormat:@"¥%@",[[[stationInfo objectForKey:@"activity"] objectForKey:@"discountPrice"] stringValue] ],[stationInfo objectForKey:@"qrValue"], nil];
        }
        
        for (int i=0; i<titleArray.count; i++)
        {
            [bottomView addSubview:[self customLabel:CGRectMake(15, 5+50*i,60, 40) color:[UIColor darkGrayColor] text:[titleArray objectAtIndex:i] alignment:-1 font:15.0]];
            
            if (i<titleArray.count-1)
            {
                UILabel *lblm=[[UILabel alloc] initWithFrame:CGRectMake(10, 49.5+(50*i), WIDTH-20, 0.5)];
                lblm.backgroundColor=kUIColorFromRGB(CommonLinebg);
                [bottomView addSubview:lblm];
            }
            
            if (i==titleArray.count-1)
            {
                if ([[stationInfo objectForKey:@"type"] intValue]==0)
                {
                    for (int j=0; j<[[stationInfo objectForKey:@"serviceList"] count]; j++)
                    {
                        [bottomView addSubview:[self customLabel:CGRectMake(80, 15+50*i+20*j, 210, 20) color:[UIColor darkGrayColor] text:[[[stationInfo objectForKey:@"serviceList"] objectAtIndex:j] objectForKey:@"serviceName"] alignment:-1 font:13.0]];
                    }
                }
                else
                {
                    for (int j=0; j<[[stationInfo objectForKey:@"stationList"] count]; j++)
                    {
                        //NSLog(@"sssss::%@",[[[stationInfo objectForKey:@"stationList"] objectAtIndex:j] objectForKey:@"name"]);
                        
                        [bottomView addSubview:[self customLabel:CGRectMake(80, 15+50*i+20*j, 210, 20) color:[UIColor darkGrayColor] text:[[[stationInfo objectForKey:@"stationList"] objectAtIndex:j] objectForKey:@"name"] alignment:-1 font:13.0]];
                    }
                }
               
            }
            else
            {
                
                [bottomView addSubview:[self customLabel:CGRectMake(80, 5+50*i,210, 40) color:[UIColor darkGrayColor] text:[valueArray objectAtIndex:i] alignment:-1 font:15.0]];
            }
        }
        
        UIImageView *qr=[[UIImageView alloc] initWithFrame:CGRectMake((self.view.frame.size.width-250)/2, bottomView.frame.size.height+30, 250, 250)];
        //[qr setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[stationInfo objectForKey:@"qrUrl"] ]] placeholderImage:nil];
        [qr sd_setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@",[stationInfo objectForKey:@"qrUrl"] ]] placeholderImage:nil];
        
        [bottomView addSubview:qr];
        
        [bottomView addSubview:[self customLabel:CGRectMake(0, bottomView.frame.size.height+50+250, WIDTH, 20) color:[UIColor blackColor] text:@"如有任何问题,请致电:4000052270" alignment:0 font:16.0]];
        
    }
    
    if (state==0)
    {
        infoScrollView.contentSize=CGSizeMake(WIDTH, bottomView.frame.size.height+80+100);
    }
    else
    {
        infoScrollView.contentSize=CGSizeMake(WIDTH, bottomView.frame.size.height+80+400);
    }
  
    
    [mainView addSubview:bottomView];
    
    [infoScrollView addSubview:mainView];
    
    [infoScrollView addSubview:[self customButton:CGRectMake(0, bottomView.frame.size.height+370, WIDTH, 40) tag:1 title:nil state:0 image:nil selectImage:nil color:[UIColor blueColor] enable:YES]];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        UIWebView*callWebview =[[UIWebView alloc] init] ;
        NSURL *telURL =[NSURL URLWithString:[NSString stringWithFormat:@"tel://%@",@"4000052270"]];
        [callWebview loadRequest:[NSURLRequest requestWithURL:telURL]];
        [self.view addSubview:callWebview];
    }
}

@end
