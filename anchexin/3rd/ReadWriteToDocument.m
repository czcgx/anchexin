//
//  ReadWriteToDocument.m
//  Paader
//
//  Created by Pengfei Wang on 11-5-24.
//  Copyright 2011 YuanTu Network. All rights reserved.
//
#import "ReadWriteToDocument.h"

@interface ReadWriteToDocument ()
//从url中得到图片名称
-(NSString *)getImageNameFromUrl:(NSString *)url;
//取得Document下 sinaWeibo/headImage 文件夹的路径
-(NSString *)getFolderPath;

@end


@implementation ReadWriteToDocument

@synthesize folderName;

//取得Document下 sinaWeibo/headImage 文件夹的路径
-(NSString *)getFolderPath
{
	NSArray *documentPath = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString *path = [documentPath objectAtIndex:0];
	NSString *folderPath =[path stringByAppendingPathComponent:self.folderName];
	return folderPath;
}

#pragma mark -
#pragma mark -  DataSource

//将下载的数据保存在Document目录下
-(void)saveDataToDocument:(NSString *)fileName fileData:(id)data
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString * folderPath = [self getFolderPath];
	if(![fileManager fileExistsAtPath:folderPath])//如果路径不存在
    {
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];//创建路径
	}
	NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    
    //NSLog(@"123456789::%@",filePath);
    
	[data writeToFile:filePath atomically:YES];//保存数据
}

//从Document目录下读取数据
-(id)readDataFromDocument:(NSString *)fileName IsArray:(BOOL)isArrayOrDic
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *folderPath = [self getFolderPath];
	NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
	if(![fileManager fileExistsAtPath:filePath])//如果路径不存在
    {
		return nil;
	}
    
	if (isArrayOrDic) //yes代表array,no代表dictionary
    {
		NSArray *dataArray = [NSArray arrayWithContentsOfFile:filePath];
		return dataArray;
	}
	else 
    {
		NSDictionary *dataDic = [NSDictionary dictionaryWithContentsOfFile:filePath];
		return dataDic;
	}
}
#pragma mark ----------------------
#pragma mark 保存，读取图片
//将下载的图片保存在Document目录下
-(void)saveHeadImageToDocument:(NSString *)url ImageData:(NSData *)imageData
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString * folderPath = [self getFolderPath];
	if(![fileManager fileExistsAtPath:folderPath])
    {
		[fileManager createDirectoryAtPath:folderPath withIntermediateDirectories:YES attributes:nil error:nil];
	}
	NSString *imageName = [self getImageNameFromUrl:url];
	NSString *imagePath = [folderPath stringByAppendingPathComponent:imageName];
	[imageData writeToFile:imagePath atomically:YES];
//	NSLog(@"imagePath=%@",imagePath);
	
}
//从url中得到图片名称
-(NSString *)getImageNameFromUrl:(NSString *)url
{
	NSString * imageURL;
	//有的图片url没有后缀，需要加上后缀
	NSArray *lastPatharray = [[url lastPathComponent] componentsSeparatedByString:@"."];
	if (lastPatharray.count == 1) 
    {
		imageURL = [NSString stringWithFormat:@"%@.jpg",url];
	}
	else {
		imageURL = url;
	}
	NSArray *array = [imageURL componentsSeparatedByString:@"//"];
	NSString *imageName = [[array objectAtIndex:1]
						   stringByReplacingOccurrencesOfString:@"/" withString:@"_"];
	return imageName;
}
//从Document目录下读取图片
-(UIImage *)readImageFromDocument:(NSString *)url
{
	NSFileManager *fileManager = [NSFileManager defaultManager];
	NSString *folderPath = [self getFolderPath];
	NSString *imageName = [self getImageNameFromUrl:url];
	NSString *imagePath = [folderPath stringByAppendingPathComponent:imageName];
	if(![fileManager fileExistsAtPath:folderPath]||![fileManager fileExistsAtPath:imagePath]){
		return nil;
	}
	UIImage *image =  [UIImage imageWithContentsOfFile:imagePath];
	return image;
}

//删除目录下的所有文件
-(void)deleteFileFromDocument:(NSString *)fileName
{
	NSString *folderPath = [self getFolderPath];
    NSString *filePath = [folderPath stringByAppendingPathComponent:fileName];
    //NSLog(@"filePath::%@",filePath);
	NSFileManager *fileManager = [NSFileManager defaultManager];
	[fileManager removeItemAtPath:filePath error:nil];//删除路径文件
}

@end
