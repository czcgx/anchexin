//
//  IllegalSearchViewController.m
//  anchexin
//
//  Created by cgx on 14-8-5.
//
//

#import "IllegalSearchViewController.h"

@interface IllegalSearchViewController ()

@end

@implementation IllegalSearchViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

//刷新城市
-(void)refreshCity:(NSNotification *)sender
{
   // NSLog(@"sender::%@",sender.object);
  
    txt3.text=@"";
    txt4.text=@"";
    
    dic=[[NSDictionary alloc] initWithDictionary:sender.object];
    txt2.text=[sender.object objectForKey:@"name"];//违章区域
   
    //engine,需不需要发动机号，engineNo：需要几位发动机号码
    if ([[sender.object objectForKey:@"engine"] intValue]==1)//需要填写发动机号
    {
        if ([[sender.object objectForKey:@"engineNo"] intValue]==0)
        {
            txt3.placeholder=@"要求填写完整的发动机号";
        }
        else
        {
            txt3.placeholder=[NSString stringWithFormat:@"要求填写后%d位发动机号",[[sender.object objectForKey:@"engineNo"] intValue]];
        }
    }
    else
    {
        txt3.placeholder=@"可选";
    }
    
    // classa,需不需要填写车架号，classaNo：需要几位车架号码
    if ([[sender.object  objectForKey:@"classa"] intValue]==1)//需要填写发动机号
    {
        if ([[sender.object  objectForKey:@"classaNo"] intValue]==0)
        {
            txt4.placeholder=@"要求填写完整的车架号";
        }
        else
        {
            txt4.placeholder=[NSString stringWithFormat:@"要求填写后%d位车架号",[[sender.object  objectForKey:@"classaNo"] intValue]];
        }
    }
    else
    {
        txt4.placeholder=@"可选";
    }

}

-(void)viewWillAppear:(BOOL)animated
{
    [MobClick event:@"illegalPage"];//统计查违章页面
}


- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    
    //设置通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refreshCity:) name:@"refreshCity" object:nil];
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    
    UIView *subView=[[UIView alloc] initWithFrame:CGRectMake(0, 15, WIDTH, 200)];
    subView.backgroundColor=[UIColor whiteColor];
    [mainView addSubview:subView];
    
    for (int i=0; i<5; i++)
    {
        UILabel *labelbackground=nil;
        if (i==0 || i==4)
        {
            labelbackground=[[UILabel alloc] initWithFrame:CGRectMake(0, 0+50*i, WIDTH, 1)];
        }
        else
        {
            labelbackground=[[UILabel alloc] initWithFrame:CGRectMake(15, 0+50*i, WIDTH-30, 1)];
        }
        labelbackground.backgroundColor=[UIColor colorWithRed:232.0/255.0 green:232.0/255.0 blue:232.0/255.0 alpha:1.0];
        [subView addSubview:labelbackground];
    }
    //车牌号
    [mainView addSubview:[self customLabel:CGRectMake(17,15+15+1,100 , 20) color:[UIColor lightGrayColor] text:@"车牌号" alignment:-1 font:15.0]];
    txt1=[self customTextField:CGRectMake(110, 15+15+1, 200, 20) placeholder:@"如:沪A12345" color:[UIColor lightGrayColor] text:@"" alignment:-1 font:15.0];
    [mainView addSubview:txt1];
    [mainView addSubview:[self customImageView:CGRectMake(270, 15+10, 35, 35) image:IMAGE(@"history")]];//历史记录
    [mainView addSubview:[self customButton:CGRectMake(270, 15+10, 35, 35) tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    //违章区域
    [mainView addSubview:[self customLabel:CGRectMake(17, 15+65+1,100 , 20) color:[UIColor lightGrayColor] text:@"违章区域" alignment:-1 font:15.0]];
    txt2=[self customTextField:CGRectMake(110, 15+65+1, 200, 20) placeholder:@"点击按钮获取城市" color:[UIColor lightGrayColor] text:@"" alignment:-1 font:15.0];
    txt2.enabled=NO;
    [mainView addSubview:txt2];
    [mainView addSubview:[self customImageView:CGRectMake(272, 65+13, 30, 30) image:IMAGE(@"ill_pull")]];
    [mainView addSubview:[self customButton:CGRectMake(270, 65+10, 35, 35) tag:2 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    
    //发动机号
    [mainView addSubview:[self customLabel:CGRectMake(17, 15+115+1,100 , 20) color:[UIColor lightGrayColor] text:@"发动机号" alignment:-1 font:15.0]];
    txt3=[self customTextField:CGRectMake(110, 15+115+1, 200, 20) placeholder:@"" color:[UIColor lightGrayColor] text:@"" alignment:-1 font:15.0];
    txt3.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [mainView addSubview:txt3];
    
    //车驾号
    [mainView addSubview:[self customLabel:CGRectMake(17, 15+165+1,100 , 20) color:[UIColor lightGrayColor] text:@"车驾号" alignment:-1 font:15.0]];
    txt4=[self customTextField:CGRectMake(110, 15+165+1, 200, 20) placeholder:@"" color:[UIColor lightGrayColor] text:@"" alignment:-1 font:15.0];
    txt4.keyboardType=UIKeyboardTypeNumbersAndPunctuation;
    [mainView addSubview:txt4];
    
    
    UILabel *desLabel=[self customLabel:CGRectMake(10, 220,WIDTH-20 , 40) color:[UIColor colorWithRed:210.0/255.0 green:210.0/255.0 blue:210.0/255.0 alpha:1.0] text:@"以上信息为所选地区交管局要求填写信息，会被严格保密，请放心填写。" alignment:0 font:12.0];
    desLabel.numberOfLines=0;
    [mainView addSubview:desLabel];
    
    //立即查询按钮
    UIView *buttonView=[[UIView alloc] initWithFrame:CGRectMake(70, 270, 180, 35)];
    buttonView.backgroundColor=[UIColor clearColor];
    buttonView.layer.cornerRadius = 5;//(值越大，角就越圆)
    buttonView.layer.masksToBounds = YES;
    buttonView.layer.borderWidth=1.0;
    buttonView.layer.borderColor=[[UIColor blackColor] CGColor];
    [buttonView addSubview:[self customImageView:CGRectMake(50, 8, 20, 20) image:IMAGE(@"search")]];
    [buttonView addSubview:[self customLabel:CGRectMake(70, 8, 100, 20) color:[UIColor blackColor] text:@"立即查询" alignment:-1 font:15.0]];
    
    [buttonView addSubview:[self customButton:buttonView.bounds tag:3 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    [mainView addSubview:buttonView];
    
    [self.view addSubview:mainView];
    
    
    if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

        //创建PickerView的信息
        picker= [[UIPickerView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 216)];//显示数据面板
        picker.delegate=self;//显示数据
        picker.dataSource=self;
        picker.showsSelectionIndicator = YES;//选中得显示杠
        picker.backgroundColor=[UIColor clearColor];
        
        alertController=[UIAlertController alertControllerWithTitle:nil message:@"\n\n\n\n\n\n\n\n\n\n\n\n" preferredStyle:UIAlertControllerStyleActionSheet];
        
        UIAlertAction *cancelAction = [UIAlertAction actionWithTitle:@"完成" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action)
                                       
                                       {
                                           
                                           ////todo
                                           
                                       }];
        
        [alertController.view addSubview:picker];
        [alertController addAction:cancelAction];
        
    }
    else
    {
        
        //画板
        actionSheet=[[UIActionSheet alloc] initWithTitle:@"\n\n\n\n\n\n\n\n\n\n\n\n"
                                                delegate:self
                                       cancelButtonTitle:nil
                                  destructiveButtonTitle:nil
                                       otherButtonTitles:nil];
        
        UIToolbar *toolBar = [[UIToolbar alloc] initWithFrame:CGRectMake(0, 0, 320, 44)];
        toolBar.barStyle = UIBarStyleDefault;
        toolBar.backgroundColor=[UIColor clearColor];
        if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
        {
             toolBar.barTintColor=[UIColor blackColor];
        }
       
        //空白
        UIBarButtonItem *FixedButton=[[UIBarButtonItem alloc] initWithBarButtonSystemItem:
                                      UIBarButtonSystemItemFlexibleSpace
                                                                                   target: nil
                                                                                   action: nil];
        //完成
        UIBarButtonItem *RightButton=[[UIBarButtonItem alloc] initWithTitle:@"完成"
                                                                      style: UIBarButtonItemStyleDone
                                                                     target: self
                                                                     action: @selector(doneYes)];
        RightButton.tintColor=[UIColor whiteColor];
        //取消
        UIBarButtonItem *LeftButton=[[UIBarButtonItem alloc] initWithTitle:@"取消"
                                                                     style: UIBarButtonItemStyleDone
                                                                    target: self
                                                                    action: @selector(cancelNo)];
        LeftButton.tintColor=[UIColor whiteColor];
        NSArray *array = [[NSArray alloc] initWithObjects:LeftButton,FixedButton,FixedButton,FixedButton,RightButton, nil];
        [toolBar setItems: array];
        [actionSheet addSubview:toolBar];
        
        //创建PickerView的信息
        picker= [[UIPickerView alloc] initWithFrame:CGRectMake(0, 44, WIDTH, 216)];//显示数据面板
        picker.delegate=self;//显示数据
        picker.dataSource=self;
        picker.showsSelectionIndicator = YES;//选中得显示杠
        picker.backgroundColor=[UIColor whiteColor];
        //创建PickerView的信息
        [actionSheet addSubview:picker];//显示数据面板
        
    }

    
    
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject && requestFlag==2)
    {
        //搜索历史
        NSMutableArray *listArray=nil;
        NSArray *tempArray=[document readDataFromDocument:@"SearchList" IsArray:YES];
        int t=0;
        if (tempArray)
        {
            listArray=[[NSMutableArray alloc] initWithArray:tempArray];
            for (int i=0; i<[listArray count]; i++)
            {
                if ([txt1.text isEqualToString:[[listArray objectAtIndex:i]objectForKey:@"hphm"]])
                {
                    t=1;
                    break;
                }
            }
        }
        else
        {
            listArray=[[NSMutableArray alloc]init];
        }
        
        if (t==0)
        {
            NSMutableDictionary *searchDic= [NSMutableDictionary dictionaryWithCapacity:0];
            [searchDic setObject:[dic objectForKey:@"code"] forKey:@"code"];
            [searchDic setObject:txt3.text forKey:@"engineno"];
            [searchDic setObject:[dic objectForKey:@"name"] forKey:@"name"];
            [searchDic setObject:txt1.text forKey:@"hphm"];
            [searchDic setObject:txt4.text forKey:@"classno"];
            [listArray addObject:searchDic];
            
            [document saveDataToDocument:@"SearchList" fileData:listArray];//搜索历史
        }
        
        IllegalListViewController *illegal=[[IllegalListViewController alloc] init];
        illegal.title=@"违章记录";
        illegal.strdic=[responseObject objectForKey:@"result"];
        illegal.hidesBottomBarWhenPushed=YES;
        [self.navigationController pushViewController:illegal animated:YES];

    }
    if ([[responseObject objectForKey:@"errorcode"] intValue]==0 && responseObject && requestFlag==1)
    {
        
         //搜索历史
        // searchArray=[[NSArray alloc]initWithArray:[document readDataFromDocument:@"SearchList" IsArray:YES]];
        
        
        NSArray *cityArray=[[NSArray alloc]initWithArray:[document readDataFromDocument:@"City" IsArray:YES]];
        //NSLog(@"city::%@",cityArray);
        NSMutableArray *listArray=[[NSMutableArray alloc] initWithCapacity:0];
        
        for (int i=0; i<[[responseObject objectForKey:@"queryList"] count]; i++)
        {
            NSMutableDictionary *searchDic= [NSMutableDictionary dictionaryWithCapacity:0];
            [searchDic setObject:[[[responseObject objectForKey:@"queryList"] objectAtIndex:i] objectForKey:@"city"] forKey:@"code"];
            [searchDic setObject:[[[responseObject objectForKey:@"queryList"] objectAtIndex:i] objectForKey:@"engine_no"] forKey:@"engineno"];
            
            for (int j=0; j<cityArray.count; j++)
            {
                if ([[[[responseObject objectForKey:@"queryList"] objectAtIndex:i] objectForKey:@"city"] isEqualToString:[[cityArray objectAtIndex:j] objectForKey:@"code"]])
                {
                    [searchDic setObject:[[cityArray objectAtIndex:j] objectForKey:@"name"] forKey:@"name"];
                    
                    break;
                }
            }
            
            [searchDic setObject:[[[responseObject objectForKey:@"queryList"] objectAtIndex:i] objectForKey:@"hphm"] forKey:@"hphm"];
            [searchDic setObject:[[[responseObject objectForKey:@"queryList"] objectAtIndex:i] objectForKey:@"classa_no"] forKey:@"classno"];
            
            [listArray addObject:searchDic];
        }
       
        
        searchArray=[[NSArray alloc] initWithArray:listArray];
        
        //searchArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"queryList"]];
         if (searchArray.count>0)
         {
             [picker reloadAllComponents];
             
             if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {
                 
                 [self presentViewController:alertController animated:YES completion:nil];
                 
             }
             else
             {
                 [actionSheet showInView:[self.view  window]];//显示picker
             }
         }
         else
         {
             [self alertOnly:@"您当前暂无查询记录"];
         }
    }
    else if ([[responseObject objectForKey:@"errorcode"] intValue]==-4 && responseObject)
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
    else if ([[responseObject objectForKey:@"errorcode"] intValue]==-3 && responseObject)
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
    else if ([[responseObject objectForKey:@"errorcode"] intValue]==-200 && responseObject)
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
    }
   
}


-(void)cancelNo
{
    txt1.text=@"";
    txt2.text=@"";
    txt3.text=@"";
    txt4.text=@"";
    
    txt1.placeholder=@"如:沪A12345";
    txt2.placeholder=@"点击按钮获取城市";
    txt3.placeholder=@"";
    txt4.placeholder=@"";
    
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];
}

