//
//  Managet.m
//  calculator
//
//  Created by jiangzheng on 14-7-27.
//  Copyright (c) 2014年 jiangzheng. All rights reserved.
//

#import "Managet.h"

@implementation Managet
+(double)calcylinderByBr:(double)Z :(double)D :(double)L :(double)Br{
    double ret = 0;
    @try {
        
        double zj = D / 2;
        double xzxs = 0;
        if(zj<=1.5){
            //xzxs = 0.59;
            xzxs = 0.55;
        }else if(zj>1.5 && zj<=2){
            //xzxs=0.62;
            xzxs = getY(1.5, 0.55, 2, 0.75, zj);
        }else if(zj>2 && zj<=3){
            //xzxs=0.75;
            xzxs = getY(2, 0.75, 3, 0.79, zj);
        }else if(zj>3 && zj<=4.5){
            //xzxs=0.79;
            xzxs = getY(3, 0.79, 4.5, 0.82, zj);
        }else if(zj>4.5 && zj<=5.5){
            //xzxs=0.82;
            xzxs = getY(4.5, 0.82, 5.5, 0.85, zj);
        }else if(zj > 5.5){
            xzxs=0.85;
            //xzxs = getY(5.5, 0.82, 18, 0.62, zj);
        }
        //LogUtil.showPrint("zj="+zj+" xzxs="+xzxs);
        double sc = Br;
        double bj = D / 2;
        double hd = L;
        double ccqd = xzxs*((sc/2)*hd)/sqrt((hd*hd)+(bj*bj));
        ret = ccqd;
        
        
    } @catch (NSException *e) {
        NSLog(@"%@",e);
    }
    return ret;
}
+(double)getMaxCylinderByBr:(double)Z :(double)D :(double)L :(double)Br{
    double ret;
    ret = [ Managet calcylinderByBr:Z :D :L :Br ];
    double tempConst;
    if (D<L*2) {
        tempConst = 1.05;
    }
    else if (D>L*10){
        tempConst = 1.6;
    }
    else{
        tempConst = getY(2*L, 1.05, 10*L, 1.6, D);
    }
    
    return ret*tempConst;
}
+(double)calCube:(double)X :(double)width :(double)depth :(double)height :(double)Brem{
    double ret = 0;
    @try {
        double pi =  M_PI;
        double W = width / 2;
        double De = depth / 2;
        //double Le = height;
        double B7 = De*De + W*W + X*X;
        double B8 = (X / (De*W)) * sqrt(B7);
        double B9 = atan(B8);
        double B10 = De*De + W*W + (X+height)*(X+height);
        double B11 = (X+height)/(De*W);
        double B12 = B11 * sqrt(B10);
        double B13 = atan(B12);
        double B14 = B13 - B9;
        ret = Brem * B14 / pi;
        
        double w = W;
        double h = De;
        double constW = 1;
        double constH = 1;
        if(w > 4){
            constW = 0.91;
        }else if(w>3 && w<=4){
            //constW = 0.87;
            constW = getY(3, 0.87, 4, 0.91, w);
        }else if(w>2.5 && w<=3){
            //constW = 0.84;
            constW = getY(2.5, 0.84, 3, 0.87, w);
        }else if(w>2 && w<=2.5){
            //constW = 0.81;
            constW = getY(2, 0.81, 2.5, 0.84, w);
        }else if(w>1.5 && w<=2){
            //constW = 0.79;
            constW = getY(1.5, 0.75, 2, 0.81, w);
        }else if(w>1 && w<=1.5){
            //constW = 0.75;
            constW = getY(1, 0.75, 1.5, 0.79, w);
        }else if(w>0.5 && w<=1){
            //constW = 0.7;
            constW = getY(0.5, 0.58, 1, 0.75, w);
        }else {
            constW = 0.58;
        }
        
        if(h > 4){
            constH = 0.91;
        }else if(h>3 && h<=4){
            //constH = 0.87;
            constH = getY(3, 0.87, 4, 0.91, h);
        }else if(h>2.5 && h<=3){
            //constH = 0.84;
            constH = getY(2.5, 0.84, 3, 0.87, h);
        }else if(h>2 && h<=2.5){
            //constH = 0.81;
            constH = getY(2, 0.81, 2.5, 0.84, h);
        }else if(h>1.5 && h<=2){
            //constH = 0.79;
            constH = getY(1.5, 0.79, 2, 0.81, h);
        }else if(h>1 && h<=1.5){
            //constH = 0.76;
            constH = getY(1, 0.76, 1.5, 0.79, h);
        }else if(h>0.5 && h<=1){
            //constH = 0.7;
            constH = getY(0.5, 0.58, 1, 0.76, h);
        }else {
            constH = 0.58;
        }
        
        ret = ret * constH * constW;
    } @catch (NSException *e) {
        NSLog(@"%@",e);
    }
    return ret;
}
+(double)getMaxCube:(double)X :(double)width :(double)depth :(double)height :(double)Brem{
    double ret = [ Managet calCube:X :width :depth :height :Brem];
    double tempConst;
    if (width<height*2) {
        tempConst = 1.05;
    }
    else if (width>height*10){
        tempConst = 2;
    }
    else{
        tempConst = getY(2*height, 1.05, 10*height, 2, width);
    }
    
    return ret*tempConst;
}

