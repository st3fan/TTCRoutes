//  Stop.h

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>

@interface Stop : NSObject <NSCoding> {
    NSString* _tag;
    NSString* _title;
	NSString* _stopId;
	CLLocationCoordinate2D _location;
}

@property (nonatomic,retain) NSString* tag;
@property (nonatomic,retain) NSString* title;
@property (nonatomic,retain) NSString* stopId;
@property (nonatomic,assign) CLLocationCoordinate2D location;

@end
