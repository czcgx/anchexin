//
//  CityViewController.m
//  anchexin
//
//  Created by cgx on 14-8-26.
//
//

#import "CityViewController.h"

@interface CityViewController ()

@end

@implementation CityViewController

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
    self.view.backgroundColor=kUIColorFromRGB(0x1c1c1c);
    UIView *mainView=[[UIView alloc] initWithFrame:CGRectMake(0, 60, WIDTH, 480+(iPhone5?88:0)-60)];
    mainView.backgroundColor=[UIColor clearColor];
    
    requestLabel=[self customLabel:CGRectMake(100, mainView.frame.size.height/2-50, 220, 20) color:[UIColor whiteColor] text:@"正在加载中..." alignment:0 font:15.0];
    [mainView addSubview:requestLabel];
    
    dataSource=[[NSMutableArray alloc]init];
    sections=[[NSMutableArray alloc]init];
    rows=[[NSMutableArray alloc]init];
    
    cityTableView=[[UITableView alloc]initWithFrame:CGRectMake(0,0, WIDTH, mainView.frame.size.height)];
    cityTableView.sectionIndexColor=[UIColor whiteColor];
    if ([[UIDevice currentDevice].systemVersion floatValue] >= 7.0)
    {
        cityTableView.sectionIndexBackgroundColor=[UIColor clearColor];
        cityTableView.sectionIndexTrackingBackgroundColor = [UIColor clearColor];
    }
    
    
    /*
    //--快速索引
    //改变索引的颜色
    cityTableView.sectionIndexColor = [UIColor clearColor];
    //改变索引选中的背景颜色
    */
    cityTableView.delegate=self;
    cityTableView.dataSource=self;
    cityTableView.backgroundView=nil;
    cityTableView.backgroundColor=[UIColor clearColor];
    cityTableView.separatorStyle=UITableViewCellSeparatorStyleNone;
    
    [mainView addSubview:cityTableView];
    [self.view addSubview:mainView];
    
    
    chooseArray=[[NSMutableArray alloc]initWithArray:[document readDataFromDocument:@"City" IsArray:YES]];
    chooseDicArray=[[NSMutableArray alloc] init];
   //NSLog(@"chooseArray::%@",chooseArray);
    if (chooseArray.count>0)
    {
        //获得第一个字典中的第一个字符串
        NSString *temp=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[chooseArray objectAtIndex:0] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
        
        [sections addObject:temp];
        [dataSource addObject:temp];
        
        NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        NSMutableArray *tempDicArray=[[NSMutableArray alloc] init];
      //[tempDicArray addObject:[chooseArray objectAtIndex:0]];
        for (int i=0; i<[chooseArray count]; i++)
        {
            NSString *temp_=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[chooseArray objectAtIndex:i] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
            
            if ([temp isEqualToString:temp_])
            {
                [tempArray addObject:[[chooseArray objectAtIndex:i] objectForKey:@"name"]];
                [tempDicArray addObject:[chooseArray objectAtIndex:i]];
            }
            else
            {
                [rows addObject:tempArray];
                [chooseDicArray addObject:tempDicArray];
                
                tempArray=[[NSMutableArray alloc] init];
                [tempArray addObject:[[chooseArray objectAtIndex:i] objectForKey:@"name"]];
                
                
                tempDicArray=[[NSMutableArray alloc] init];
                [tempDicArray addObject:[chooseArray objectAtIndex:i]];
                
                temp=temp_;
               
                [sections addObject:temp];
                [dataSource addObject:temp];
                
            }
            if (i==[chooseArray count]-1)
            {
                [rows addObject:tempArray];
                [chooseDicArray addObject:tempDicArray];
            }
        }
        
        //NSLog(@"chooseDicArray::%@",chooseDicArray);
        requestLabel.hidden=YES;
        [cityTableView reloadData];

    }
    else
    {
        [[self JsonFactory]getCityList:@"" action:@"api/weizhang/getCityList"];
    }
    
}

