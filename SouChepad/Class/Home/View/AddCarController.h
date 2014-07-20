//
//  AddCarController.h
//  Athena
//
//  Created by 张艳东 on 14-7-16.
//  Copyright (c) 2014年 souche. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "QradioBut.h"
#import "ColoerBut.h"

@class AddCarController;

@protocol AddCarControllerDelegate <NSObject>

- (void)addCarCotrollerDismiss:(AddCarController *)addCarVC;

@end


@interface AddCarController : UIViewController <UITextFieldDelegate>

@property (nonatomic, weak) id<AddCarControllerDelegate> delegate;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@property (weak, nonatomic) IBOutlet ColoerBut *AColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *BColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *CColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *DColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *EColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *FColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *GColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *HColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *IColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *JColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *KColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *LColoerBut;

@property (weak, nonatomic) IBOutlet ColoerBut *MColoerBut;

@property (strong, nonatomic) NSArray *coloerArray;

/**
 *  车型车系
 */
@property (weak, nonatomic) IBOutlet UITextField *carTypeText;


@property (nonatomic, strong) NSArray *rankArray;
/**
 *  1.0L
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankOneButton;
/**
 *  1.1L-1.6L
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankTwoButton;

/**
 *  1.6L-2.0L
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankThreeButton;

/**
 *  2.0L-2.5L
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankFourButton;

/**
 *  2.5L-3.0L
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankFiveButton;

/**
 *  3.0L-4.0L
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankSixButton;
/**
 *  4.0L以上
 */
@property (weak, nonatomic) IBOutlet QradioBut *rankSevenButton;


/**
 *  自动档
 */
@property (weak, nonatomic) IBOutlet QradioBut *speedAutomaticBut;

/**
 *  手动挡
 */
@property (weak, nonatomic) IBOutlet QradioBut *speedManuaBut;

/**
 *  需求强
 */
@property (weak, nonatomic) IBOutlet QradioBut *demandStrongButton;
/**
 *  需求中
 */
@property (weak, nonatomic) IBOutlet QradioBut *demandModeraButton;

/**
 *  需求弱
 */
@property (weak, nonatomic) IBOutlet QradioBut *demandWeakButton;

/**
 *  备注
 */
@property (weak, nonatomic) IBOutlet UITextView *remarkTextView;

@end
