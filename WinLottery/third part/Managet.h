//
//  Managet.h
//  calculator
//
//  Created by jiangzheng on 14-7-27.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Managet : NSObject
/**
 * 圆形磁铁表磁计算公式mm version
 * 英寸计算：1英寸=25.4mm
 * @param Z(X) 磁感应距离 (mm) 磁感应距离是磁铁与被磁化的距离，表磁可以设置为0
 * @param D 磁铁直径 (mm)
 * @param L 磁铁长度 (mm)
 * @param Br 剩磁Br(Gauss)magnet
 * @return 返回高斯
 */
+(double)calcylinderByBr:(double)Z :(double)D :(double)L :(double)Br;
+(double)getMaxCylinderByBr:(double)Z :(double)D :(double)L :(double)Br;
/**
 * 方形磁铁磁力计算
 * 英寸计算：1英寸=25.4mm
 * @param X 磁感应距离 (mm)(磁感应距离，表磁距离是0)
 * @param width 磁铁长度(mm)
 * @param depth 磁铁宽度(mm)
 * @param height 磁铁高度 (mm) 充磁方向
 * @param Brem 剩磁Br (Gauss) magnet
 * @return
 */
+(double)calCube:(double)X :(double)width :(double)depth :(double)height :(double)Brem;
+(double)getMaxCube:(double)X :(double)width :(double)depth :(double)height :(double)Brem;
/**
 * 获取两端点确定的直线上的点的Y值
 * @param x1
 * @param y1
 * @param x2
 * @param y2
 * @param x
 * @return
 */
double getY(double x1,double y1,double x2,double y2,double x);

+(BOOL)validParam:(NSArray*)textArray Num:(NSInteger)num;

+(double)cubeVolumeWithLength:(double)len Width:(double)wid Height:(double)he;
+(double)roundVolumeWithDia:(double)dia Thickness:(double)thick;
+(double)annulusVolumeWithOd:(double)od Id:(double)id_ Thickness:(double)thick;
+(double)tilingVolumeWithOd:(double)od Id:(double)id_ Height:(double)he  Width:(double)wid Thickness:(double)thick Radian:(double)ra;
+(double)calWeightByType:(NSInteger)type Des:(double)des Param:(NSMutableArray*)param;
@end