-(void)JSONSuccess:(id)responseObject
{
    if (responseObject && [[responseObject objectForKey:@"errorcode"] intValue]==0)
    {
        NSMutableArray *tmpArray=[[NSMutableArray alloc]initWithArray:[responseObject objectForKey:@"cityList"]];
   
        NSArray *codeArray=[NSArray arrayWithObjects:@"A",@"B",@"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z", nil];
        
        chooseArray=[[NSMutableArray alloc] init];//排序完之后的城市数组
        for (int i=0; i<[codeArray count]; i++)
        {
            //NSLog(@"=======================:%lu======================",(unsigned long)[tmpArray count]);
            
            for (int j=0; j<[tmpArray count]; j++)
            {
                NSString *temp_=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[tmpArray objectAtIndex:j] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
                
                //NSLog(@"TEMP::%@",temp_);
                if ([[codeArray objectAtIndex:i] isEqualToString:temp_])
                {
                    [chooseArray addObject:[tmpArray objectAtIndex:j]];
                    [tmpArray removeObject:[tmpArray objectAtIndex:j]];
                }
            }
        }
        
        //将排序过的数组保存city
        [document saveDataToDocument:@"City" fileData:chooseArray];
        
        //获得第一个字典中的第一个字符串
        NSString *temp=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[chooseArray objectAtIndex:0] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
        
        [sections addObject:temp];
        [dataSource addObject:temp];
        
        NSMutableArray *tempArray=[[NSMutableArray alloc] init];
        NSMutableArray *tempDicArray=[[NSMutableArray alloc] init];
        //[tempDicArray addObject:[chooseArray objectAtIndex:0]];
        for (int i=0; i<[chooseArray count]; i++)
        {
            NSString *temp_=[[NSString stringWithFormat:@"%@",[ChineseToPinyin pinyinFromChiniseString:[[chooseArray objectAtIndex:i] objectForKey:@"name"]]] substringWithRange:NSMakeRange(0, 1)];
            
            if ([temp isEqualToString:temp_])
            {
                [tempArray addObject:[[chooseArray objectAtIndex:i] objectForKey:@"name"]];
                [tempDicArray addObject:[chooseArray objectAtIndex:i]];
            }
            else
            {
                [rows addObject:tempArray];
                [chooseDicArray addObject:tempDicArray];
                
                tempArray=[[NSMutableArray alloc] init];
                [tempArray addObject:[[chooseArray objectAtIndex:i] objectForKey:@"name"]];
                
                
                tempDicArray=[[NSMutableArray alloc] init];
                [tempDicArray addObject:[chooseArray objectAtIndex:i]];
                
                temp=temp_;
                
                [sections addObject:temp];
                [dataSource addObject:temp];
                
            }
            if (i==[chooseArray count]-1)
            {
                [rows addObject:tempArray];
                [chooseDicArray addObject:tempDicArray];
            }
        }
        
        //NSLog(@"chooseDicArray::%@",chooseDicArray);
        requestLabel.hidden=YES;
        [cityTableView reloadData];
    }
    
    //NSLog(@"%@",[responseObject objectForKey:@"message"]);

}

//返回索引数组
-(NSArray *)sectionIndexTitlesForTableView:(UITableView *)tableView
{
    return dataSource;
}

//响应点击索引时的委托方法
-(NSInteger)tableView:(UITableView *)tableView sectionForSectionIndexTitle:(NSString *)title atIndex:(NSInteger)index
{
    NSInteger count = 0;
    // NSLog(@"%@-%d",title,index);
    
    for(NSString *character in dataSource)
    {
        if([character isEqualToString:title])
        {
            return count;
        }
        count ++;
    }
    return 0;
}



-(NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return [sections count];
}

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [rows[section] count];
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 50;
    
}

-(CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 30.0;
}

-(UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section
{
    UIView *bgView=[[UIView alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 30)];
    bgView.backgroundColor=kUIColorFromRGB(0x1c1c1c);
    
    UILabel *upLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 0, WIDTH, 0.5)];
    upLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:upLabel];
    
    UILabel *sectionLabel=[[UILabel alloc] initWithFrame:CGRectMake(100, 5, 30, 20)];
    sectionLabel.backgroundColor=[UIColor clearColor];
    sectionLabel.textAlignment=NSTextAlignmentLeft;
    sectionLabel.textColor=[UIColor whiteColor];
    sectionLabel.font=[UIFont boldSystemFontOfSize:19.0];
    sectionLabel.text=sections[section];
    [bgView addSubview:sectionLabel];
    
    UILabel *downLabel=[[UILabel alloc] initWithFrame:CGRectMake(0, 29.5, WIDTH, 0.5)];
    downLabel.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [bgView addSubview:downLabel];
    
    return bgView;
    
    
}


-(NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return sections[section];
}



-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellIndefiner=@"cellIndefiner";
    
    CityCell *cell=(CityCell *)[tableView dequeueReusableCellWithIdentifier:cellIndefiner];
    
    if (cell==nil)
    {
        NSArray *xib=[[NSBundle mainBundle]loadNibNamed:@"CityCell" owner:self options:nil];
        cell=[xib objectAtIndex:0];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
    }
    
    UILabel *labelbg=[[UILabel alloc] initWithFrame:CGRectMake(0, 49.5, WIDTH-2, 0.5)];
    labelbg.backgroundColor=kUIColorFromRGB(0x3a3a3a);
    [cell.contentView addSubview:labelbg];
    
    
    cell.cityNameLabel.text=rows[indexPath.section][indexPath.row];
    
    
    return cell;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    [[NSNotificationCenter defaultCenter] postNotificationName:@"refreshCity" object:chooseDicArray[indexPath.section][indexPath.row]];
    
    [[AppDelegate setGlobal].rootController showRootController:YES];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
