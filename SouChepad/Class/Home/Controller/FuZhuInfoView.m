//
//  FuZhuInfoView.m
//  SouChepad
//
//  Created by 张艳东 on 14-5-6.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import "FuZhuInfoView.h"
#import "SJAvatarBrowser.h"
#import "ImageViewController.h"
#import "ProgressHUD.h"
#import "UIImageView+WebCache.h"
#import "MBProgressHUD.h"
#import "HttpManager.h"
#import "ALAssetsLibrary+CustomPhotoAlbum.h"
#import "UIImage+Utility.h"

@interface FuZhuInfoView()<UITextFieldDelegate,UITableViewDataSource,UITableViewDelegate,UIActionSheetDelegate,UIImagePickerControllerDelegate,UINavigationControllerDelegate>
{
    UITableView *_fzInfoTable;
    NSArray *_dataArray;

    UIImageView *cardIDup;
    UIImageView *cardIDdown;
    UIImageView *driveCard;
    UIImageView *selectImage;
    
    UIPopoverController *popoVC;
    
    UserVOModel *userVoModel;
    UserExtendModel *userExtendModel;
    ALAssetsLibrary *_alassets;
}

@end

@implementation FuZhuInfoView


- (id)initWithFrame:(CGRect)frame userVOModel:(UserVOModel*)userVo userExtendmodel:(UserExtendModel*)userExtendM
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        userVoModel = userVo;
        userExtendModel = userExtendM;
        _fzInfoTable = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height-130) style:UITableViewStylePlain];
        [_fzInfoTable setSeparatorColor:[UIColor hexStringToColor:KSeparatorColor]];
        [_fzInfoTable setSeparatorInset:UIEdgeInsetsMake(0, 20, 0, 20)];
        [_fzInfoTable setDelegate:self];
        [_fzInfoTable setDataSource:self];
        [_fzInfoTable setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleHeight];
        [self addSubview:_fzInfoTable];
        
        _dataArray = @[@"来源",@"QQ",@"微信",@"邮箱",@"座机",@"生日",@"年龄段",@"身份证",@"所在地"];
        
        UIView *pickView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height-130, frame.size.width, 130)];
        [pickView setAutoresizingMask:UIViewAutoresizingFlexibleWidth|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
        
        UILabel *zhengjian = [[UILabel alloc] initWithFrame:CGRectMake(20, 20, 100, 30)];
        [zhengjian setText:@"证件上传"];
        [zhengjian setFont:KFont18];
        [zhengjian setTextColor:[UIColor darkGrayColor]];
        [pickView addSubview:zhengjian];
        [self addSubview:pickView];
        
        
        cardIDup = [[UIImageView alloc] initWithFrame:CGRectMake(150, 20, 120, 120*768/1024)];
        [cardIDup setTag:1024+1];
        [cardIDup setUserInteractionEnabled:YES];
        UITapGestureRecognizer *oneTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage:)];
        [cardIDup addGestureRecognizer:oneTap];
        [pickView addSubview:cardIDup];
        [cardIDup setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"buy_60.png"]]];
        
        UIImage *img = [UIImage new];
        [img setImageWithUrl:userExtendM.idcardFront scaleToSize:cardIDup.frame.size forImageView:cardIDup];
        
        UILongPressGestureRecognizer *cardUPlongPressGesture = [[UILongPressGestureRecognizer alloc]
                                           initWithTarget:self
                                           action:@selector(handleLongPressGestures:)];
        [cardIDup addGestureRecognizer:cardUPlongPressGesture];
        
        
        cardIDdown = [[UIImageView alloc] initWithFrame:CGRectMake(330, 20, 120, 120*768/1024)];
        [cardIDdown setTag:1024+2];
        [cardIDdown setUserInteractionEnabled:YES];
        UITapGestureRecognizer *twoTap=[[UITapGestureRecognizer alloc]initWithTarget:self action:@selector(chooseImage:)];
        [cardIDdown addGestureRecognizer:twoTap];
        [pickView addSubview:cardIDdown];
        [cardIDdown setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"buy_62.png"]]];
        
        [img setImageWithUrl:userExtendM.idcardBack scaleToSize:cardIDdown.frame.size forImageView:cardIDdown];
        
        UILongPressGestureRecognizer *cardIDdownPressGesture = [[UILongPressGestureRecognizer alloc]
                                                                   initWithTarget:self
                                                                   action:@selector(handleLongPressGestures:)];
        [cardIDdown addGestureRecognizer:cardIDdownPressGesture];
        
        
        driveCard = [[UIImageView alloc] initWithFrame:CGRectMake(510, 20, 120, 120*768/1024)];
        [driveCard setTag:1024+3];
        [driveCard setUserInteractionEnabled:YES];
        [driveCard setBackgroundColor:[UIColor colorWithPatternImage:[UIImage imageNamed:@"buy_64.png"]]];
        
        [img setImageWithUrl:userExtendM.drivelicense scaleToSize:driveCard.frame.size forImageView:driveCard];
        
        UITapGestureRecognizer *driveTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(chooseImage:)];
        [driveCard addGestureRecognizer:driveTap];
        [pickView addSubview:driveCard];
        UILongPressGestureRecognizer *driveCardlongPressGesture = [[UILongPressGestureRecognizer alloc]
                                                                initWithTarget:self
                                                                action:@selector(handleLongPressGestures:)];
        [driveCard addGestureRecognizer:driveCardlongPressGesture];
        
        
        _alassets = [[ALAssetsLibrary alloc] init];
    }
    return self;
}

