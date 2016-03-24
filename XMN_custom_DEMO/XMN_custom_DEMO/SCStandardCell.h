//
//  SCStandardCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/24.
//  Copyright © 2015年 soon. All rights reserved.
//

/**
 *      标准cell
 *      左侧title 右侧箭头/label
 */

#import <UIKit/UIKit.h>

@interface SCStandardCell : UITableViewCell

@property (nonatomic) UILabel * CustomTileLabel;

@property (nonatomic) UIImageView * symbolImageView;

@property (nonatomic) UILabel * rightLabel;

- (void)setCellWithTitle:(NSString *)title DetailText:(NSString *)text imageName:(NSString *)imageName;

@end
