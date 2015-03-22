//
//  FeedbackViewController.m
//  anchexin
//
//  Created by cgx on 14-10-22.
//
//

#import "FeedbackViewController.h"

@interface FeedbackViewController ()

@end

@implementation FeedbackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    
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
    
    [mainView addSubview:[self customView:CGRectMake(60, 180, 200, 40) labelTitle:@"发表" buttonTag:1]];
    [self.view addSubview:mainView];
    
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        if (commentTextView.text.length>0)
        {
            [ToolLen ShowWaitingView:YES];
            [[self JsonFactory]addUserAdvice:commentTextView.text action:@"addUserAdvice"];
        }
        else
        {
            [self alertOnly:@"您未输入评论内容"];
        }
        
    }
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
    //NSLog(@"responseObject::%@",responseObject);
    
    [ToolLen ShowWaitingView:NO];
    
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject)
    {
        //commentTextView.text=@"";
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"谢谢您提出宝贵的意见,我们会积极改进" delegate:self
                                            cancelButtonTitle:nil
                                            otherButtonTitles:@"确定", nil];
        
        [alert show];
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
