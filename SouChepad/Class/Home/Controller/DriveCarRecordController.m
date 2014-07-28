//
//  DriveCarRecordController.m
//  Athena
//
//  Created by 张艳东 on 14-7-24.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "DriveCarRecordController.h"
#import "HttpManager.h"
#import "DriveCarLastData.h"
#import "UIImageView+WebCache.h"
#import "ImageViewController.h"
#import "ProgressHUD.h"
#import "MBProgressHUD.h"
#import "NSString+val.h"


@interface DriveCarRecordController () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    DriveCarLastData *_driveCarDataM;
    UIPopoverController *popoVC;
    NSMutableDictionary *driveDicData;
}
@end

@implementation DriveCarRecordController


- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.navigationItem setTitle:@"填写试驾记录"];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"取消" style:UIBarButtonItemStyleBordered target:self action:@selector(dismissSelfController:)];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"开始试驾" style:UIBarButtonItemStyleBordered target:self action:@selector(saveDriveCarRecord:)];
    
    driveDicData = [NSMutableDictionary dictionary];
    
    [self.drivingLicenseImage setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"buy_64.png"]]];
    
    UITapGestureRecognizer *driveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage:)];
    [self.drivingLicenseImage addGestureRecognizer:driveTap];
    UILongPressGestureRecognizer *driveCardlongPressGesture = [[UILongPressGestureRecognizer alloc]
                                                               initWithTarget:self
                                                               action:@selector(handleLongPressGestures:)];
    [self.drivingLicenseImage addGestureRecognizer:driveCardlongPressGesture];
    
    [self setDriveCarDataM:self.driveCarDataM];
}


// 单击手势
- (void)chooseImage:(UITapGestureRecognizer*)tap
{
    
    UIImageView *image = (UIImageView *)tap.view;
    if (image.image) {
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        [imageVC setAvatarImageView:image];
        [self presentViewController:imageVC animated:YES completion:^{
            
        }];
        //        [SJAvatarBrowser showImage:image];
        
    }else{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
        [sheet setTag:221];
        [sheet showFromRect:image.frame inView:image.superview animated:YES];
    }
}


// 长按手势
- (void) handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{
    if ([paramSender state] == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = (UIImageView*)paramSender.view;
        if (imageView.image) {
            UIActionSheet *deleSheet = [[UIActionSheet alloc] initWithTitle:@"删除照片" delegate:self cancelButtonTitle:nil destructiveButtonTitle:@"确认删除" otherButtonTitles:nil, nil];
            [deleSheet setTag:222];
            [deleSheet showFromRect:imageView.frame inView:imageView.superview animated:YES];
        }
        
    }
}


#pragma mark -
- (void)actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex
{
    
    if (actionSheet.tag==221) {
        if (buttonIndex==0) { //拍照
            // 判断相机可以使用
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypeCamera]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                [imagePicker setAllowsEditing:NO];
                [imagePicker setSourceType:UIImagePickerControllerSourceTypeCamera];
                imagePicker.showsCameraControls  = YES;
                UIImage *imageCamera = [UIImage imageNamed:@"jiashizheng"];

                UIImageView *cameraImage = [[UIImageView alloc] initWithImage:imageCamera];
                [cameraImage setCenter:imagePicker.view.center];
                [cameraImage setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
                [imagePicker setCameraOverlayView:cameraImage];
                [self presentViewController:imagePicker animated:YES completion:^{
                    
                }];
            }else {
                [[[UIAlertView alloc] initWithTitle:nil message:@"摄像头不可用！！！" delegate:self cancelButtonTitle:@"知道了！" otherButtonTitles:nil, nil] show];
            }
            
        }else if(buttonIndex ==1) {  // 从相册选择
            if ([UIImagePickerController isSourceTypeAvailable:UIImagePickerControllerSourceTypePhotoLibrary]) {
                UIImagePickerController *imagePicker = [[UIImagePickerController alloc] init];
                imagePicker.delegate = self;
                [imagePicker setAllowsEditing:YES];
                
                imagePicker.sourceType = UIImagePickerControllerSourceTypePhotoLibrary;
                
                popoVC = [[UIPopoverController alloc] initWithContentViewController:imagePicker];
                [popoVC setPopoverContentSize:CGSizeMake(320, 480) animated:YES];
                [popoVC  presentPopoverFromRect:self.drivingLicenseImage.frame inView:self.drivingLicenseImage.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }else {
                
            }
            
        }
        
    }else if (actionSheet.tag==222)
    {
        if (buttonIndex==0) {
            [driveDicData removeObjectForKey:@"drivelicense"];
            [self.drivingLicenseImage setImage:nil];
        }
    }
}

