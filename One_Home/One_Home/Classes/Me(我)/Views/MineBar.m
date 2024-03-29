//
//  MineBar.m
//  One_Home
//
//  Created by hanxiaocu on 15-10-19.
//  Copyright (c) 2015年 hanxiaocu. All rights reserved.
//

#import "MineBar.h"

@implementation MineBar

- (instancetype)initWithFrame:(CGRect)frame
{
    if ( self = [super initWithFrame:frame]) {
        
        [self configureBar];
    }
    return self;
}


- (void)configureBar
{
    // Configure bar appearence
    self.maximumBarHeight = self.bounds.size.height;
    self.minimumBarHeight = 64.0;
    
    
    // Add and configure name label
    UILabel *nameLabel = [[UILabel alloc] init];
    nameLabel.font = [UIFont systemFontOfSize:18.0];
    nameLabel.textColor = [UIColor whiteColor];
    nameLabel.text = @"韩小醋";
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialNameLabelLayoutAttributes.size = [nameLabel sizeThatFits:CGSizeZero];
    
    initialNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.maximumBarHeight - 30.0);
    //最大的时候0.0
    [nameLabel addLayoutAttributes:initialNameLabelLayoutAttributes forProgress:0.0];
    
    
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialNameLabelLayoutAttributes];
    midwayNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight - self.minimumBarHeight)*0.5-60.0);
    [nameLabel addLayoutAttributes:midwayNameLabelLayoutAttributes forProgress:0.5];
    
    
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalNameLabelLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayNameLabelLayoutAttributes];
    finalNameLabelLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.minimumBarHeight / 2 + 10 );
    //最小的时候1.0
    [nameLabel addLayoutAttributes:finalNameLabelLayoutAttributes forProgress:1.0];
    
    self.backgroundColor = [UIColor blackColor];
    [self addSubview:nameLabel];

    // Add and configure profile image
    UIImageView *profileImageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"mine"]];
    profileImageView.contentMode = UIViewContentModeScaleAspectFill;
    profileImageView.clipsToBounds = YES;
    profileImageView.layer.cornerRadius = 35.0;
    profileImageView.layer.borderWidth = 2.0;
    profileImageView.layer.borderColor = [UIColor whiteColor].CGColor;
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *initialProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] init];
    initialProfileImageViewLayoutAttributes.size = CGSizeMake(70.0, 70.0);
    initialProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, self.maximumBarHeight-80.0);
    [profileImageView addLayoutAttributes:initialProfileImageViewLayoutAttributes forProgress:0.0];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *midwayProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:initialProfileImageViewLayoutAttributes];
    midwayProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.8+self.minimumBarHeight-100.0);
    [profileImageView addLayoutAttributes:midwayProfileImageViewLayoutAttributes forProgress:0.2];
    
    BLKFlexibleHeightBarSubviewLayoutAttributes *finalProfileImageViewLayoutAttributes = [[BLKFlexibleHeightBarSubviewLayoutAttributes alloc] initWithExistingLayoutAttributes:midwayProfileImageViewLayoutAttributes];
    finalProfileImageViewLayoutAttributes.center = CGPointMake(self.frame.size.width*0.5, (self.maximumBarHeight-self.minimumBarHeight)*0.64+self.minimumBarHeight-120.0);
    finalProfileImageViewLayoutAttributes.transform = CGAffineTransformMakeScale(0.5, 0.5);
    finalProfileImageViewLayoutAttributes.alpha = 0.0;
    [profileImageView addLayoutAttributes:finalProfileImageViewLayoutAttributes forProgress:0.5];
    
    [self addSubview:profileImageView];
    
}

@end
