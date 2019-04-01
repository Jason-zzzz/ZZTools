//
//  ZZTools.m
//  YufeiCamera
//
//  Created by huaxia on 2018/1/18.
//  Copyright © 2018年 Ömer Faruk Gül. All rights reserved.
//

#import "ZZTools.h"

@implementation ZZTools

+ (void)moveImage:(PHAsset *)imageAsset toAlbum:(NSString *)albumName complete:(void(^)(void))complete {
    ALAssetsLibraryGroupsEnumerationResultsBlock enumerationBlock;
    enumerationBlock = ^(ALAssetsGroup *group, BOOL *stop) {
        if ([albumName compare:[group valueForProperty:ALAssetsGroupPropertyName]] == NSOrderedSame) {
            // target album is found
            [[ZZTools object].alal assetForURL:imageAsset.ALAssetURL resultBlock:^(ALAsset *asset) {
                [group addAsset:asset];
                if (complete) {
                    complete();
                }
            } failureBlock:nil];
//            [group addAsset:imageAsset];
            return;
        }
    };
    // search all photo albums in the library
    [[ZZTools object].alal enumerateGroupsWithTypes:ALAssetsGroupAlbum usingBlock:enumerationBlock failureBlock:nil];
}

+ (void)PHAssettoALAsset:(PHAsset *)phAsset complete:(void(^)(ALAsset *))complete {
    __block ALAsset * alAsset;
    [[ZZTools object].alal assetForURL:phAsset.ALAssetURL resultBlock:^(ALAsset *asset) {
        alAsset = asset;
        if (complete) {
            complete(asset);
        }
    } failureBlock:nil];
}

+ (void)viewAppear:(UIView*)view animation:(void (^)(void))animation complete:(void (^)(void))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        view.transform = CGAffineTransformScale(view.transform, 1.1, 1.1);
        NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
        [UIView animateWithDuration:0.12 delay:0 options:options animations:^{
            view.transform = CGAffineTransformScale(view.transform, 1/1.1, 1/1.1);
            view.hidden = NO;
            if (animation) {
                animation();
            }
        } completion:^(BOOL finished) {
            if (complete) {
                complete();
            }
        }];
    });
}

+ (void)viewDisappear:(UIView*)view animation:(void (^)(void))animation complete:(void (^)(void))complete {
    dispatch_async(dispatch_get_main_queue(), ^{
        NSUInteger options = UIViewAnimationOptionAllowUserInteraction | UIViewAnimationCurveEaseOut;
        [UIView animateWithDuration:0.12 delay:0 options:options animations:^{
            view.transform = CGAffineTransformScale(view.transform, 1/0.8, 1/0.8); 
            if (animation) {
                animation();
            }
        } completion:^(BOOL finished) { 
            view.transform = CGAffineTransformScale(view.transform, 0.8, 0.8);
            if (complete) {
                complete();
            }
        }];
    });
}

+ (BOOL)firstLuanch:(NSString *)version {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"version"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"version"];
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)firstLuanch {
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLaunch"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLaunch"];
        return YES;
    }else{
        return NO;
    }
}

+ (BOOL)firstLuanch2p1 {
    // 2.1版本第一次启动
    if(![[NSUserDefaults standardUserDefaults] boolForKey:@"firstLuanch2p1"]){
        [[NSUserDefaults standardUserDefaults] setBool:YES forKey:@"firstLuanch2p1"];
        return YES;
    }else{
        return NO;
    }
}

+ (float)caculatePixelLength {
    CGFloat sc_w = [[UIScreen mainScreen] bounds].size.width;
    CGFloat sc_h = [[UIScreen mainScreen] bounds].size.height;
    CGFloat sc_s;
    CGFloat ff = [[UIScreen mainScreen] nativeBounds].size.height;
    
    if (ff == 1136) {
        sc_s = 4.0;
    }else if(ff == 1334.0){
        sc_s = 4.7;
    }else if (ff== 1920){
        sc_s = 5.5;
    }else if (ff== 2436){
        sc_s = 5.8;
    }else{
        sc_s = 3.5;
    }
    
    //1mm米的像素点
    float pmm = sqrt(sc_w * sc_w + sc_h * sc_h)/(sc_s * 25.4);//mm
    return pmm;
}

