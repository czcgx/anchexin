//
//  BlindOBDViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "BlindOBDViewController.h"

@interface BlindOBDViewController ()

@end

@implementation BlindOBDViewController

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
    
    //背景视图
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(0xF1F1F1);
    
    UILabel *bgLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 19, WIDTH, 1)];
    bgLine.backgroundColor=kUIColorFromRGB(0xE0E0E0);
    [mainView addSubview:bgLine];

    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 20, WIDTH, 50)];
    bgView.backgroundColor=[UIColor whiteColor];
    
    [bgView addSubview:[self customLabel:CGRectMake(20, 15, 100, 20) color:[UIColor lightGrayColor] text:@"请输入SN号" alignment:-1 font:15.0]];
    
    snTextField=[[UITextField alloc] initWithFrame:CGRectMake(120, 10, 200, 30)];
    [snTextField setBorderStyle:UITextBorderStyleNone];
    snTextField.delegate=self;
    snTextField.returnKeyType=UIReturnKeyDone;
    snTextField.textColor=[UIColor darkGrayColor];
    snTextField.font=[UIFont systemFontOfSize:15.0];
    [bgView addSubview:snTextField];
    [mainView addSubview:bgView];
    
    UILabel *bgLine1=[[UILabel alloc] initWithFrame:CGRectMake(0, 70, WIDTH, 1)];
    bgLine1.backgroundColor=kUIColorFromRGB(0xE0E0E0);
    [mainView addSubview:bgLine1];
    
   
    UIView *buttonView=[[UIView alloc] initWithFrame:CGRectMake(80, 90, 160, 30)];
    buttonView.backgroundColor=[UIColor clearColor];
    buttonView.layer.cornerRadius = 5;//(值越大，角就越圆)
    buttonView.layer.masksToBounds = YES;
    buttonView.layer.borderWidth=1.0;
    buttonView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [buttonView addSubview:[self customImageView:CGRectMake(30, 3, 24, 24) image:IMAGE(@"orderhealth")]];
    [buttonView addSubview:[self customLabel:CGRectMake(60,5, 80, 20) color:[UIColor darkGrayColor] text:@"保存修改" alignment:-1 font:15.0]];
    [buttonView addSubview:[self customButton:buttonView.bounds tag:11 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [mainView addSubview:buttonView];
    
    [self.view addSubview:mainView];

}


-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==11)
    {
        //NSLog(@"save");
    }
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    return YES;
}
@end
