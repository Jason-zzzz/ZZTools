//
//  ZZTools.h
//  YufeiCamera
//
//  Created by huaxia on 2018/1/18.
//  Copyright © 2018年 Ömer Faruk Gül. All rights reserved.
//

#define NAV_HEIGHT 64
//获取屏幕 宽度、高度
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)

/***** 必须引入的类 *****/
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import "TimeTool.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "ZZObject.h"
#import "PHAsset+Sneaky.h"
#import <sys/utsname.h>
#import "UIImage+Corner.h"
#import "NSBundle+privateBundle.h"
#import "UIImage+PrivateBundleImage.h"
#import "UIViewController+PrivateNavigationBar.h" // 自定义navigation
/**********************/

@interface ZZTools : NSObject

// 移动相册图片
+ (void)moveImage:(PHAsset *)imageAsset toAlbum:(NSString *)albumName complete:(void(^)(void))complete;

// PHAsset转ALAsset 需要 PHAsset+Sneakey.h
+ (void)PHAssettoALAsset:(PHAsset *)phAsset complete:(void(^)(ALAsset *))complete;


+ (ZZObject *)object;

+ (NSString *)getYFFileNameWithType:(NSString *)type;
// 手机型号
+ (NSString*)iphoneType;
// 时间
+ (NSString *)nowTimeYYYY_MM_DD;
+ (int)nowTimeStampFrom1970;
+ (NSString *)nowTimeYYYYMMddHHmmss;
+ (NSString*)getStringFromStamp:(int)stamp withFormat:(NSString*)format;

// 获取当前controller
+ (UIViewController *)getCurrentVC;

// 第一次启动
+ (BOOL)firstLuanch;
+ (BOOL)firstLuanch2p1; // 2.1版本第一次启动

// 上传图片
+ (void)uploadImage:(UIImage *)image;
// 下载pdf
+ (void)downloadPDF;

// 出现动画
+ (void)viewAppear:(UIView*)view animation:(void (^)(void))animation complete:(void (^)(void))complete;
// 消失动画
+ (void)viewDisappear:(UIView*)view animation:(void (^)(void))animation complete:(void (^)(void))complete;
/**
 * 文字下划线
 * 默认参数 0 - string.length
 */
+ (NSAttributedString *)sublineString:(NSString *)string range:(NSRange)range;

// 截图
+ (UIImage *)getSnapshotImage:(CALayer *)layer;

// 放大缩小屏幕
+ (void)viewScaleChnageValue:(UIView *)view scale:(CGFloat)scale;

// 修正图片角度
+ (UIImage*)fixOrientation:(UIImage *)valueToSend;

// 设置圆角
+ (void)setCornerRadius:(UIView *)view width:(CGFloat)width;

// 设置阴影和阴影圆角
+ (void)setShadow:(UIView *)view width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius;

// 计算pixel per mm
+ (float)caculatePixelLength;

// set转point，(触摸点坐标)
+ (CGPoint)setToPoint:(NSSet *)set;

// 文件及路径
+ (NSString *)documentPathString;
+ (NSDictionary *)createFileAt:(NSString *)path;
+ (NSDictionary *)createDirAt:(NSString *)path;
+ (NSDictionary *)deleteFileAt:(NSString *)path;
+ (void)writefile:(NSString *)path string:(NSString *)string;

+ (BOOL)copyFile:(NSString *)path to:(NSString *)string;
+ (void)saveKey:(NSString *)key value:(NSString *)value;
+ (NSString *)getKey:(NSString *)key;
+ (BOOL)checkEmail:(NSString*)email;
+ (BOOL)checkPhoneNumber:(NSString *)number;
+ (NSData *)imageToData:(UIImage *)image ratio:(CGFloat)ratio;

@end
