//  StopViewController.h

#import <UIKit/UIKit.h>
#import <MapKit/MapKit.h>

@class Stop;

@interface StopViewController : UIViewController <MKMapViewDelegate> {
	Stop* _stop;
    MKMapView* _mapView;
	BOOL _didAddAnnotation;
}

@property (nonatomic,assign) IBOutlet MKMapView* mapView;

- (id) initWithStop: (Stop*) stop;

@end