double getY(double x1,double y1,double x2,double y2,double x){
    double ret = 0;
    @try {
        double k = (y1 - y2) / (x1 - x2);
        double b = y1 - k * x1;
        ret = k * x + b;
    } @catch (NSException *e) {
        // TODO: handle exception
    }
    return ret;
}/*
+(BOOL)validParam:(NSArray*)textArray Num:(NSInteger)num{
    for (UITextField*tf in textArray) {
        float value = [tf.text floatValue];
        num = num-1;
        if (num==0) {
            break;
        }
    }
    return YES;
}*/
+(double)cubeVolumeWithLength:(double)len Width:(double)wid Height:(double)he{
    
    return len*wid*he/1000;
}
+(double)roundVolumeWithDia:(double)dia Thickness:(double)thick{
    return pow(dia/2,2)*M_PI*thick/1000;
}
+(double)annulusVolumeWithOd:(double)od Id:(double)id_ Thickness:(double)thick{
    return (pow(od/2, 2)-pow(id_/2, 2))*M_PI*thick/1000;
}
+(double)tilingVolumeWithOd:(double)od Id:(double)id_ Height:(double)he Width:(double)wid Thickness:(double)thick Radian:(double)ra{
    if (od==0) {
        return 0;
    }
    else{
        if (ra>0) {
            return ra*M_PI*od/180*(od-id_)*he/1000;
        }
        else{
            if (od == id_) {
                return asin(wid/2/od)*M_PI*od*thick*he/1000;
            }
            else{
                return asin(wid/2/od)*M_PI*od*(od-id_)*he/1000;
            }
        }
    }
}
+(double)calWeightByType:(NSInteger)type Des:(double)des Param:(NSMutableArray*)param{
    double volume;
    switch (type) {
        case 0:
        {            //方形
            double l,w,h;
            l = [[((UITextField*)[param objectAtIndex:0]) text] doubleValue];
            w= [[((UITextField*)[param objectAtIndex:1]) text] doubleValue];
            h = [[((UITextField*)[param objectAtIndex:2]) text] doubleValue];
            volume = [Managet cubeVolumeWithLength:l Width:w Height:h];
            break;
        }
        case 1:
        {            //圆形
            double l,w;
            l = [[((UITextField*)[param objectAtIndex:0]) text] doubleValue];
            w= [[((UITextField*)[param objectAtIndex:1]) text] doubleValue];
            volume = [Managet roundVolumeWithDia:l Thickness:w];
            break;
        }
        case 2:
        {            //环形
            double l,w,h;
            l = [[((UITextField*)[param objectAtIndex:0]) text] doubleValue];
            w= [[((UITextField*)[param objectAtIndex:1]) text] doubleValue];
            h = [[((UITextField*)[param objectAtIndex:2]) text] doubleValue];
            volume = [Managet annulusVolumeWithOd:l Id:w Thickness:h];
            break;
        }
        default:
        {            //瓦形
            double o,i,h,w,t,m;
            o = [[((UITextField*)[param objectAtIndex:0]) text] doubleValue];
            i= [[((UITextField*)[param objectAtIndex:1]) text] doubleValue];
            h = [[((UITextField*)[param objectAtIndex:2]) text] doubleValue];
            w = [[((UITextField*)[param objectAtIndex:3]) text] doubleValue];
            t= [[((UITextField*)[param objectAtIndex:4]) text] doubleValue];
            m = [[((UITextField*)[param objectAtIndex:5]) text] doubleValue];
            volume = [Managet tilingVolumeWithOd:o Id:i Height:h Width:w Thickness:t Radian:m];
            break;
        }
    }
    return volume*des;
}
@end
