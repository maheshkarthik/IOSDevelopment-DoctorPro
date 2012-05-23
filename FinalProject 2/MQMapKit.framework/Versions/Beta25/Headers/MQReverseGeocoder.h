//
//  MQReverseGeocoder.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 8/23/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#import "MQPlacemark.h"

@protocol MQReverseGeocoderDelegate;

/**The MQReverseGeocoder utilizes remote services to gather additional information relating to a latitude and longitude. This information, contained in an MQPlacemark instance, typically consists of address information such as street address, city, state, postal code, country, et al. The reverse geocoder runs asynchronously, returning results to a delegate that conforms to the MQReverseGeocoderDelegate protocol.
 *
 * An MQReverseGeocoder instance is a single-use instance. It will run once for one lat/lon, and will retain the information for its lifetime. 
 *@warning The MQReverseGeocoder can operate using either MapQuest commercial services or OSM open services. To use OSM open services, no configuration is required. To use MapQuest commercial reverse geocoding, you must add a line in your application's info.plist file that contains your commercial App Key with the info.plist entry key "MapQuest.Map.Key" .
 */
@interface MQReverseGeocoder : NSObject {
    id<MQReverseGeocoderDelegate>delegate;
}

///The coordinate for which the reverse geocoder will gather information. This cannot be changed after construction.
@property (nonatomic, readonly) CLLocationCoordinate2D coordinate;

///The delegate, conforming to the MQReverseGeocoderDelegate protocol, that will receive success and failure messages.
@property (nonatomic, assign) id<MQReverseGeocoderDelegate> delegate;

///The MQPlacemark instance, if any, resulting from the execution of the reverse geocoder.
@property (nonatomic, readonly) MQPlacemark *placemark;

///A BOOLEAN value indicating if the reverse geocoding is in the middle of processing its coordinate.
@property (nonatomic, readonly, getter=isQuerying) BOOL querying;

/**Constructs a MQReverseGeocoder instance that will use the give coordinate
 *@param coordinate The lat/lon values to use when reverse geocoding.
 *@return a single-use instance of an MQReverseGeocoder that will gather information for its associated coordinate
 */
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate;

/**Cancels the request, if it is in progress. Does nothing if the start method has not been called or if reverse geocoding has been completed.
 */
- (void)cancel;

/**Begins execution of the reverse geocoding process. Does nothing if it has already been called.
 * This is a one-time execution. 
 */
- (void)start;

@end

///The MQReverseGeocoderDelegate recevies success and error messages from the MQReverseGeocoder instance. 
@protocol MQReverseGeocoderDelegate

/**The attempt to reverse geocode failed. 
 *@param geocoder The instance that is sending the failure message to the delegate.
 *@param error An NSError instance containing additional information regarding the failure.
 */
- (void)reverseGeocoder:(MQReverseGeocoder *)geocoder didFailWithError:(NSError *)error;

/**The attemp to reverse geocode succeeded.
 *@param geocoder The instance that is sending the success message to the delegate.
 *@param placemark A populated instance of an MQPlacemark. This instance is retain in the MQReverseGeocoder for its lifetime.
 */
- (void)reverseGeocoder:(MQReverseGeocoder *)geocoder didFindPlacemark:(MQPlacemark *)placemark;
@end