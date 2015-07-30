//
//  WMUserDataObject.m
//  My-Watch-New
//
//  Created by maginawin on 15/7/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import "WMUserDataObject.h"

NSString * const kUserDataMetricBritishSystem = @"kUserDataMetricBritishSystem";
NSString * const kUserDataBindingMacAddress = @"kUserDataBindingMacAddress";
NSString * const kUserDataStride = @"kUserDataStride";
NSString * const kUserDataHeight = @"kUserDataHeight";
NSString * const kUserDataWeight = @"kUserDataWeight";
NSString * const kUserDataAge = @"kUserDataAge";
NSString * const kUserDataGender = @"kUserDataGender";

@implementation WMUserDataObject

+ (BOOL)metricBritishSystem {
    BOOL value = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDataMetricBritishSystem];

    return value;
}

+ (void)setMetricBritishSystem:(BOOL)value {
    [[NSUserDefaults standardUserDefaults] setBool:value forKey:kUserDataMetricBritishSystem];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)bindingMacAddress {
    NSString *value = [[NSUserDefaults standardUserDefaults] stringForKey:kUserDataBindingMacAddress];
    if (!value) {
        value = @"";
    }
    return value;
}

+ (void)setBindingMacAddress:(NSString *)value {
    [[NSUserDefaults standardUserDefaults] setValue:value forKey:kUserDataBindingMacAddress];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)stride {
    int stride = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kUserDataStride];
    
    if (!stride) {
        stride = 60;
    }
    
    return stride;
}

+ (void)setStride:(int)stride {
    [[NSUserDefaults standardUserDefaults] setInteger:stride forKey:kUserDataStride];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)strideUnit {
    if (![self metricBritishSystem]) {
        return NSLocalizedString(@"cm", @"");
    }
    
    return NSLocalizedString(@"inch", @"");
}

+ (int)height {
    int height = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kUserDataHeight];
    
    if (!height) {
        height = 175;
    }
    
    return height;
}

+ (void)setHeight:(int)height {
    [[NSUserDefaults standardUserDefaults] setInteger:height forKey:kUserDataHeight];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (int)weight {
    int weight = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kUserDataWeight];
    
    if (!weight) {
        weight = 65;
    }
    
    return weight;
}

+ (void)setWeight:(int)weight {
    [[NSUserDefaults standardUserDefaults] setInteger:weight forKey:kUserDataWeight];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)weightUnit {
    if (![self metricBritishSystem]) {
        return NSLocalizedString(@"kg", @"kg");
    }
    
    return NSLocalizedString(@"pound", @"lb");
}

+ (int)age {
    int age = (int)[[NSUserDefaults standardUserDefaults] integerForKey:kUserDataAge];
    
    if (!age) {
        age = 22;
    }
    return age;
}

+ (void)setAge:(int)age {
    [[NSUserDefaults standardUserDefaults] setInteger:age forKey:kUserDataAge];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (BOOL)gender {
    BOOL gender = [[NSUserDefaults standardUserDefaults] boolForKey:kUserDataGender];
    
    return gender;
}

+ (void)setGender:(BOOL)gender {
    [[NSUserDefaults standardUserDefaults] setBool:gender forKey:kUserDataGender];
    [[NSUserDefaults standardUserDefaults] synchronize];
}

+ (NSString *)inchFromCm:(NSString *)cm {
    int inch = ceil(cm.intValue / 2.54);
    return [NSString stringWithFormat:@"%d", inch];
}

+ (NSString *)cmFromInch:(NSString *)inch {
    int cm = floor(inch.intValue * 2.54);
    return [NSString stringWithFormat:@"%d", cm];
}

+ (NSString *)kgFromLb:(NSString *)lb {
    int kg = ceil(lb.intValue / 2.205);
    return [NSString stringWithFormat:@"%d", kg];
}

+ (NSString *)lbFromKg:(NSString *)kg {
    int lb = floor(kg.intValue * 2.205);
    return [NSString stringWithFormat:@"%d", lb];
}

@end
