//
//  AccountViewController.m
//  anchexin
//
//  Created by cgx on 14-8-22.
//
//

#import "AccountViewController.h"

@interface AccountViewController ()

@end

@implementation AccountViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void)refresh
{
    userDic=[document readDataFromDocument:@"user" IsArray:NO];
    
    [accountTableView reloadData];
    
}
- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    [self skinOfBackground];
    self.navigationItem.leftBarButtonItem=[self LeftBarButton];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(refresh) name:@"refresh" object:nil];
    
    //背景视图
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, NavigationBar, WIDTH, 480+(iPhone5?88:0)-NavigationBar)];
    mainView.backgroundColor=[UIColor clearColor];
    //头部视图
    UIView *headView=[[UIView alloc] initWithFrame:CGRectMake(15, 50-20, 70, 70)];
    headView.backgroundColor=[UIColor whiteColor];
    headView.layer.cornerRadius = 35;//(值越大，角就越圆)
    headView.layer.masksToBounds = YES;
    headView.layer.borderWidth=2.0;
    headView.layer.borderColor=[[UIColor lightGrayColor] CGColor];
    [mainView addSubview:headView];
    
    UIImageView *img=[self customImageView:CGRectMake(25, 60-20, 50, 50) image:nil];
    [img setImageWithURL:[NSURL URLWithString:[[carArray objectAtIndex:0] objectForKey:@"iconimg"]] placeholderImage:nil];
    [mainView addSubview:img];//车的图标
    
    UILabel *lb1=[self customLabel:CGRectMake(90, 70-20, 200, 20) color:[UIColor whiteColor] text:[NSString stringWithFormat:@"%@  %@",[[carArray objectAtIndex:0] objectForKey:@"carseries"],[[carArray objectAtIndex:0] objectForKey:@"license_number"] ]  alignment:-1 font:16];
    lb1.shadowColor=[UIColor blackColor];
    lb1.shadowOffset=CGSizeMake(0, 1.5);
    [mainView addSubview:lb1];
    
  
    UILabel *lb2=[self customLabel:CGRectMake(90, 90-20, 200, 20) color:[UIColor whiteColor] text:[NSString stringWithFormat:@"里程:%@公里",[[carArray objectAtIndex:0] objectForKey:@"current_mileage"]]  alignment:-1 font:14];
    lb2.shadowColor=[UIColor blackColor];
    lb2.shadowOffset=CGSizeMake(0, 1.5);
    [mainView addSubview:lb2];
    
    /*
    [mainView addSubview:[self customImageView:CGRectMake(275, 70-20, 30, 30) image:IMAGE(@"edit")]];
    [mainView addSubview:[self customButton:CGRectMake(270, 70-20-10, 50, 50) tag:1 title:nil state:0 image:nil selectImage:nil color:nil enable:YES]];
    */
    
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 120, WIDTH, mainView.frame.size.height-120)];
    bgView.backgroundColor=kUIColorFromRGB(Commonbg);
    [bgView addSubview:[self drawLine:CGRectMake(0, 0, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    accountArray=[[NSArray alloc] initWithObjects:@"电子邮箱",@"绑定手机",@"用户名",@"个性签名", nil];
    
    accountTableView=[[UITableView alloc]initWithFrame:CGRectMake(0, 0, WIDTH, 200)];
    accountTableView.delegate=self;
    accountTableView.dataSource=self;
    accountTableView.backgroundView=nil;
    accountTableView.backgroundColor=[UIColor clearColor];
    accountTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    accountTableView.scrollEnabled=NO;
    [bgView addSubview:accountTableView];
    
    [bgView addSubview:[self drawLine:CGRectMake(0, 199, WIDTH, 1) drawColor:kUIColorFromRGB(CommonLinebg)]];
    
    [mainView addSubview:bgView];
    [self.view addSubview:mainView];
    
}


-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [accountArray count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}


-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    AccountCell *cell=(AccountCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"AccountCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    cell.nameLabel.text=[accountArray objectAtIndex:indexPath.row];
    
    UILabel *showLineLabel=[[UILabel alloc] initWithFrame:CGRectMake(15, 49.5, WIDTH-30, 0.5)];
    showLineLabel.backgroundColor=kUIColorFromRGB(CommonLinebg);
    [cell.contentView addSubview:showLineLabel];
    
    if (indexPath.row==0)
    {
        cell.valueLabel.text=[userDic objectForKey:@"mail"];
    }
    else if (indexPath.row==1)
    {
        cell.valueLabel.text=[userDic objectForKey:@"mobile"];
    }
    else if (indexPath.row==2)
    {
        cell.valueLabel.text=[userDic objectForKey:@"username"];
    }
    else
    {
        cell.valueLabel.text=@"";
    }
    
    if (indexPath.row==1)
    {
        cell.iconImageView.hidden=NO;
    }
    else
    {
        cell.iconImageView.hidden=YES;
    }
    
    if (indexPath.row==3)
    {
        showLineLabel.hidden=YES;
    }
    else
    {
        showLineLabel.hidden=NO;
    }
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row==1)
    {
        if ([[userDic objectForKey:@"valid"] intValue]==0)
        {
            [self alertNoValid];
        }
        else
        {
            //修改手机号
            ModifyPwdViewController *modify=[[ModifyPwdViewController alloc] init];
            modify.title=@"修改手机号";
            modify.tag=1;
            [self.navigationController pushViewController:modify animated:YES];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
