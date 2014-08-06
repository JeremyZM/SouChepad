//
//  NSString+val.m
//  WTInternship
//
//  Created by gh on 13-7-9.
//  Copyright (c) 2013年 Wanting3. All rights reserved.
//

#import "NSString+val.h"
#import "ProgressHUD.h"

@implementation NSString(val)
+ (BOOL)phoneValidate:(NSString *)phoneNum{
    
    /**
     * 手机号码
     * 移动：134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     * 联通：130,131,132,152,155,156,185,186
     * 电信：133,1349,153,180,189
     */
    NSString * MOBILE = @"^1(3[0-9]|5[0-9]|8[0-9])\\d{8}$";
    /**
     10         * 中国移动：China Mobile
     11         * 134[0-8],135,136,137,138,139,150,151,157,158,159,182,187,188
     12         */
    NSString * CM = @"^1(34[0-8]|(3[5-9]|5[017-9]|8[278])\\d)\\d{7}$";
    /**
     15         * 中国联通：China Unicom
     16         * 130,131,132,152,155,156,185,186
     17         */
    NSString * CU = @"^1(3[0-2]|5[256]|8[56])\\d{8}$";
    /**
     20         * 中国电信：China Telecom
     21         * 133,1349,153,180,189
     22         */
    NSString * CT = @"^1((33|53|8[09])[0-9]|349)\\d{7}$";
    /**
     25         * 大陆地区固话及小灵通
     26         * 区号：010,020,021,022,023,024,025,027,028,029
     27         * 号码：七位或八位
     28         */
    // NSString * PHS = @"^0(10|2[0-5789]|\\d{3})\\d{7,8}$";
    
    NSPredicate *regextestmobile = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", MOBILE];
    NSPredicate *regextestcm = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CM];
    NSPredicate *regextestcu = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CU];
    NSPredicate *regextestct = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", CT];
    
    if (([regextestmobile evaluateWithObject:phoneNum] == YES)
        || ([regextestcm evaluateWithObject:phoneNum] == YES)
        || ([regextestct evaluateWithObject:phoneNum] == YES)
        || ([regextestcu evaluateWithObject:phoneNum] == YES))
    {
        return YES;
    }
    else
    {
        [ProgressHUD showError:@"请输入正确的手机号"];
        return NO;
    }
    return YES;

}
//以字母开头，只能包含“字母”，“数字”，“下划线”，长度6~15
+ (BOOL)passwordValidate:(NSString *)password{
    
    NSString *pwdRegex = @"^([a-zA-Z]|[a-zA-Z0-9_]|[0-9]){5,14}$";
    NSPredicate *pwdTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",pwdRegex];
    DLog(@"%d",[pwdTest evaluateWithObject:password]);
    return [pwdTest evaluateWithObject:password];
}
//数字开头，长度7~11
+ (BOOL)studentNumberValidate:(NSString *)number{
    
    NSString *numberRe = @"^[0-9]{6,19}";
    NSPredicate *numberTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",numberRe];
    DLog(@"%d",[numberTest evaluateWithObject:number]);
    return [numberTest evaluateWithObject:number];
}
//判断是否为空
+ (BOOL)stringLeng:(NSString *)str{
    
    if (str.length == 0 || str == nil) {
        return NO;
    }
    return YES;
}

+ (BOOL)userNameValidate:(NSString *)name{
    
    NSString *nameRegex = @"^\\w{1,18}$";
    NSPredicate *nameTest = [NSPredicate predicateWithFormat:@"SELF MATCHES%@",nameRegex];
    if ([nameTest evaluateWithObject:nameRegex] == 0) {
        [ProgressHUD showError:@"请输入正确的姓名"];
    }
    return [nameTest evaluateWithObject:name];
}
//身份证号
+ (BOOL) validateIdentityCard: (NSString *)identityCard
{
    BOOL flag;
    if (identityCard.length <= 0) {
        flag = NO;
        return flag;
    }
    NSString *regex2 = @"^(\\d{14}|\\d{17})(\\d|[xX])$";
    NSPredicate *identityCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    if ([identityCardPredicate evaluateWithObject:identityCard] == 0) {
        [ProgressHUD showError:@"请输入正确的身份证号"];
    }
    return [identityCardPredicate evaluateWithObject:identityCard];
}

- (void)phoneString:(NSString *)phoneNum
{
    if (![NSString phoneValidate:phoneNum]) {
        [ProgressHUD showError:@"请填写正确的手机号！"];
        return;
    }
}

//邮箱
+ (BOOL)emailValidate:(NSString *)email{
    
    BOOL flag;
    if (email.length <= 0) {
        flag = NO;
        return flag;
    }
    
    NSString *regex2 = @"[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,4}";
    NSPredicate *emailCardPredicate = [NSPredicate predicateWithFormat:@"SELF MATCHES %@",regex2];
    return [emailCardPredicate evaluateWithObject:email];


}
@end
