//  Route.h

#import <Foundation/Foundation.h>

@class Stop;
@class Direction;

@interface Route : NSObject <NSCoding> {
    NSString* _tag;
	NSString* _title;
	NSMutableDictionary* _stopsByTag;
	NSMutableDictionary* _directionsByTag;
}

@property (nonatomic,retain) NSString* tag;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,readonly) NSMutableDictionary* stopsByTag;
@property (nonatomic,readonly) NSMutableDictionary* directionsByTag;
@property (nonatomic,readonly) NSArray* directions;

- (void) addStop: (Stop*) stop;
- (void) addDirection: (Direction*) direction;

@end