- (void)setDataDic:(NSDictionary *)dataDic
{
    _dataDic = dataDic;
    userVoModel = [dataDic objectForKey:@"user"];
    userExtendModel = [dataDic objectForKey:@"userExtend"];
    [_fzInfoTable reloadData];
    
    [[UIImage new] setImageWithUrl:userExtendModel.idcardFront scaleToSize:cardIDup.frame.size forImageView:cardIDup];
    
    [[UIImage new] setImageWithUrl:userExtendModel.idcardBack scaleToSize:cardIDdown.frame.size forImageView:cardIDdown];
    
    [[UIImage new] setImageWithUrl:userExtendModel.drivelicense scaleToSize:driveCard.frame.size forImageView:driveCard];
}


// 长按手势
- (void) handleLongPressGestures:(UILongPressGestureRecognizer *)paramSender{
    if ([paramSender state] == UIGestureRecognizerStateBegan) {
        UIImageView *imageView = (UIImageView*)paramSender.view;
        selectImage = imageView;
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
    selectImage = image;
    if (image.image) {
        ImageViewController *imageVC = [[ImageViewController alloc] init];
        [imageVC setAvatarImageView:image];
        [self.customPIMVC presentViewController:imageVC animated:YES completion:^{
            
        }];
//        [SJAvatarBrowser showImage:image];
        
    }else{
        
        UIActionSheet *sheet = [[UIActionSheet alloc] initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:nil otherButtonTitles:@"拍照",@"从相册选择",nil];
        [sheet setTag:221];
        [sheet showFromRect:image.frame inView:image.superview animated:YES];
    }
}

- (void)uploadImage
{
    MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:selectImage.superview animated:YES];
    [hud setMode:MBProgressHUDModeAnnularDeterminate];

    [HttpManager requestUploadImage:selectImage.image imageIndex:selectImage.tag-1024 success:^(id obj) {
        NSDictionary *pathDic = obj;
        DLog(@"%@",pathDic);
        if ([pathDic objectForKey:@"status"]) {
            NSString *pathStr = [pathDic objectForKey:@"path"];
            [self upImageDataURL:pathStr withHUD:hud];
            
        }else {
            [hud setMode:MBProgressHUDModeCustomView];
            [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_ERROR]];
            [hud setLabelText:@"上传照片失败"];
            [hud hide:YES afterDelay:1.0];
            [selectImage setImage:nil];
        }
    } uploadProgress:^(NSString *progress) {
        [hud setLabelText:[NSString stringWithFormat:@"%@%@",progress,@"%"]];
        [hud setProgress:([progress floatValue]/100)];
        
    } fail:^(id obj) {
        [hud setMode:MBProgressHUDModeCustomView];
        [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_ERROR]];
        [hud setLabelText:@"上传照片失败"];
        [hud hide:YES afterDelay:1.0];
        [selectImage setImage:nil];
    }];
    
}

