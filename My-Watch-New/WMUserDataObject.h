//
//  WMUserDataObject.h
//  My-Watch-New
//
//  Created by maginawin on 15/7/29.
//  Copyright (c) 2015年 wendong wang. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface WMUserDataObject : NSObject

/**
 * @brief 公英制换算标准 (1 inch = 2.54 cm; 1 cm = 0.3937 inch; 1 mile = 1.609 km; 1 km = 0.6214 mile; 1 lb = 0.4536 kg; 1 kg = 2.205 lb)
 * @return 公英制 NO : Metric, YES : British
 */
+ (BOOL)metricBritishSystem;

/** 设置公英制 */
+ (void)setMetricBritishSystem:(BOOL)value;

/** 绑定蓝牙的 Mac 地址 */
+ (NSString *)bindingMacAddress;

/** 设置绑定蓝牙的 Mac 地址 */
+ (void)setBindingMacAddress:(NSString *)value;

/** 步幅 */
+ (int)stride;

/** 设置步幅 */
+ (void)setStride:(int)stride;

/** 步幅单位 */
+ (NSString *)strideUnit;

/** 身高 */
+ (int)height;

/** 设置身高 */
+ (void)setHeight:(int)height;

/** 体重 */
+ (int)weight;

/** 设置体重 */
+ (void)setWeight:(int)weight;

/** 体重单位 */
+ (NSString *)weightUnit;

/** 年龄 */
+ (int)age;

/** 设置年龄 */
+ (void)setAge:(int)age;

/** 性别 NO : Male, YES : Female */
+ (BOOL)gender;

/** 设置性别 */
+ (void)setGender:(BOOL)gender;

+ (NSString *)inchFromCm:(NSString *)cm;

+ (NSString *)cmFromInch:(NSString *)inch;

+ (NSString *)kgFromLb:(NSString *)lb;

+ (NSString *)lbFromKg:(NSString *)kg;

@end
