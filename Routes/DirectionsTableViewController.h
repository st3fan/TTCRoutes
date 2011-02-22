// DirectionsTableViewController.h

#import <UIKit/UIKit.h>

@class Route;

@interface DirectionsTableViewController : UITableViewController {
    Route* _route;
}

- (id)initWithRoute: (Route*) route;

@end
