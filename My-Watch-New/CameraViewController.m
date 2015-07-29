//
//  CameraViewController.m
//  AVRecordTest
//
//  Created by maginawin on 14-9-9.
//  Copyright (c) 2014年 crazyit.org. All rights reserved.
//

#import "CameraViewController.h"

#define NOTI_CAMERA_TAKE @"noti_cameraTake" //camera take or open
#define NOTI_CAMERA_OFF @"noti_cameraOff" //camera off


static void *AVCamFocusModeObserverContext = &AVCamFocusModeObserverContext;
@interface CameraViewController (WWDRecoerdManagerDelegate)<WWDRecoredManagerDelegate>

@end

@implementation CameraViewController
AVCaptureVideoPreviewLayer* previewLayer;
UILabel* focusModeLabel;

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor blackColor];
    
    // 如果没有初始化FKRecordMangaer，初始化FKRecordMangaer
    [self configureRecordManager];
}

- (void)viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    
    // 如果没有初始化FKRecordMangaer，初始化FKRecordMangaer
    [self configureRecordManager];
}

- (void)viewDidDisappear:(BOOL)animated{
    [super viewDidDisappear:animated];
    
    [self.recordManager.session stopRunning];
    self.recordManager = nil;
}

- (IBAction)toggleCameraClick:(id)sender {
    [self toggleCamera];
}
#pragma mark - Public

// 拍照
- (void)takePicture {
    // 拍摄静止照片
    [self.recordManager captureStillImage];
    // 创建一个UIView实现闪屏效果
    UIView *flashView = [[UIView alloc] initWithFrame:[
                                                       [self videoPreviewView] frame]];
    // 设置背景色为白色
    flashView.backgroundColor= [UIColor whiteColor];
    // 添加flashView
    [self.view.window addSubview:flashView];
    // 控制flashView执行在0.4秒之内变成完全透明，变为透明时删除该flashVew
    [UIView animateWithDuration:.4f
                     animations:^{
                         [flashView setAlpha:0.f];
                     }
                     completion:^(BOOL finished){
                         [flashView removeFromSuperview];
                     }
     ];
}

// 切换前后摄像头
- (void)toggleCamera {
    // 切换前后的摄像头
    [self.recordManager toggleCamera];
    // 执行初始化对焦
    [self.recordManager continuousFocusAtPoint:CGPointMake(.5f, .5f)];
}

#pragma mark - Assistor

// 配置摄像头
- (void)configureRecordManager {
    
    if (!_recordManager) {
        self.recordManager = [[WWDRecoredManager alloc] init];
        self.recordManager.delegate = self;
        // 为FKRecordMangaer安装Session
        if ([self.recordManager setupSession])
        {
            [self.videoPreviewView.layer setMasksToBounds:YES];
            // 创建摄像头的预览Layer
            previewLayer = [[AVCaptureVideoPreviewLayer alloc]
                            initWithSession:self.recordManager.session];
            // 获取当前视图控制器内view的bounds
            CGRect bounds = self.view.bounds;
            // 设置预览Layer的大小和位置
            previewLayer.frame = bounds;
            // 设置预览Layer的缩放方式
            [previewLayer setVideoGravity:AVLayerVideoGravityResizeAspectFill];
            // 将预览Layer添加到预览UIView上
            [self.videoPreviewView.layer insertSublayer:previewLayer
                                                  below:[[self.videoPreviewView.layer sublayers] objectAtIndex:0]];
            // 以异步方式启动FKRecordManager内包装的AVCaptureSession
            dispatch_async(dispatch_get_global_queue(
                                                     DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), ^{
                [self.recordManager.session startRunning];
            });
            [self setAutoFocus];
        }
        
    }
}

// 将预览UIView上坐标系统转换为摄像头的摄像头的坐标系统。
// 在摄像头坐标系统中， {0,0}代表图片的左上角，{1,1}代表右下角
- (CGPoint)convertToPointOfInterestFromViewCoordinates:(CGPoint)viewCoordinates
{
    CGPoint pointOfInterest = CGPointMake(.5f, .5f);
    // 获取预览Layer的大小和位置
    CGSize frameSize = [[self videoPreviewView] frame].size;
    
    if ([previewLayer.videoGravity isEqualToString:AVLayerVideoGravityResize])
    {
        // 对X、Y坐标进行缩放，并执行反转
        pointOfInterest = CGPointMake(viewCoordinates.y / frameSize.height,
                                      1.0f - (viewCoordinates.x / frameSize.width));
    }
    else
    {
        CGRect cleanAperture;
        for (AVCaptureInputPort *port in self.recordManager.videoInput.ports)
        {
            if ([port mediaType] == AVMediaTypeVideo)
            {
                cleanAperture = CMVideoFormatDescriptionGetCleanAperture
                ([port formatDescription], YES);
                CGSize apertureSize = cleanAperture.size;
                CGPoint point = viewCoordinates;
                CGFloat apertureRatio = apertureSize.height / apertureSize.width;
                CGFloat viewRatio = frameSize.width / frameSize.height;
                CGFloat xc = .5f;
                CGFloat yc = .5f;
                if ([previewLayer.videoGravity isEqualToString:
                     AVLayerVideoGravityResizeAspect])
                {
                    if (viewRatio > apertureRatio)
                    {
                        CGFloat y2 = frameSize.height;
                        CGFloat x2 = frameSize.height * apertureRatio;
                        CGFloat x1 = frameSize.width;
                        CGFloat blackBar = (x1 - x2) / 2;
                        if (point.x >= blackBar && point.x <= blackBar + x2)
                        {
                            xc = point.y / y2;
                            yc = 1.f - ((point.x - blackBar) / x2);
                        }
                    }
                    else
                    {
                        CGFloat y2 = frameSize.width / apertureRatio;
                        CGFloat y1 = frameSize.height;
                        CGFloat x2 = frameSize.width;
                        CGFloat blackBar = (y1 - y2) / 2;
                        if (point.y >= blackBar && point.y <= blackBar + y2)
                        {
                            xc = ((point.y - blackBar) / y2);
                            yc = 1.f - (point.x / x2);
                        }
                    }
                }
                else if([previewLayer.videoGravity isEqualToString:
                         AVLayerVideoGravityResizeAspectFill])
                {
                    // 对X、Y坐标进行缩放，并执行反转
                    if (viewRatio > apertureRatio) {
                        CGFloat y2 = apertureSize.width * (frameSize.width
                                                           / apertureSize.height);
                        xc = (point.y + ((y2 - frameSize.height) / 2.f)) / y2;
                        yc = (frameSize.width - point.x) / frameSize.width;
                    }
                    else
                    {
                        CGFloat x2 = apertureSize.height * (frameSize.height
                                                            / apertureSize.width);
                        yc = 1.f - ((point.x + ((x2 - frameSize.width) / 2)) / x2);
                        xc = point.y / frameSize.height;
                    }
                }
                pointOfInterest = CGPointMake(xc, yc);
                break;
            }
        }
    }
    return pointOfInterest;
}


- (void)setAutoFocus{
    if ([[[self.recordManager videoInput] device]
         isFocusPointOfInterestSupported])
    {
        // 设置使用连续对焦
        [self.recordManager continuousFocusAtPoint:CGPointMake(.5f, .5f)];
    }
}

@end

