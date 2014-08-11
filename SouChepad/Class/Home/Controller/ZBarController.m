//
//  ZBarController.m
//  Athena
//
//  Created by 张艳东 on 14-6-26.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "ZBarController.h"
#import <AVFoundation/AVFoundation.h>
#import "HttpManager.h"
#import "CarDetailWebView.h"

@interface ZBarController () <AVCaptureMetadataOutputObjectsDelegate>
{
//    CarDetailWebView *carDetailVC;
}
@property (strong, nonatomic) AVCaptureSession *session;
@property (strong, nonatomic) AVCaptureVideoPreviewLayer *previewLayer;

@end

@implementation ZBarController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setBackgroundColor:[UIColor whiteColor]];
    
    UIView *vie = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 100)];
    [vie setAutoresizingMask:UIViewAutoresizingFlexibleWidth];
    [vie setBackgroundColor:[UIColor hexStringToColor:KBaseColo]];
    UIButton *but = [[UIButton alloc] initWithFrame:CGRectMake(20, 30, 100, 40)];
    [but setImage:[UIImage imageNamed:@"tubiao_37"] forState:UIControlStateNormal];
    [but addTarget:self action:@selector(dismiselfVC) forControlEvents:UIControlEventTouchUpInside];
    [vie addSubview:but];
    [self.view addSubview:vie];

}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:YES];
    [self setupCamera];
}

- (void)setupCamera
{
    // 1. 摄像头设备
    AVCaptureDevice *device = [AVCaptureDevice defaultDeviceWithMediaType:AVMediaTypeVideo];
    
    // 2. 设置输入
    // 因为模拟器是没有摄像头的，因此在此最好做一个判断
    NSError *error = nil;
    AVCaptureDeviceInput *input = [AVCaptureDeviceInput deviceInputWithDevice:device error:&error];
    
    if (error) {
        NSLog(@"没有摄像头-%@", error.localizedDescription);
//        [self.navigationController popViewControllerAnimated:YES];
        [self dismissViewControllerAnimated:YES completion:^{
            
        }];
        return;
    }
    
    // 3. 设置输出(Metadata元数据)
    AVCaptureMetadataOutput *output = [[AVCaptureMetadataOutput alloc] init];
    // 3.1 设置输出的代理
    // 说明：使用主线程队列，相应比较同步，使用其他队列，相应不同步，容易让用户产生不好的体验
    [output setMetadataObjectsDelegate:self queue:dispatch_get_main_queue()];
    
    // 4. 拍摄会话
    AVCaptureSession *session = [[AVCaptureSession alloc] init];
    
    [session setSessionPreset:AVCaptureSessionPresetMedium];
    // 添加session的输入和输出
    [session addInput:input];
    [session addOutput:output];
    // 4.1 设置输出的格式
    // 提示：一定要先设置会话的输出为output之后，再指定输出的元数据类型！
    [output setMetadataObjectTypes:@[AVMetadataObjectTypeQRCode]];
    
    // 5. 设置预览图层（用来让用户能够看到扫描情况）
    AVCaptureVideoPreviewLayer *preview = [AVCaptureVideoPreviewLayer layerWithSession:session];
    // 5.1 设置preview图层的属性
    [preview setVideoGravity:AVLayerVideoGravityResizeAspectFill];
    // 5.2 设置preview图层的大小
    [preview setFrame:self.view.bounds];
    // 5.3 将图层添加到视图的图层
    [self.view.layer insertSublayer:preview atIndex:0];
//    [self.view setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
    self.previewLayer = preview;
    self.previewLayer.connection.videoOrientation =      (AVCaptureVideoOrientation)[[UIApplication sharedApplication] statusBarOrientation];
    
    // 6. 启动会话
    [session startRunning];
    self.session = session;
    

}


static AVCaptureVideoOrientation avOrientationForInterfaceOrientation(UIInterfaceOrientation iOrientation)
{
    AVCaptureVideoOrientation result;
    if ( iOrientation == UIInterfaceOrientationLandscapeLeft )
        result = AVCaptureVideoOrientationLandscapeLeft;
    else if ( iOrientation == UIInterfaceOrientationLandscapeRight )
        result = AVCaptureVideoOrientationLandscapeRight;
    return result;
}
//
- (void)willRotateToInterfaceOrientation:(UIInterfaceOrientation)toInterfaceOrientation duration:(NSTimeInterval)duration
{
    AVCaptureVideoOrientation avcaptureOrientation = avOrientationForInterfaceOrientation(toInterfaceOrientation);
    self.previewLayer.connection.videoOrientation =  avcaptureOrientation;
}

- (void)dismiselfVC
{
//    [self.navigationController popViewControllerAnimated:YES];
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

#pragma mark - 输出代理方法
// 此方法是在识别到QRCode，并且完成转换
// 如果QRCode的内容越大，转换需要的时间就越长
- (void)captureOutput:(AVCaptureOutput *)captureOutput didOutputMetadataObjects:(NSArray *)metadataObjects fromConnection:(AVCaptureConnection *)connection
{
    // 会频繁的扫描，调用代理方法
    // 1. 如果扫描完成，停止会话
    [self.session stopRunning];
    // 2. 删除预览图层
    [self.previewLayer removeFromSuperlayer];
    
    // 3. 设置界面显示扫描结果
    if (metadataObjects.count > 0) {
        AVMetadataMachineReadableCodeObject *objAV = metadataObjects[0];
        if ([_delegate respondsToSelector:@selector(zBarController:didFinishPickingMediaWithInfo:)]) {
            [_delegate zBarController:self didFinishPickingMediaWithInfo:@{@"dataString": objAV.stringValue}];
        }
        
        
//        // 提示：如果需要对url或者名片等信息进行扫描，可以在此进行扩展！
//        [HttpManager getCarInVin:@{@"vin":objAV.stringValue} Success:^(id obj) {
//            if (obj) {
//                CarDetailWebView *carDetailVC = [[CarDetailWebView alloc] init];
//                [carDetailVC setCarID:obj];
//                [carDetailVC setDelegate:self];
////                [self.view addSubview:carDetailVC.view];
//                [self presentViewController:carDetailVC animated:YES completion:^{
//                }];
//            }
//        } fail:^(id obj) {
//            
//        }];
    }
}

@end
