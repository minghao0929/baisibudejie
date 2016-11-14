#import <UIKit/UIKit.h>

typedef enum{
    JMHTopicTypeAll = 1,
    JMHTopicTypePicture = 10,
    JMHTopicTypeWord = 29,
    JMHTopicTypeVoice = 31,
    JMHTopicTypeVideo = 41
} JMHTopicType;

UIKIT_EXTERN CGFloat const JMHTopicCellMargin;
UIKIT_EXTERN CGFloat const JMHTitilesViewH;
UIKIT_EXTERN CGFloat const JMHTitilesViewY;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const XMGTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const JMHTopicCellPictureBreakH;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const JMHUserSexMale;
UIKIT_EXTERN NSString * const JMHUserSexFemale;
