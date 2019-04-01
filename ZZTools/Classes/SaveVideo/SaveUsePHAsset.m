//
//  SaveUsePHAsset.m
//  YufeiCamera
//
//  Created by huaxia on 2018/1/30.
//  Copyright © 2018年 Ömer Faruk Gül. All rights reserved.
//

#import "SaveUsePHAsset.h"
#import <Photos/Photos.h>

@implementation SaveUsePHAsset

+ (void )save {
    // 0.判断状态
    PHAuthorizationStatus status = [PHPhotoLibrary authorizationStatus];
    if (status == PHAuthorizationStatusDenied) {
        NSLog(@"用户拒绝当前应用访问相册,我们需要提醒用户打开访问开关");
    }else if (status == PHAuthorizationStatusRestricted){
        NSLog(@"家长控制,不允许访问");
    }else if (status == PHAuthorizationStatusNotDetermined){
        NSLog(@"用户还没有做出选择");
//        [self saveImage];
    }else if (status == PHAuthorizationStatusAuthorized){
        NSLog(@"用户允许当前应用访问相册");
//        [self saveImage];
    }
}

/**
 *  返回相册
 */
+ (PHAssetCollection *)collection:(NSString *)name {
    // 先获得之前创建过的相册
    PHFetchResult<PHAssetCollection *> *collectionResult = [PHAssetCollection fetchAssetCollectionsWithType:PHAssetCollectionTypeAlbum subtype:PHAssetCollectionSubtypeAlbumRegular options:nil];
    for (PHAssetCollection *collection in collectionResult) {
        if ([collection.localizedTitle isEqualToString:name]) {
            return collection;
        }
    }
    
    // 如果相册不存在,就创建新的相册(文件夹)
    __block NSString *collectionId = nil; // __block修改block外部的变量的值
    // 这个方法会在相册创建完毕后才会返回
    [[PHPhotoLibrary sharedPhotoLibrary] performChangesAndWait:^{
        // 新建一个PHAssertCollectionChangeRequest对象, 用来创建一个新的相册
        collectionId = [PHAssetCollectionChangeRequest creationRequestForAssetCollectionWithTitle:name].placeholderForCreatedAssetCollection.localIdentifier;
    } error:nil];
    
    return [PHAssetCollection fetchAssetCollectionsWithLocalIdentifiers:@[collectionId] options:nil].firstObject;
}


/**
 *  返回相册,避免重复创建相册引起不必要的错误
 */
+ (void)saveVideo:(NSURL *)url name:(NSString *)name complete:(void (^)(NSString * astID))complete {
    /*
     PHAsset : 一个PHAsset对象就代表一个资源文件,比如一张图片
     PHAssetCollection : 一个PHAssetCollection对象就代表一个相册
     */
    
    __block NSString *assetId = nil;
    // 1. 存储图片到"相机胶卷"
    [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{ // 这个block里保存一些"修改"性质的代码
        // 新建一个PHAssetCreationRequest对象, 保存图片到"相机胶卷"
        // 返回PHAsset(图片)的字符串标识
//        [PHAssetChangeRequest creationRequestForAssetFromVideoAtFileURL:url];
        assetId = [PHAssetCreationRequest creationRequestForAssetFromVideoAtFileURL:url].placeholderForCreatedAsset.localIdentifier;
        complete(assetId);
    } completionHandler:^(BOOL success, NSError * _Nullable error) {
        if (error) {
            NSLog(@"保存图片到相机胶卷中失败");
            return;
        }
        
        NSLog(@"成功保存图片到相机胶卷中");
        
        // 2. 获得相册对象
        PHAssetCollection *collection = [self collection:name];
        
        // 3. 将“相机胶卷”中的图片添加到新的相册
        [[PHPhotoLibrary sharedPhotoLibrary] performChanges:^{
            PHAssetCollectionChangeRequest *request = [PHAssetCollectionChangeRequest changeRequestForAssetCollection:collection];
            
            // 根据唯一标示获得相片对象
            PHAsset *asset = [PHAsset fetchAssetsWithLocalIdentifiers:@[assetId] options:nil].firstObject;
            // 添加图片到相册中
            [request addAssets:@[asset]];
        } completionHandler:^(BOOL success, NSError * _Nullable error) {
            if (error) {
                NSLog(@"添加图片到相册中失败");
                return;
            }
            
            NSLog(@"成功添加图片到相册中");
//            [[NSOperationQueue mainQueue] addOperationWithBlock:^{
//                [SVProgressHUD showSuccessWithStatus:@"保存成功"];
//            }];
        }];
    }];
}

@end
