//  Direction.h

#import <Foundation/Foundation.h>

@interface Direction : NSObject <NSCoding> {
    NSString* _tag;
	NSString* _title;
	NSMutableArray* _stops;
}

@property (nonatomic,retain) NSString* tag;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,readonly) NSMutableArray* stops;

@end
