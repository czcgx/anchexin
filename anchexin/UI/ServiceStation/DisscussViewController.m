//
//  DisscussViewController.m
//  anchexin
//
//  Created by cgx on 14-9-16.
//
//

#import "DisscussViewController.h"

@interface DisscussViewController ()

@end

@implementation DisscussViewController
@synthesize stationId;

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
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    commentTextView=[[UITextView alloc] initWithFrame:CGRectMake(10, 10, 300, 150)];
    commentTextView.font=[UIFont systemFontOfSize:15.0];
    commentTextView.returnKeyType=UIReturnKeyDone;
    commentTextView.delegate=self;
    commentTextView.layer.cornerRadius = 6;//(值越大，角就越圆)
    commentTextView.layer.masksToBounds = YES;
    commentTextView.layer.borderWidth=0.5;
    commentTextView.layer.borderColor=[[UIColor grayColor] CGColor];
    [mainView addSubview:commentTextView];
    
    upscore=0;
    TQStarRatingView *starRatingView = [[TQStarRatingView alloc] initWithFrame:CGRectMake(60, 170, 200, 30) numberOfStar:5];
    starRatingView.delegate = self;
    [mainView addSubview:starRatingView];
    
    [mainView addSubview:[self customView:CGRectMake(100, 210, 120, 40) labelTitle:@"发表" buttonTag:1]];
    [self.view addSubview:mainView];
    
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        if (commentTextView.text.length>0)
        {
            if (upscore>0)
            {
                [[self JsonFactory]set_setRepairStationComment:stationId userid:[userDic  objectForKey:@"userid"] content:commentTextView.text satisfaction:[NSString stringWithFormat:@"%d",upscore] action:@"setRepairStationComment"];
            }
            else
            {
                [self alertOnly:@"请选择满意度"];
            }
            
        }
        else
        {
            [self alertOnly:@"您未输入评论内容"];
        }
      
    }
}

-(void)starRatingView:(TQStarRatingView *)view score:(float)score
{
    //NSLog(@"score::%f",score);
    upscore=(int)score;
}

- (BOOL)textView:(UITextView *)textView1 shouldChangeTextInRange:(NSRange)range

 replacementText:(NSString *)text
{
    if ([text isEqualToString:@"\n"])
    {
        [textView1 resignFirstResponder];
        return NO;
    }
    
    return YES;
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];

    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject)
    {
        commentTextView.text=@"";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"谢谢您提出宝贵的意见,我们会积极改进" delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
}


-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==0)
    {
        //设置通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshDisscuss" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
