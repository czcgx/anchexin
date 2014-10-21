//
//  ModifyPwdViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "ModifyPwdViewController.h"

@interface ModifyPwdViewController ()

@end

@implementation ModifyPwdViewController
@synthesize tag;

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

    if (tag==1)
    {
        //修改手机号
        modifyArray=[[NSArray alloc] initWithObjects:@"旧手机号",@"新手机号",@"验证码", nil];
    }
    else
    {
        //修改密码
        modifyArray=[[NSArray alloc] initWithObjects:@"当前密码",@"新密码",@"确认密码", nil];
        self.navigationItem.leftBarButtonItem=[self LeftBarButton];
        
    }
    
    
    //背景视图
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    UILabel *bgLine=[[UILabel alloc] initWithFrame:CGRectMake(0, 19, WIDTH, 1)];
    bgLine.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [mainView addSubview:bgLine];
    
    modifyTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 20, WIDTH, 150)];
    modifyTableView.delegate=self;
    modifyTableView.dataSource=self;
    modifyTableView.backgroundView=nil;
    modifyTableView.backgroundColor=[UIColor clearColor];
    modifyTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    modifyTableView.scrollEnabled=NO;
    [mainView addSubview:modifyTableView];
    
    UILabel *bgLine1=[[UILabel alloc] initWithFrame:CGRectMake(0, 170, WIDTH, 1)];
    bgLine1.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [mainView addSubview:bgLine1];
    
    
    UIView *buttonView=[[UIView alloc] initWithFrame:CGRectMake(80, 190, 160, 35)];
    buttonView.backgroundColor=[UIColor clearColor];
    buttonView.layer.cornerRadius = 5;//(值越大，角就越圆)
    buttonView.layer.masksToBounds = YES;
    buttonView.layer.borderWidth=1.0;
    buttonView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
    [buttonView addSubview:[self customImageView:CGRectMake(30, 5, 24, 24) image:IMAGE(@"orderhealth")]];
    [buttonView addSubview:[self customLabel:CGRectMake(60,7, 80, 20) color:[UIColor darkGrayColor] text:@"保存修改" alignment:-1 font:15.0]];
    [buttonView addSubview:[self customButton:buttonView.bounds tag:11 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    
    
    [mainView addSubview:buttonView];
     
    [self.view addSubview:mainView];

}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [modifyArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    ModifyCell *cell=(ModifyCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"ModifyCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.nameLabel.text=[modifyArray objectAtIndex:indexPath.row];
    if (tag==1)
    {
         cell.editLabel.text=[userDic objectForKey:@"mobile"];
         cell.inputTextField.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
        
    }
    else
    {
         cell.editLabel.text=[userDic objectForKey:@"userpwd"];
         cell.inputTextField.keyboardType=UIKeyboardTypeASCIICapable;
    }
   
    cell.inputTextField.delegate=self;
    cell.inputTextField.tag=indexPath.row;
    UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 49.5, WIDTH-30, 0.5)];
    showLineLabel.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [cell.contentView addSubview:showLineLabel];
    
    if (indexPath.row>0)
    {
        cell.inputTextField.hidden=NO;
        cell.editLabel.hidden=YES;
    }
    else
    {
        cell.inputTextField.hidden=YES;
        cell.editLabel.hidden=NO;
    }
    
    if (indexPath.row==2)
    {
        showLineLabel.hidden=YES;
    }
    else
    {
        showLineLabel.hidden=NO;
    }
    
    if (tag==1 && indexPath.row==2)
    {
        cell.sendView.hidden=NO;
        cell.sendView.layer.cornerRadius = 5;//(值越大，角就越圆)
        cell.sendView.layer.masksToBounds = YES;
        cell.sendView.layer.borderWidth=1.0;
        cell.sendView.layer.borderColor=[[UIColor darkGrayColor] CGColor];
        
        [cell.sendButton addTarget:self action:@selector(sendMessage:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    else
    {
        cell.sendView.hidden=YES;
    }
 
    return cell;
}

-(void)sendMessage:(UIButton *)sender
{
    //NSLog(@"sender");
    NSIndexPath *path=[NSIndexPath indexPathForRow:1 inSection:0];
    ModifyCell *cell=(ModifyCell *)[modifyTableView cellForRowAtIndexPath:path];
    
    //NSLog(@"cell::%@",cell.inputTextField.text);
    
    if (cell.inputTextField.text.length==11)
    {
        requestTimes=1;
        phoneNumber=cell.inputTextField.text;
        [[self JsonFactory]set_setMobileNumber:cell.inputTextField.text action:@"setMobileNumber"];
    }
    else
    {
        [self alertOnly:@"您输入的新手机号有误,请核对后重新输入"];
    }

    
    
}


-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        [self alertOnly:@"验证码已发送..."];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithDictionary:userDic];
        
        [temp removeObjectForKey:@"mobile"];
        
        [temp setObject:[responseObject objectForKey:@"mobilenumber"] forKey:@"mobile"];
        
        [document saveDataToDocument:@"user" fileData:temp];
        //NSLog(@"temp::%@",temp);
        
        [[NSNotificationCenter defaultCenter] postNotificationName:@"refresh" object:nil];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==3)
     {
         NSIndexPath *path1=[NSIndexPath indexPathForRow:1 inSection:0];
         ModifyCell *cell1=(ModifyCell *)[modifyTableView cellForRowAtIndexPath:path1];
         //NSLog(@"cell::%@",cell1.inputTextField.text);
         
         NSMutableDictionary *temp=[[NSMutableDictionary alloc] initWithDictionary:userDic];
         [temp removeObjectForKey:@"userpwd"];
         [temp setObject:cell1.inputTextField.text forKey:@"userpwd"];
         
         [document saveDataToDocument:@"user" fileData:temp];
         //NSLog(@"temp::%@",temp);
         [self alertOnly:@"密码修改成功"];
     }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
        
    }
}
-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==11)
    {
       // NSLog(@"edit");
        
        if (tag==1)//修改手机号
        {
            NSIndexPath *path=[NSIndexPath indexPathForRow:2 inSection:0];
            ModifyCell *cell=(ModifyCell *)[modifyTableView cellForRowAtIndexPath:path];
            
            //NSLog(@"cell::%@",cell.inputTextField.text);
            if (phoneNumber.length==11 && cell.inputTextField.text.length>0)
            {
                requestTimes=2;
                [[self JsonFactory] get_checksecret:phoneNumber secret:cell.inputTextField.text action:@"checksecret"];
            }
            else
            {
                [self alertOnly:@"手机号或者验证码有误"];
            }

        }
        else
        {
            if ([[userDic objectForKey:@"valid"] intValue]==0)
            {
                [self alertNoValid];
            }
            else
            {
                //修改密码
                NSIndexPath *path0=[NSIndexPath indexPathForRow:0 inSection:0];
                ModifyCell *cell0=(ModifyCell *)[modifyTableView cellForRowAtIndexPath:path0];
                //NSLog(@"cell::%@",cell0.editLabel.text);
                
                
                NSIndexPath *path1=[NSIndexPath indexPathForRow:1 inSection:0];
                ModifyCell *cell1=(ModifyCell *)[modifyTableView cellForRowAtIndexPath:path1];
                //NSLog(@"cell::%@",cell1.inputTextField.text);
                
                NSIndexPath *path2=[NSIndexPath indexPathForRow:1 inSection:0];
                ModifyCell *cell2=(ModifyCell *)[modifyTableView cellForRowAtIndexPath:path2];
               // NSLog(@"cell::%@",cell2.inputTextField.text);
                
                if ([cell1.inputTextField.text isEqualToString:cell2.inputTextField.text])
                {
                    requestTimes=3;
                    [[self JsonFactory]set_setPassword:cell0.editLabel.text newpassword:cell1.inputTextField.text action:@"setPassword"];
                }
                else
                {
                    [self alertOnly:@"您输入的2次密码不同"];
                }

            }
        }
        
    }
}


-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
