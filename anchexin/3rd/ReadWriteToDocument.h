//
//  ReadWriteToDocument.h
//  Paader
//
//  Created by Pengfei Wang on 11-5-24.
//  Copyright 2011 YuanTu Network. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface ReadWriteToDocument : NSObject 
{
	NSString  *folderName;
}
@property(nonatomic,retain)NSString  *folderName;
/**
 *将下载的数据保存在Document目录下
 */
-(void)saveDataToDocument:(NSString *)fileName fileData:(id)data;
/**
 *从Document目录下读取数据,isArray是BOOL值,用来判断读取的数据类型是数组还是字典,数组为YES,字典为NO
 */
-(id)readDataFromDocument:(NSString *)fileName IsArray:(BOOL)isArrayOrDic;


/**
 *将下载的图片保存在Document目录下
 */
-(void)saveHeadImageToDocument:(NSString *)url ImageData:(NSData *)imageData;

//从Document目录下读取图片
-(UIImage *)readImageFromDocument:(NSString *)url;

//删除目录下的所有文件
//-(void)deleteFileFromDocument;

//删除目录下的所有文件
-(void)deleteFileFromDocument:(NSString *)fileName;

@end