- (void)upImageDataURL:(NSString*)pathStrURL withHUD:(MBProgressHUD*)hud
{
    NSMutableDictionary *reqstDicM = [NSMutableDictionary dictionary];
    [reqstDicM setObject:[[NSUserDefaults standardUserDefaults] objectForKey:@"userID"] forKey:@"userId"];
    if (selectImage == cardIDup) {
        [reqstDicM setObject:@"image_cardFront" forKey:@"type"];
        [reqstDicM setObject:pathStrURL forKey:@"cardFront"];
    }else if (selectImage == cardIDdown) {
        [reqstDicM setObject:@"image_cardBack" forKey:@"type"];
        [reqstDicM setObject:pathStrURL forKey:@"cardBack"];
    }else if (selectImage == driveCard) {
        [reqstDicM setObject:@"image_drivelicense" forKey:@"type"];
        [reqstDicM setObject:pathStrURL forKey:@"drivelicense"];
    }
    
    [HttpManager upImageURL:reqstDicM Success:^(id obj) {
        if ([obj objectForKey:@"succeedMessage"]) {
            [hud setMode:MBProgressHUDModeCustomView];
            [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_SUCCESS]];
            [hud hide:YES afterDelay:1.0];
        }else{
            [hud setMode:MBProgressHUDModeCustomView];
            [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_ERROR]];
            [hud setLabelText:[obj objectForKey:@"errorMessage"]];
            [hud hide:YES afterDelay:1.0];
            [selectImage setImage:nil];
            
        }
        
    } fail:^(id obj) {
        [hud setMode:MBProgressHUDModeCustomView];
        [hud setCustomView:[[UIImageView alloc] initWithImage:IOS6HUD_IMAGE_ERROR]];
        [hud hide:YES afterDelay:1.0];
        [selectImage setImage:nil];
    }];

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
                UIImage *imageCamera = nil;
                
                if (selectImage==cardIDup) {
                    imageCamera = [UIImage imageNamed:@"shenfengzheng1"];
                }else if(selectImage == cardIDdown){
                    imageCamera = [UIImage imageNamed:@"shenfengzheng2"];
                }else if(selectImage==driveCard) {
                    imageCamera = [UIImage imageNamed:@"jiashizheng"];
                }
                
                UIImageView *cameraImage = [[UIImageView alloc] initWithImage:imageCamera];
                [cameraImage setCenter:imagePicker.view.center];
                [cameraImage setAutoresizingMask:UIViewAutoresizingFlexibleLeftMargin|UIViewAutoresizingFlexibleRightMargin|UIViewAutoresizingFlexibleTopMargin|UIViewAutoresizingFlexibleBottomMargin];
                [imagePicker setCameraOverlayView:cameraImage];
                [self.customPIMVC presentViewController:imagePicker animated:YES completion:^{
                    
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
                [popoVC  presentPopoverFromRect:selectImage.frame inView:selectImage.superview permittedArrowDirections:UIPopoverArrowDirectionAny animated:YES];
                
            }else {
                
            }
            
        }
        
    }else if (actionSheet.tag==222)
    {

        if (buttonIndex==0) {  // 删除图片
            [selectImage setImage:nil];
            MBProgressHUD *hud = [MBProgressHUD showHUDAddedTo:selectImage.superview animated:YES];
            [hud setMode:MBProgressHUDModeAnnularDeterminate];
            [self upImageDataURL:@"" withHUD:hud];
        }
    }
}


- (void)imagePickerController:(UIImagePickerController *)picker didFinishPickingMediaWithInfo:(NSDictionary *)info
{
    UIImage *image = [info objectForKey:UIImagePickerControllerOriginalImage];
    [selectImage setImage:image];
    if (picker.sourceType==UIImagePickerControllerSourceTypePhotoLibrary) {
        
        [popoVC dismissPopoverAnimated:YES];
    }else{
        [picker dismissViewControllerAnimated:YES completion:^{
            
        }];
        // 保存图片到相册，调用的相关方法，查看是否保存成功
        [_alassets saveImage:image toAlbum:@"客户证件" withCompletionBlock:^(NSError *error) {
            if (error == nil){
                [ProgressHUD showSuccess:@"保存至相册成功"];
            } else {
                [ProgressHUD showSuccess:@"保存至相册失败"];
            }
        }];
    }
    
    [self uploadImage];
    
}


- (void)imagePickerControllerDidCancel:(UIImagePickerController *)picker
{
    [picker dismissViewControllerAnimated:YES completion:^{
        
    }];
}




#pragma mark - tableviewdelegate
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}

- (UITableViewCell*)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *cellid = @"cellid";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:cellid];
    UILabel *titLabel = nil;
    if (cell==nil) {
        cell =[[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:nil];
        [cell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [cell.textLabel setTextColor:[UIColor darkGrayColor]];
        [cell.textLabel setFont:KFont18];
        titLabel = [[UILabel alloc] initWithFrame:CGRectMake(120, 0, 600, 60)];
        [titLabel setFont:KFont18];
        [cell.contentView addSubview:titLabel];
    }
    [cell.textLabel setText:_dataArray[indexPath.row]];
    switch (indexPath.row) {
        case 0:
            [titLabel setText:userVoModel.source];
            break;
        case 1:
            [titLabel setText:userVoModel.qq];
            break;
        case 2:
            [titLabel setText:userVoModel.weixin];
            break;
        case 3:
            [titLabel setText:userVoModel.email];
            break;
        case 4:
            [titLabel setText:userVoModel.wirePhone];
            break;
        case 5:
            [titLabel setText:userVoModel.birthday];
            break;
        case 6:
            [titLabel setText:userVoModel.ageGroupName];
            break;
        case 7:
            [titLabel setText:userVoModel.cardNumber];
            break;
        case 8:
            [titLabel setText:userVoModel.addressName];
            break;
        default:
            break;
    }
    
    return cell;
}


@end
