//
//  UIImage+Utility.h
//  Pods
//
//  Created by justzt on 6/2/13.
//
//

#import <UIKit/UIKit.h>

@interface UIImage (Utility)
- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;
-(UIImage*)scaledToWidth: (float) i_width;
//等比例缩放
-(UIImage*)scaleToSize:(CGSize)size;
/**
 *  根据url下载图片并且设定大小，然后制定给UIImageView
 */
-(void)setImageWithUrl:(NSString*)url scaleToSize:(CGSize)size forImageView:(UIImageView*)imgView;
@end
