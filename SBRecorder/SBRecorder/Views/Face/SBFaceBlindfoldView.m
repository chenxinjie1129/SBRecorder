//
//  SBFaceCatGlassesView.m
//  SBRecorder
//
//  Created by qyb on 2018/2/25.
//  Copyright © 2018年 qyb. All rights reserved.
// 萌眼镜

#import "SBFaceBlindfoldView.h"
#define SBFaceOffset 1

@interface SBFaceBlindfoldView()
@property (nonatomic,readwrite) UIImageView *faceHeadView;
@end

@implementation SBFaceBlindfoldView
- (UIImageView *)faceHeadView{
    if (_faceHeadView == nil) {
        _faceHeadView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, ScreenWidth*1.7, 200)];
        _faceHeadView.image = [UIImage imageNamed:@"眼罩"];
        [self addSubview:_faceHeadView];
    }
    return _faceHeadView;
}
- (void)drawFaceView:(NSArray *)faces{
    if (faces.count == 1) {
        @autoreleasepool{
            NSDictionary *dicPerson = faces.firstObject;
            CGRect rect = CGRectFromString([dicPerson objectForKey:kFaceRectKey]);
            CGFloat scale = rect.size.width/ScreenWidth;
            //            CGFloat space = 40*scale;
            NSArray * strPoints = [dicPerson objectForKey:kFacePointsKey];
            //右边鼻孔
            CGPoint strPoint1 = CGPointFromString(((NSString *)strPoints[2]));
            //左边鼻孔
            CGPoint  strPoint2 = CGPointFromString(((NSString *)strPoints[15]));
            //右边嘴角
            CGPoint  strPoint3 = CGPointFromString(((NSString *)strPoints[5]));
            //左边嘴角
            CGPoint strPoint4 = CGPointFromString(((NSString *)strPoints[20]));
            double rotation = atan((strPoint3.x+strPoint4.x -strPoint1.x - strPoint2.x)/(strPoint3.y +strPoint4.y - strPoint1.y - strPoint2.y));
            
            
            CGPoint  eyebrowsPoint1 = CGPointFromString(((NSString *)strPoints[14]));
            
            CGPoint  eyebrowsPoint3 = CGPointFromString(((NSString *)strPoints[1]));
            CGPoint rectCenterPoint = CGPointMake((eyebrowsPoint1.x+eyebrowsPoint3.x)/2+SBFaceOffset, (eyebrowsPoint1.y+eyebrowsPoint3.y)/2+10*scale);
            
            self.faceHeadView.center = rectCenterPoint;
            self.faceHeadView.transform = CGAffineTransformMakeRotation(-rotation);
            self.faceHeadView.transform = CGAffineTransformScale(self.faceHeadView.transform,scale,scale);
        }
    }
}

@end