// 保存图片后到相册后，调用的相关方法，查看是否保存成功
- (void) imageWasSavedSuccessfully:(UIImage *)paramImage didFinishSavingWithError:(NSError *)paramError contextInfo:(void *)paramContextInfo{
    if (paramError == nil){
//        [ProgressHUD showSuccess:@"保存成功"];
    } else {
//        [ProgressHUD showSuccess:@"保存失败"];
        
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    
    if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
        [self.drivingLicenseImage setImage:image];
        [popoVC dismissPopoverAnimated:YES];
        [self uploadImage];
        
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            [self.drivingLicenseImage setImage:image];
            [self uploadImage];
            UIImageWriteToSavedPhotosAlbum(image, self,
                                           @selector(imageWasSavedSuccessfully:didFinishSavingWithError:contextInfo:), nil);
        }];
        
    }
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}



- (void)setDriveCarDataM:(DriveCarLastData *)driveCarDataM
{
    _driveCarDataM = driveCarDataM;
    [self.nameTextF setText:driveCarDataM.name];
    [self.phoneTextF setText:driveCarDataM.phone];
    [self.startMileTextF setText:driveCarDataM.mile];
    [self.drivingLicenseImage setImageWithURL:[NSURL URLWithString:[NSString stringWithFormat:@"%@%@",KImageBaseURL,driveCarDataM.drivelicense]] placeholderImage:nil options:SDWebImageLowPriority|SDWebImageRetryFailed];
    if (driveCarDataM.drivelicense) {
        [driveDicData setObject:driveCarDataM.drivelicense forKey:@"drivelicense"];
    }
    
    
}

- (void)saveDriveCarRecord:(UIBarButtonItem*)item
{
    if (self.nameTextF.text.length && [NSString phoneValidate:self.phoneTextF.text] && self.startMileTextF.text.length && [driveDicData objectForKey:@"drivelicense"]) {
        [driveDicData setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"user"];
        [driveDicData setObject:self.carId forKey:@"carId"];
        [driveDicData setObject:[[NSUserDefaults standardUserDefaults] objectForKey:userDefaultsName] forKey:@"userName"];
        
        [driveDicData setObject:self.nameTextF.text forKey:@"name"];
        [driveDicData setObject:self.phoneTextF.text forKey:@"phone"];
        [driveDicData setObject:self.startMileTextF.text forKey:@"beginMile"];
        
        [HttpManager saveDriveCarBegin:driveDicData Success:^(id obj) {
            [self.navigationController dismissViewControllerAnimated:YES completion:^{
                [ProgressHUD showSuccess:@"开始试驾成功！"];
            }];
        } fail:^(id obj) {
            
        }];
        
    }else{
        [ProgressHUD showError:@"信息不完整！！"];
    }

}

- (void)uploadImage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    [hud setMode:MBProgressHUDModeAnnularDeterminate];
    
    [HttpManager requestUploadImage:self.drivingLicenseImage.image imageIndex:0 success:^(id obj) {
        NSDictionary *pathDic = obj;
        if ([pathDic objectForKey:@"status"]) {
            NSString *pathStr = [[pathDic objectForKey:@"path"] stringByReplacingOccurrencesOfString:@"http://res.souche.com/" withString:@""];
            [driveDicData setObject:pathStr forKey:@"drivelicense"];
            [hud setMode:MBProgressHUDModeCustomView];
            [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_SUCCESS]];
            sleep(1);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        }else {
            [hud setMode:MBProgressHUDModeCustomView];
            [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_ERROR]];
            [hud setLabelText:@"上传照片失败"];
            sleep(1);
            [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
            [self.drivingLicenseImage setImage:nil];
        }
    } uploadProgress:^(NSString *progress) {
        [hud setLabelText:[NSString stringWithFormat:@"%@%@",progress,@"%"]];
        [hud setProgress:([progress floatValue]/100)];

    } fail:^(id obj) {
        [hud setMode:MBProgressHUDModeCustomView];
        [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_ERROR]];
        [hud setLabelText:@"上传照片失败"];
        sleep(1);
        [MBProgressHUD hideAllHUDsForView:self.view animated:YES];
        [self.drivingLicenseImage setImage:nil];
    }];

}


- (void)dismissSelfController:(UIBarButtonItem*)item
{
    [self dismissViewControllerAnimated:YES completion:^{
        
    }];
}

@end