+ (UIImage*)fixOrientation:(UIImage *)valueToSend {
    NSData * data;
    UIImage* tmpImage = (UIImage*)valueToSend;
    UIImage* contextedImage;
    CGAffineTransform transform = CGAffineTransformIdentity;
    if (tmpImage.imageOrientation == UIImageOrientationUp) {
        contextedImage = tmpImage;
    }
    else{
        switch (tmpImage.imageOrientation ) {
            case UIImageOrientationUp:
            case UIImageOrientationUpMirrored:
                transform = CGAffineTransformTranslate(transform, 0,tmpImage.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            case UIImageOrientationDown:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, tmpImage.size.width, tmpImage.size.height);
                transform = CGAffineTransformRotate(transform, M_PI);
                break;
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
                transform = CGAffineTransformTranslate(transform, tmpImage.size.width, 0);
                transform = CGAffineTransformRotate(transform, M_PI_2);
                break;
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, 0,tmpImage.size.height);
                transform = CGAffineTransformRotate(transform, -M_PI_2);
                break;
            default:
                break;
        }
        switch (tmpImage.imageOrientation) {
            case UIImageOrientationUpMirrored:
            case UIImageOrientationDownMirrored:
                transform = CGAffineTransformTranslate(transform, tmpImage.size.width, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRightMirrored:
                transform = CGAffineTransformTranslate(transform, tmpImage.size.height, 0);
                transform = CGAffineTransformScale(transform, -1, 1);
                break;
            default:
                break;
        }
        CGContextRef ctx = CGBitmapContextCreate(NULL, tmpImage.size.width, tmpImage.size.height, CGImageGetBitsPerComponent(tmpImage.CGImage), 0, CGImageGetColorSpace(tmpImage.CGImage), CGImageGetBitmapInfo(tmpImage.CGImage));
        CGContextConcatCTM(ctx, transform);
        switch (tmpImage.imageOrientation) {
            case UIImageOrientationLeft:
            case UIImageOrientationLeftMirrored:
            case UIImageOrientationRight:
            case UIImageOrientationRightMirrored:
                CGContextDrawImage(ctx, CGRectMake(0, 0, tmpImage.size.height,tmpImage.size.width), tmpImage.CGImage);
                break;
            default:
                CGContextDrawImage(ctx, CGRectMake(0, 0, tmpImage.size.width, tmpImage.size.height), tmpImage.CGImage);
                break;
        }
        CGImageRef cgimg = CGBitmapContextCreateImage(ctx);
        contextedImage = [UIImage imageWithCGImage:cgimg];
        CGContextRelease(ctx);
        CGImageRelease(cgimg);
    }
    data = UIImageJPEGRepresentation(contextedImage, 1);
    return [UIImage imageWithData:data];
}

+ (NSString*)getStringFromStamp:(int)stamp withFormat:(NSString*)format
{
    NSDate *date = [NSDate dateWithTimeIntervalSince1970:stamp];
    NSDateFormatter * formater = [[NSDateFormatter alloc] init ];
    [formater setTimeZone: [NSTimeZone systemTimeZone] ];
    formater.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"CN"];
    [formater setDateFormat:format];
    return  [formater stringFromDate: date];
}

+ (NSString *)nowTimeYYYY_MM_DD {
    // 初始化日期时间
    NSString * nowTime = [TimeTool getStringFromStamp:[ZZTools nowTimeStampFrom1970] withFormat:@"YYYY-MM-DD"];
    return nowTime;
}

+ (NSString *)nowTimeYYYYMMddHHmmss {
    // 初始化日期时间
    NSString * nowTime = [TimeTool getStringFromStamp:[ZZTools nowTimeStampFrom1970] withFormat:@"YYYYMMddHHmmss"];
    return nowTime;
}

+ (int)nowTimeStampFrom1970 {
    return [[NSDate date] timeIntervalSince1970];
}

+ (NSString *)documentPathString {
    return [NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) objectAtIndex:0];
}

