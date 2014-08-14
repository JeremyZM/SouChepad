//
//  ImageChooseView.m
//  Athena
//
//  Created by 张艳东 on 14-7-24.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "ImageChooseView.h"
#import "ImageViewController.h"
#import "SJAvatarBrowser.h"

@interface ImageChooseView () <UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UIPopoverController *popoVC;
}

@end

@implementation ImageChooseView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self setUserInteractionEnabled:YES];
        UITapGestureRecognizer *oneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage:)];
        [self addGestureRecognizer:oneTap];
        [self setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"buy_60.png"]]];
        UILongPressGestureRecognizer *cardUPlongPressGesture = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGestures:)];
        [self addGestureRecognizer:cardUPlongPressGesture];
    }
    return self;
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



// 单击手势
- (void)chooseImage:(UITapGestureRecognizer*)tap
{
    
    UIImageView *image = (UIImageView *)tap.view;
    
    if (image.image) {
//        ImageViewController *imageVC = [[ImageViewController alloc] init];
//        [imageVC setAvatarImageView:image];
//        [self.customPIMVC presentViewController:imageVC animated:YES completion:^{
//            
//        }];
        [SJAvatarBrowser showImage:image];
        
    }else{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
        [sheet setTag:221];
        [sheet showFromRect:self.frame inView:self.superview animated:YES];
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
                UIImage *imageCamera = [UIImage imageNamed:@"shenfengzheng1"];
                
                UIImageView *cameraImage = [[UIImageView alloc] initWithImage:imageCamera];
                [cameraImage setCenter:imagePicker.view.center];
                [cameraImage setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
                [imagePicker setCameraOverlayView:cameraImage];
//                [self.customPIMVC presentViewController:imagePicker animated:YES completion:^{
                    
//                }];
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
                [popoVC  presentPopoverFromRect:self.frame inView:self.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }else {
                
            }
            
        }
        
    }else if (actionSheet.tag==222)
    {
        
        if (buttonIndex==0) {
            [self setImage:nil];
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
        [self setImage:image];
        [popoVC dismissPopoverAnimated:YES];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{
            UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
            [self setImage:image];
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





@end
