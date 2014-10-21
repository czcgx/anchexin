//
//  SkinViewController.m
//  anchexin
//
//  Created by cgx on 14-9-5.
//
//

#import "SkinViewController.h"

@interface SkinViewController ()

@end

@implementation SkinViewController

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
    
    mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    NSInteger png=[[NSUserDefaults standardUserDefaults]integerForKey:@"skin_Flag"];
    for (int i=0; i<3; i++)
    {
        UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(20+100*i, 20, 80, 80)];
        bgView.tag=i;
        bgView.backgroundColor=[UIColor clearColor];
        
        [bgView addSubview:[self customImageView:bgView.bounds image:IMAGE(@"skinbg")]];
        
        NSString *icon=[NSString stringWithFormat:@"bg_%d_thumb",i+1];
        [bgView addSubview:[self customImageView:CGRectMake(5, 5, 70, 70) image:IMAGE(icon)]];
        
        UIImageView *img=[self customImageView:CGRectMake(55, 10, 15, 15) image:IMAGE(@"skinchoose")];
        img.tag=i+100;
        [bgView addSubview:img];
        if (i==png)
        {
            img.hidden=NO;
        }
        else
        {
            img.hidden=YES;
        }
        
        [bgView addSubview:[self customButton:bgView.bounds tag:i title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
        
        [mainView addSubview:bgView];
        
    }

    [self.view addSubview:mainView];
    
}

-(void)customEvent:(UIButton *)sender
{
    [MobClick event:@"skinButton"];//统计换肤按钮
    
    for (UIView *sub in [mainView subviews])
    {
        for (UIView *subsub in [sub subviews])
        {
            //NSLog(@"subsub::%@",subsub);
            if ([subsub isKindOfClass:[UIImageView class]] && subsub.tag>99)
            {
                UIImageView *img=(UIImageView *)subsub;
                if (subsub.tag-100==sender.tag)
                {
                    img.hidden=NO;
                }
                else
                {
                    img.hidden=YES;
                }

            }
        
        }
    }

    [[NSUserDefaults standardUserDefaults] setInteger:sender.tag forKey:@"skin_Flag"];
    [[NSUserDefaults standardUserDefaults] setObject:[NSString stringWithFormat:@"bg_%d",(int)(sender.tag+1)] forKey:@"DefaultBackground"];
    
     //通知
     [[NSNotificationCenter defaultCenter] postNotificationName:@"changeBgImg" object:nil userInfo:nil];
     //通知
     [[NSNotificationCenter defaultCenter] postNotificationName:@"homeSkin" object:nil userInfo:nil];
    
     [self alertOnly:@"更换皮肤成功"];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