-(void)doneYes
{
    
    [actionSheet dismissWithClickedButtonIndex:1 animated:YES];
    
}

-(NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}

-(NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return searchArray.count;
    
}

-(NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [[searchArray objectAtIndex:row] objectForKey:@"hphm"];
}

-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    //NSLog(@"[searchArray objectAtIndex:row]::%@",[searchArray objectAtIndex:row]);
    
    dic=[[NSDictionary alloc] initWithDictionary:[searchArray objectAtIndex:row]];
    txt1.text=[[searchArray objectAtIndex:row] objectForKey:@"hphm"];
    txt2.text=[[searchArray objectAtIndex:row] objectForKey:@"name"];
    
    txt3.text=[[searchArray objectAtIndex:row] objectForKey:@"engineno"];
    if ([txt3.text isEqualToString:@""])
    {
        txt3.placeholder=@"可选";
    }
    txt4.text=[[searchArray objectAtIndex:row] objectForKey:@"classno"];
    if ([txt4.text isEqualToString:@""])
    {
        txt4.placeholder=@"可选";
    }
    
}




-(BOOL)textFieldShouldReturn:(UITextField *)textField
{
    [textField resignFirstResponder];
    
    return YES;
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        
       // chooseArray=[[NSMutableArray alloc]initWithArray:[document readDataFromDocument:@"City" IsArray:YES]];
       // chooseDicArray=[[NSMutableArray alloc] init];
        //NSLog(@"chooseArray::%@",chooseArray);
       // if (chooseArray.count>0)
        
        
        /*
        //搜索历史
        searchArray=[[NSArray alloc]initWithArray:[document readDataFromDocument:@"SearchList" IsArray:YES]];
        
        if (searchArray.count>0)
        {
            [picker reloadAllComponents];
           
            if ([[[UIDevice currentDevice] systemVersion] floatValue] >= 8.0) {

                [self presentViewController:alertController animated:YES completion:nil];
                
            }
            else
            {
                 [actionSheet showInView:[self.view  window]];//显示picker
            }
            

        }
        else
        {
            [self alertOnly:@"您当前暂无查询记录"];
        }
         */
        
        [ToolLen ShowWaitingView:YES];
        requestFlag=1;
        [[self JsonFactory]queryHistory:nil action:@"/api/weizhang/queryHistory"];
        
    }
    else if (sender.tag==2)
    {
       
        [[AppDelegate setGlobal].rootController showRightController:YES];
        
    }
    else if(sender.tag==3)
    {
        //NSLog(@"立即查询");
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            alertPt=0;
            [self alertNoValid];
        }
        else
        {
            [MobClick event:@"illegalButton"];//统计查违章按钮
            alertPt=1;
            requestFlag=2;
            if (txt1.text.length==7)
            {
                if (txt2.text.length>0)
                {
                    if ([txt3.placeholder isEqualToString:@"可选"])
                    {
                        if ([txt4.placeholder isEqualToString:@"可选"])
                        {
                            [ToolLen ShowWaitingView:YES];
                            [[self JsonFactory]query:[dic objectForKey:@"code"] hphm:txt1.text hpzl:@"02" engineno:txt3.text classno:txt4.text action:@"/api/weizhang/query"];
                        }
                        else
                        {
                            if (txt4.text.length>0)
                            {
                                //[ToolLen ShowWaitingView:YES];
                                
                                //查询违章接口//{"city":"SH","hphm":"沪A520F9","hpzl":"02","engineno":"093470251","classno":""}
                                ///api/weizhang/query
                                [ToolLen ShowWaitingView:YES];
                                [[self JsonFactory]query:[dic objectForKey:@"code"] hphm:txt1.text hpzl:@"02" engineno:txt3.text classno:txt4.text action:@"/api/weizhang/query"];
                                
                            }
                            else
                            {
                                [self alertOnly:@"请填写车驾号"];
                            }
                        }
                        
                    }
                    else
                    {
                        if (txt3.text.length>0)
                        {
                            if ([txt4.placeholder isEqualToString:@"可选"])
                            {
                                [ToolLen ShowWaitingView:YES];
                                [[self JsonFactory]query:[dic objectForKey:@"code"] hphm:txt1.text hpzl:@"02" engineno:txt3.text classno:txt4.text action:@"/api/weizhang/query"];
                            }
                            else
                            {
                                if (txt4.text.length>0)
                                {
                                    [ToolLen ShowWaitingView:YES];
                                    [[self JsonFactory]query:[dic objectForKey:@"code"] hphm:txt1.text hpzl:@"02" engineno:txt3.text classno:txt4.text action:@"/api/weizhang/query"];
                                }
                                else
                                {
                                    [self alertOnly:@"请填写车驾号"];
                                }
                            }
                        }
                        else
                        {
                            [self alertOnly:@"请填写发动机号"];
                        }
                    }
                }
                else
                {
                    [self alertOnly:@"未选择违章区域"];
                }
            }
            else
            {
                [self alertOnly:@"请检查车牌号输入是否有误"];
            }
        }
    }
    
    
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (alertPt==0)
    {
        if (buttonIndex==1)
        {
            //NSLog(@"登录");
            LoginAndResigerViewController *guide=[[LoginAndResigerViewController alloc] init];
            guide.hidesBottomBarWhenPushed=YES;
            [self.navigationController pushViewController:guide animated:YES];
        }
    }
}

@end