+ (NSDictionary *)createFileAt:(NSString *)path {
    BOOL isDir = false;
    BOOL success = false;
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        success = [[NSFileManager defaultManager] createFileAtPath:path contents:[@" " dataUsingEncoding:NSUTF8StringEncoding] attributes:nil];
    }
    return [NSDictionary dictionaryWithObjectsAndKeys:@(isDir), @"isDir", @(success), @"success", nil];
}

+ (NSAttributedString *)sublineString:(NSString *)string range:(NSRange)range {
    if (nil == string) {
        return nil;
    }
    NSRange defaultRange = NSMakeRange(0, string.length);
    if (0 == range.length) {
        range = defaultRange;
    }
    NSMutableAttributedString *defeatInfo = [[NSMutableAttributedString alloc]initWithString:string];
    [defeatInfo addAttribute:NSUnderlineStyleAttributeName value:@(NSUnderlineStyleSingle) range:range];
    [defeatInfo addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithWhite:0 alpha:1] range:range];
    return defeatInfo;
}

+ (void)setShadow:(UIView *)view width:(CGFloat)width cornerRadius:(CGFloat)cornerRadius {
    
    view.layer.shadowColor = [UIColor blackColor].CGColor;//设置阴影的颜色
    view.layer.shadowOpacity = 0.1;//设置阴影的透明度
    view.layer.shadowOffset = CGSizeMake(0.5, 0.5);//设置阴影的偏移量
    view.layer.shadowRadius = width;//设置阴影的宽度
    UIBezierPath *path = [UIBezierPath bezierPathWithRoundedRect:view.bounds cornerRadius:cornerRadius];//设置阴影的圆角
    view.layer.shadowPath = path.CGPath;
}

+ (void)setCornerRadius:(UIView *)view width:(CGFloat)width {
    view.layer.masksToBounds = NO;
    view.layer.cornerRadius = width / 1.0;
}

