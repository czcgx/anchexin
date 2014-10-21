//
//  CarManageViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "CarManageViewController.h"

@interface CarManageViewController ()

@end

@implementation CarManageViewController

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
    
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=kUIColorFromRGB(Commonbg);
    
    manageTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, mainView.frame.size.height-50)];
    manageTableView.delegate=self;
    manageTableView.dataSource=self;
    manageTableView.backgroundView=nil;
    manageTableView.backgroundColor=[UIColor clearColor];
    manageTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    [mainView addSubview:manageTableView];
    
    //添加车辆
    UIView *orderView=[[UIView alloc] initWithFrame:CGRectMake(0,mainView.frame.size.height-50, WIDTH, 50)];
    orderView.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    [orderView addSubview:[self customView:CGRectMake(60, 5, 200, 40) labelTitle:@"添加车辆" buttonTag:1]];
    [mainView addSubview:orderView];
    
    
    [self.view addSubview:mainView];
    
    [ToolLen ShowWaitingView:YES];
    requestTimes=1;
    [[self JsonFactory] getCarList:@"getCarList"];
    
}

-(void)customEvent:(UIButton *)sender
{
    if (sender.tag==1)
    {
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            //选择车辆
            CarTypeViewController *type=[[CarTypeViewController alloc] init];
            type.state=1;
            [self.navigationController pushViewController:type animated:YES];
        }
       
    }
}

-(void)JSONSuccess:(id)responseObject
{
    [ToolLen ShowWaitingView:NO];
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==1)
    {
        //NSLog(@"sssdddd");
        
        manageArray=[[NSArray alloc] initWithArray:[responseObject objectForKey:@"carlist"]];
        
       // NSLog(@"manageArray::%@",manageArray);
        
        [manageTableView reloadData];
    }
    else if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0 && requestTimes==2)
    {
        NSMutableArray *temp=[[NSMutableArray alloc] initWithArray:manageArray];
        
        NSMutableDictionary *tempDic=[[NSMutableDictionary alloc]initWithDictionary:[temp objectAtIndex:index] ];
        [tempDic removeObjectForKey:@"licenseNumber"];
        [tempDic setObject:currentNumber forKey:@"licenseNumber"];
        //NSLog(@"temp:%@",tempDic);
        
        [temp removeObjectAtIndex:index];
        [temp insertObject:tempDic atIndex:index];
        
        manageArray=[[NSArray alloc] initWithArray:temp];
       // NSLog(@"manageArray::%@",manageArray);
        [manageTableView reloadData];
        
    }
    else
    {
        [self alertOnly:[responseObject objectForKey:@"message"]];
        
    }
}

-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    
    return [manageArray count];
    
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 80.0;
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner1";
    ManageCell *cell=(ManageCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"ManageCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    if (indexPath.row % 2)
    {
        cell.backgroundColor=[UIColor colorWithRed:224.0/255.0 green:224.0/255.0 blue:224.0/255.0 alpha:1.0];
    }
    else
    {
        cell.backgroundColor=[UIColor colorWithRed:241.0/255.0 green:241.0/255.0 blue:241.0/255.0 alpha:1.0];
    }
    
    cell.carNameLabel1.text=[NSString stringWithFormat:@"%@ %@",[[manageArray objectAtIndex:indexPath.row] objectForKey:@"carbrand"],[[manageArray objectAtIndex:indexPath.row] objectForKey:@"carseries"]];
    cell.carNameLabel2.text=[[manageArray objectAtIndex:indexPath.row] objectForKey:@"carname"];
    
    [cell.contentView addSubview:[self drawLine:CGRectMake(0, 50, WIDTH, 0.5) drawColor:[UIColor lightGrayColor]]];
    
    cell.carNumberLabel.text=[[manageArray objectAtIndex:indexPath.row] objectForKey:@"licenseNumber"];
    [cell.contentView addSubview:[self drawLine:CGRectMake(160, 50, 0.5, 30) drawColor:[UIColor lightGrayColor]]];
    
    cell.carSnLabel.text=[[manageArray objectAtIndex:indexPath.row] objectForKey:@"sn"];
    
    cell.editButton.tag=indexPath.row;
    [cell.editButton addTarget:self action:@selector(editNumber:) forControlEvents:UIControlEventTouchUpInside];
    
    return cell;
    
    
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    [AppDelegate setGlobal].changCarId=[[manageArray objectAtIndex:indexPath.row] objectForKey:@"carid"];//更换车的id
    
    //刷新切换车辆
    [[NSNotificationCenter defaultCenter] postNotificationName:@"changeCar" object:nil];
    
     [[AppDelegate setGlobal].rootController setRootController:[AppDelegate setGlobal].tabBarController animated:YES];
    
}


-(void)editNumber:(UIButton *)sender
{
    if ([[userDic objectForKey:@"valid"] intValue]==0)
    {
        [self alertNoValid];
    }
    else
    {
        index=(int)sender.tag;
        
        UIAlertView *alert=[[UIAlertView alloc] initWithTitle:nil
                                                      message:@"请输入新的车牌号"
                                                     delegate:self
                                            cancelButtonTitle:@"取消"
                                            otherButtonTitles:@"确定", nil];
        
        [alert setAlertViewStyle:UIAlertViewStylePlainTextInput];
        [alert show];
    }
    
}

-(void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex==1)
    {
        //得到输入框
        UITextField *tf=[alertView textFieldAtIndex:0];
        //NSLog(@"tf::%@",tf.text);
        currentNumber=tf.text;
        if (tf.text.length>0)
        {
            requestTimes=2;
            
            [[self JsonFactory] setLicenseNumberByCar:[[[manageArray objectAtIndex:index] objectForKey:@"carid"] stringValue] licenseNumber:tf.text action:@"setLicenseNumberByCar"];
        }

    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
