//
//  BaseViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "BaseViewController.h"

@interface BaseViewController ()

@end

@implementation BaseViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)showLeft
{
    [[AppDelegate setGlobal].rootController showLeftController:YES];
}

-(UIBarButtonItem *)LeftBarButton
{
    //导航栏上的更多按钮
    UIImage *image1=IMAGE(@"tab_more");//返回按钮的背景
    UIButton *btn=[UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame=CGRectMake(0, 0, 25,25);
    [btn setBackgroundImage:image1 forState:UIControlStateNormal];
    [btn addTarget:self action:@selector(showLeft) forControlEvents:UIControlEventTouchUpInside];
    UIBarButtonItem *backItem = [[UIBarButtonItem alloc] initWithCustomView:btn];
    return backItem;
    
}




//背景
-(void)skinOfBackground
{

    NSString *png=[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultBackground"];
    if (!png)
    {
        png=@"bg_1";//默认图片
    }

    bg=[[UIImageView alloc] initWithFrame:CGRectMake(0, 0, WIDTH,480+(iPhone5?88:0))];
    bg.image=IMAGE(png);
    
    [self.view addSubview:bg];
                                                                  
}

//更改背景图片
-(void)changeBgImg
{
    NSString *png=[[NSUserDefaults standardUserDefaults] objectForKey:@"DefaultBackground"];
    if (!png)
    {
       png=@"bg_1";//默认图片
    }
    
    bg.image=IMAGE(png);
    
}

//用户自定义文本框
//alignment,－1:left,0:center,1:right
-(UILabel *)customLabel:(CGRect)frame color:(UIColor *)color text:(NSString *)text alignment:(int)alignment font:(CGFloat)font
{
    UILabel *customLabel=[[UILabel alloc] initWithFrame:frame];
    customLabel.backgroundColor=[UIColor clearColor];
    customLabel.text=text;
    customLabel.textColor=color;
    if (alignment==-1)
    {
        customLabel.textAlignment=NSTextAlignmentLeft;
    }
    else if (alignment==0)
    {
        customLabel.textAlignment=NSTextAlignmentCenter;
    }
    else
    {
        customLabel.textAlignment=NSTextAlignmentRight;
    }
    customLabel.font=[UIFont systemFontOfSize:font];
    
    return customLabel;
}


//用户自定义按钮
/*
 state  0:UIControlStateNormal 1:UIControlStateSelected
 
 */
-(UIButton *)customButton:(CGRect)frame tag:(int)tag title:(NSString *)title state:(int)state image:(UIImage *)image selectImage:(UIImage *)selectImage color:(UIColor *)color enable:(BOOL)enable
{
    UIButton *customButton=[UIButton buttonWithType:UIButtonTypeCustom];
    customButton.frame=frame;
    
    if (state==0)
    {
        [customButton setTitle:title forState:UIControlStateNormal];
        [customButton setTitleColor:color forState:UIControlStateNormal];
        [customButton setBackgroundImage:image forState:UIControlStateNormal];
        [customButton setBackgroundImage:selectImage forState:UIControlStateHighlighted];
        
    }
    else if (state==1)
    {
        [customButton setTitle:title forState:UIControlStateSelected];
        [customButton setTitleColor:color forState:UIControlStateNormal];
        [customButton setBackgroundImage:image forState:UIControlStateNormal];
        [customButton setBackgroundImage:selectImage forState:UIControlStateHighlighted];
    }
    
    
    customButton.tag=tag;
    customButton.enabled=enable;
    [customButton addTarget:self action:@selector(customEvent:) forControlEvents:UIControlEventTouchUpInside];
    
    return customButton;
}

-(void)customEvent:(UIButton *)sender//用户点击事件
{
    
}

//用户自定义图片视图
-(UIImageView *)customImageView:(CGRect)frame image:(UIImage *)image
{
    UIImageView *customImageView=[[UIImageView alloc] initWithFrame:frame];
    customImageView.image=image;
    
    return customImageView;
}


//用户自定义文本框
-(UITextField *)customTextField:(CGRect)frame placeholder:(NSString *)placeholder color:(UIColor *)color text:(NSString *)text alignment:(int)alignment font:(CGFloat)font
{
    UITextField *customTextField=[[UITextField alloc] initWithFrame:frame];
    customTextField.delegate=self;
    customTextField.placeholder=placeholder;
    customTextField.textColor=color;
    customTextField.text=text;
    customTextField.returnKeyType=UIReturnKeyDone;
    if (alignment==-1)
    {
        customTextField.textAlignment=NSTextAlignmentLeft;
    }
    else if (alignment==0)
    {
        customTextField.textAlignment=NSTextAlignmentCenter;
    }
    else
    {
        customTextField.textAlignment=NSTextAlignmentRight;
    }
    customTextField.font=[UIFont systemFontOfSize:font];
    
    
    return customTextField;
}

-(UIView *)customView:(CGRect)frame labelTitle:(NSString *)labelTitle buttonTag:(int)buttonTag
{
    UIView *customView=[[UIView alloc] initWithFrame:frame];
    customView.backgroundColor=[UIColor clearColor];
    customView.layer.cornerRadius = 5;//(值越大，角就越圆)
    customView.layer.masksToBounds = YES;
    customView.layer.borderWidth=1.0;
    customView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [customView addSubview:[self customLabel:customView.bounds color:[UIColor darkGrayColor] text:labelTitle alignment:0 font:16.0]];
    [customView addSubview:[self customButton:customView.bounds tag:buttonTag title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    return customView;
    
}


-(UILabel *)drawLine:(CGRect)frame drawColor:(UIColor *)drawColor
{
    UILabel *line=[[UILabel alloc] initWithFrame:frame];
    line.backgroundColor=drawColor;
    
    return line;
}


-(void)refreshAccount
{
    
    document= [[ReadWriteToDocument alloc]init];
    document.folderName=@"anchexin";
    userDic=[document readDataFromDocument:@"user" IsArray:NO];
    carArray=[document readDataFromDocument:@"car" IsArray:YES];
    weatheOilDic=[document readDataFromDocument:@"weatherOil" IsArray:NO];
    
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
   
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(changeBgImg) name:@"changeBgImg" object:nil];
    
    //设置刷新账户
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshAccount) name:@"refreshAccount" object:nil];
    
    
    document= [[ReadWriteToDocument alloc]init];
    document.folderName=@"anchexin";
    userDic=[document readDataFromDocument:@"user" IsArray:NO];
    carArray=[document readDataFromDocument:@"car" IsArray:YES];
    weatheOilDic=[document readDataFromDocument:@"weatherOil" IsArray:NO];
    
}

#pragma -
#pragma -request请求
-(AFJSONFactory *)JsonFactory
{
    AFJSONFactory *jsonFactory=[[AFJSONFactory alloc] init];
    jsonFactory.delegate=self;
    
    return jsonFactory;
}


#pragma -
#pragma --JSONDataReturnDelegate
#pragma --SUCCESS
-(void)JSONSuccess:(id)responseObject
{
    
}


#pragma --ERROR
-(void)JSONError:(NSError *)error
{
    [ToolLen ShowWaitingView:NO];
    //NSLog(@"returnError:%@",error);
    [self alertOnly:@"服务器失误"];
  
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)alertOnly:(NSString *)content
{
    UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                  message:content
                                                 delegate:nil
                                        cancelButtonTitle:@"确定"
                                        otherButtonTitles:nil];
    
    [alert show];
}

-(void)alertNoValid
{
    [self alertOnly:@"您当前是体验账户,如需操作,请注销后注册或登录"];
}

@end
