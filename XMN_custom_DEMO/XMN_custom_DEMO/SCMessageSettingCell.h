//
//  SCMessageSettingCell.h
//  XMN_custom_DEMO
//
//  Created by blue on 15/9/28.
//  Copyright © 2015年 soon. All rights reserved.
//

typedef void(^MessageNoticeBlock)(void);

#import <UIKit/UIKit.h>

@interface SCMessageSettingCell : UITableViewCell

@property (nonatomic) UILabel * CustomTileLabel;

@property (nonatomic) UILabel * CustomDetailLabel;

@property (nonatomic) UIImageView * symbolImageView;

- (void)setCellWithTitle:(NSString *)title DetailText:(NSString *)text imageName:(NSString *)imageName NoticeBlock:(MessageNoticeBlock)block;

@end
