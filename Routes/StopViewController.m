//  StopViewController.m

#import "StopViewController.h"
#import "Stop.h"

@implementation StopViewController

@synthesize mapView = _mapView;

- (id) initWithStop: (Stop*) stop;
{
    if ((self = [super initWithNibName: nil bundle: nil]) != nil) {
        _stop = [stop retain];
    }
    return self;
}

- (void)dealloc
{
	[_stop release];
    [super dealloc];
}

#pragma mark -

- (void) viewDidLoad
{
	_mapView.delegate = self;
}

- (void) viewDidAppear:(BOOL)animated
{
	CLLocationCoordinate2D location = _stop.location;
	MKCoordinateSpan span = MKCoordinateSpanMake(0.05, 0.05);
	MKCoordinateRegion region = MKCoordinateRegionMake(location, span);

	[_mapView setRegion: region animated: TRUE];
	[_mapView regionThatFits: region];
}

#pragma mark -

- (void) mapView:(MKMapView *)mapView regionDidChangeAnimated:(BOOL)animated
{
	if (_didAddAnnotation == NO) {
		CLLocationCoordinate2D location = _stop.location;
		MKPlacemark* placemark = [[[MKPlacemark alloc] initWithCoordinate: location addressDictionary: nil] autorelease];
		[_mapView addAnnotation: placemark];
		_didAddAnnotation = YES;
	}
}

- (MKAnnotationView *) mapView:(MKMapView *)mapView viewForAnnotation:(id <MKAnnotation>) annotation
{
	MKPinAnnotationView* annotationView = [[[MKPinAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier: @"currentloc"] autorelease];
	if (annotationView != nil) {
		annotationView.animatesDrop = YES;
	}
	return annotationView;
}

@end
