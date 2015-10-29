//
//  RadioTableViewCell.h
//  RadioDemo
//
//  Created by Conan on 14-12-14.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import <UIKit/UIKit.h>
@class AudioButton;
@interface RadioTableViewCell : UITableViewCell

@property (retain,nonatomic)AudioButton *audioButton;
@property (retain, nonatomic)UILabel *titleLabel;

- (void)configurePlayerButton;

@end