+ (NSDictionary *)deleteFileAt:(NSString *)path {
    BOOL isDir = false;
    BOOL success = false;
    BOOL exist = false;
    [[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir];
    if (exist) {
    }
    success = [[NSFileManager defaultManager] removeItemAtPath:path error:nil];
    return [NSDictionary dictionaryWithObjectsAndKeys:@(isDir), @"isDir", @(success), @"success", @(exist), @"exist", nil];
}

+ (UIViewController *)getCurrentVC {
    UIViewController *result = nil;
    UIWindow * window = [[UIApplication sharedApplication].delegate window];
    // app默认windowLevel是UIWindowLevelNormal，如果不是，找到UIWindowLevelNormal的
    if (window.windowLevel != UIWindowLevelNormal)
    {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for(UIWindow * tmpWin in windows)
        {
            if (tmpWin.windowLevel == UIWindowLevelNormal)
            {
                window = tmpWin;
                break;
            }
        }
    }
    id  nextResponder = nil;
    UIViewController *appRootVC=window.rootViewController;
    // 如果是present上来的appRootVC.presentedViewController 不为nil
    if (appRootVC.presentedViewController) {
        // 多层present
        while (appRootVC.presentedViewController) {
            appRootVC = appRootVC.presentedViewController;
            if (appRootVC) {
                nextResponder = appRootVC;
            }else{
                break;
            }
        }
        // nextResponder = appRootVC.presentedViewController;
    }else{
        
        // NSLog(@"===%@",[window subviews]);
        UIView *frontView = [[window subviews] objectAtIndex:0];
        nextResponder = [frontView nextResponder];
    }
    
    if ([nextResponder isKindOfClass:[UITabBarController class]]){
        UITabBarController * tabbar = (UITabBarController *)nextResponder;
        UINavigationController * nav = (UINavigationController *)tabbar.viewControllers[tabbar.selectedIndex];
        // UINavigationController * nav = tabbar.selectedViewController ; 上下两种写法都行
        result=nav.childViewControllers.lastObject;
        
    }else if ([nextResponder isKindOfClass:[UINavigationController class]]){
        UIViewController * nav = (UIViewController *)nextResponder;
        result = nav.childViewControllers.lastObject;
    }else{
        result = nextResponder;
    }
    return result;
}

+ (NSDictionary *)createDirAt:(NSString *)path {
    BOOL isDir = false;
    BOOL success = false;
    NSDictionary * dic = [[NSDictionary alloc] init];
    NSError * error = [NSError errorWithDomain:NSCocoaErrorDomain code:4 userInfo:dic];
    if (![[NSFileManager defaultManager] fileExistsAtPath:path isDirectory:&isDir]) {
        success = [[NSFileManager defaultManager] createDirectoryAtPath:path withIntermediateDirectories:YES attributes:nil error:&error];
    } else
        success = true;
    return [NSDictionary dictionaryWithObjectsAndKeys:@(isDir), @"isDir", @(success), @"success", error, @"error", nil];
}

+ (void)writefile:(NSString *)path string:(NSString *)string
{
    
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if(![fileManager fileExistsAtPath:path]) //如果不存在
    {
        NSString *str = @"参数：\n";
        [str writeToFile:path atomically:YES encoding:NSUTF8StringEncoding error:nil];
    }
    NSFileHandle *fileHandle = [NSFileHandle fileHandleForUpdatingAtPath:path];
    [fileHandle seekToEndOfFile];  //将节点跳到文件的末尾
    NSData* stringData  = [string dataUsingEncoding:NSUTF8StringEncoding];
    [fileHandle writeData:stringData]; //追加写入数据
    [fileHandle closeFile];
}

+ (BOOL)copyFile:(NSString *)path to:(NSString *)string {
    BOOL success = false;
    NSFileManager *fileManager = [NSFileManager defaultManager];
    if([fileManager fileExistsAtPath:path]) //如果存在
    {
        success = [fileManager copyItemAtPath:path toPath:string error:nil];
    }
    return success;
}

+ (void)saveKey:(NSString *)key value:(NSString *)value {
    [[NSUserDefaults standardUserDefaults] setObject:value forKey:key];
}

+ (NSString *)getKey:(NSString *)key {
    return [[NSUserDefaults standardUserDefaults] objectForKey:key];
}

+ (BOOL)checkPhoneNumber:(NSString *)number {
    NSString *MOBILE = @"^1(3[0-9]|4[5-9]|5[0-35-9]|7[0-9]|8[0-9]|70)\\d{8}$";
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    BOOL isMatch = [regextestmobile evaluateWithObject:number];
    return isMatch;
}

+ (BOOL)checkEmail:(NSString*)email {
    NSString* pattern =@"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate* predicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",pattern];
    BOOL isMatch = [predicate evaluateWithObject:email];
    return isMatch;
}

// 放大缩小屏幕
+ (void)viewScaleChnageValue:(UIView *)view scale:(CGFloat)scale {
    view.transform = CGAffineTransformMakeScale(scale, scale);
}

static ZZGlobalModel * object;// 定位信息
+ (ZZGlobalModel *)object {
    extern ZZGlobalModel * object;
    if (!object) object = [[ZZGlobalModel alloc] init];
    object.pmm = [ZZTools caculatePixelLength];
    return object;
}

+ (CGPoint)setToPoint:(NSSet *)set {
    UITouch *touch = [set anyObject];   //视图中的所有对象
    return [touch locationInView:[touch view]]; //返回触摸点在视图中的当前坐标
}

+ (UIImage *)getSnapshotImage:(CALayer *)layer
{
    UIGraphicsBeginImageContextWithOptions(CGSizeMake(SCREEN_WIDTH, SCREEN_HEIGHT), NO, [UIScreen mainScreen].scale);
    [layer renderInContext:UIGraphicsGetCurrentContext()];
    UIImage *snapshotImage = UIGraphicsGetImageFromCurrentImageContext();
    UIGraphicsEndImageContext();    
    return snapshotImage;
}

/**
 * image:传入图片
 * ratio:压缩比0~1,默认为1
 */
+ (NSData *)imageToData:(UIImage *)image ratio:(CGFloat)ratio {
    if (!ratio) ratio = 1;
    return UIImageJPEGRepresentation(image, ratio);
}

