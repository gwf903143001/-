//
//  RadioTableViewCell.m
//  RadioDemo
//
//  Created by Conan on 14-12-14.
//  Copyright (c) 2014年 Conan. All rights reserved.
//

#import "RadioTableViewCell.h"
#import "AudioButton.h"
@implementation RadioTableViewCell

-(void)dealloc
{
    
    NSLog(@"电台tableviewCell dealloc-------->");
    _audioButton = nil;
    _titleLabel = nil;
    
    [_audioButton release];
    [_titleLabel release];
    
    [super dealloc];
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        self.titleLabel = [[[UILabel alloc] initWithFrame:CGRectMake(83, 20, 263, 24)] autorelease];
        [self.contentView addSubview:self.titleLabel];
    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)configurePlayerButton
{
    // use initWithFrame to drawRect instead of initWithCoder from xib
    self.audioButton = [[[AudioButton alloc] initWithFrame:CGRectMake(20, 10, 50, 50)] autorelease];
    [self.contentView addSubview:self.audioButton];
}


@end
