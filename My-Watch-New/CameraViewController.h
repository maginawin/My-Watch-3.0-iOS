//
//  CameraViewController.h
//  AVRecordTest
//
//  Created by maginawin on 14-9-9.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>
#import "WWDRecoredManager.h"

@interface CameraViewController : UIViewController
@property (nonatomic, strong) WWDRecoredManager* recordManager;
@property (nonatomic, strong) IBOutlet UIView* videoPreviewView;

/** 拍照片 */
- (void)takePicture;

/** 切换摄像头 */
- (void)toggleCamera;

@end
