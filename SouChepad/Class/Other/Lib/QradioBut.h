//
//  QradioBut.h
//  Athena
//
//  Created by 张艳东 on 14-7-16.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
@class QradioBut;

@protocol QradioButDelegate <NSObject>

@optional

- (void)didSelectedRadioButton:(QradioBut *)radio groupId:(NSString *)groupId;

@end

@interface QradioBut : UIButton {
    NSString                        *_groupId;
    BOOL                            _checked;
    //    id<QRadioButtonDelegate>       _delegate;
}

@property (nonatomic, weak) id<QradioButDelegate> delegate;
@property(nonatomic, copy)NSString            *groupId;
@property(nonatomic, assign)BOOL checked;

/** 按钮所对应的编码 */
@property (copy, nonatomic) NSString *codeStr;

@end
