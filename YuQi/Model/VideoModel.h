

#import <Foundation/Foundation.h>

@interface VideoModel : NSObject

//设置控件属性
@property(nonatomic,copy)NSString *text;          //标题
@property(nonatomic,copy)NSString *videouri;      //视频地址
@property(nonatomic,copy)NSString *playcount;     //播放次数
@property(nonatomic,copy)NSString *created_at;     //创建时间

@property(nonatomic,copy)NSString *image_small;   //播放前/后有图片覆盖;

@property(nonatomic,copy)NSString *love;          //顶
@property(nonatomic,copy)NSString *hate;          //踩

@property(nonatomic,copy)NSString *height;        //高
@property(nonatomic,copy)NSString *width;         //宽

@end
