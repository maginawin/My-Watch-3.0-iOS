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
@property (nonatomic, retain) WWDRecoredManager* recordManager;
@property (nonatomic, retain) IBOutlet UIView* videoPreviewView;

- (IBAction)toggleCamera:(id)sender;
- (IBAction)captureStillImage:(id)sender;
@end