+ (NSString*)iphoneType {
    
    struct utsname systemInfo;
    
    uname(&systemInfo);
    
    NSString*platform = [NSString stringWithCString: systemInfo.machine encoding:NSASCIIStringEncoding];
    
    if([platform isEqualToString:@"iPhone1,1"]) return@"iPhone 2G";
    
    if([platform isEqualToString:@"iPhone1,2"]) return@"iPhone 3G";
    
    if([platform isEqualToString:@"iPhone2,1"]) return@"iPhone 3GS";
    
    if([platform isEqualToString:@"iPhone3,1"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,2"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone3,3"]) return@"iPhone 4";
    
    if([platform isEqualToString:@"iPhone4,1"]) return@"iPhone 4S";
    
    if([platform isEqualToString:@"iPhone5,1"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,2"]) return@"iPhone 5";
    
    if([platform isEqualToString:@"iPhone5,3"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone5,4"]) return@"iPhone 5c";
    
    if([platform isEqualToString:@"iPhone6,1"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone6,2"]) return@"iPhone 5s";
    
    if([platform isEqualToString:@"iPhone7,1"]) return@"iPhone 6 Plus";
    
    if([platform isEqualToString:@"iPhone7,2"]) return@"iPhone 6";
    
    if([platform isEqualToString:@"iPhone8,1"]) return@"iPhone 6s";
    
    if([platform isEqualToString:@"iPhone8,2"]) return@"iPhone 6s Plus";
    
    if([platform isEqualToString:@"iPhone8,4"]) return@"iPhone SE";
    
    if([platform isEqualToString:@"iPhone9,1"]) return@"iPhone 7";
    
    if([platform isEqualToString:@"iPhone9,2"]) return@"iPhone 7 Plus";
    
    if([platform isEqualToString:@"iPhone10,1"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,4"]) return@"iPhone 8";
    
    if([platform isEqualToString:@"iPhone10,2"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,5"]) return@"iPhone 8 Plus";
    
    if([platform isEqualToString:@"iPhone10,3"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPhone10,6"]) return@"iPhone X";
    
    if([platform isEqualToString:@"iPod1,1"]) return@"iPod Touch 1G";
    
    if([platform isEqualToString:@"iPod2,1"]) return@"iPod Touch 2G";
    
    if([platform isEqualToString:@"iPod3,1"]) return@"iPod Touch 3G";
    
    if([platform isEqualToString:@"iPod4,1"]) return@"iPod Touch 4G";
    
    if([platform isEqualToString:@"iPod5,1"]) return@"iPod Touch 5G";
    
    if([platform isEqualToString:@"iPad1,1"]) return@"iPad 1G";
    
    if([platform isEqualToString:@"iPad2,1"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,2"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,3"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,4"]) return@"iPad 2";
    
    if([platform isEqualToString:@"iPad2,5"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,6"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad2,7"]) return@"iPad Mini 1G";
    
    if([platform isEqualToString:@"iPad3,1"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,2"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,3"]) return@"iPad 3";
    
    if([platform isEqualToString:@"iPad3,4"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,5"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad3,6"]) return@"iPad 4";
    
    if([platform isEqualToString:@"iPad4,1"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,2"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,3"]) return@"iPad Air";
    
    if([platform isEqualToString:@"iPad4,4"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,5"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,6"]) return@"iPad Mini 2G";
    
    if([platform isEqualToString:@"iPad4,7"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,8"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad4,9"]) return@"iPad Mini 3";
    
    if([platform isEqualToString:@"iPad5,1"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,2"]) return@"iPad Mini 4";
    
    if([platform isEqualToString:@"iPad5,3"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad5,4"]) return@"iPad Air 2";
    
    if([platform isEqualToString:@"iPad6,3"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,4"]) return@"iPad Pro 9.7";
    
    if([platform isEqualToString:@"iPad6,7"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"iPad6,8"]) return@"iPad Pro 12.9";
    
    if([platform isEqualToString:@"i386"]) return@"iPhone Simulator";
    
    if([platform isEqualToString:@"x86_64"]) return@"iPhone Simulator";
    
    return platform;
    
}


@end
