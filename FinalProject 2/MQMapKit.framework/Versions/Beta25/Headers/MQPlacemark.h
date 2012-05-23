//
//  MQPlacemark.h
//  mq_ios_sdk
//
//  Created by Ty Beltramo on 8/23/11.
//  Copyright (c) 2011 MapQuest. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MQAnnotation.h"

/** An MQPlacemark object contains additional data relative to a point on the earth. This information includes address information such as street, city, state, country, county, postal code, et al. Typically, this information is obtained through the use of an MQReverseGeocoder instance. However, MQPlacemarks can be created manually as well. And since they conform to the MQAnnotation protocol, they can be added to maps.
 */
@interface MQPlacemark : NSObject <MQAnnotation>

/**The addressDictionary property contains the address data for the placemark with keys including those found in the ABPersonAddress keys list. Additional information may also be present, such as sublocality name and landmark information.
 *
 */
@property (nonatomic, readonly) NSDictionary *addressDictionary;

///The administratic area. Typically, this is the state-level admin area.
@property (nonatomic, readonly) NSString *administrativeArea;

///Country. The country name. E.g. United States, or USA.
@property (nonatomic, readonly) NSString *country;

///Country Code. The abbreviation for the country, if available. E.g. US for United States, CA for Canada.
@property (nonatomic, readonly) NSString *countryCode;

///Locality. This is typically the city-level admin area. E.g. Detroit.
@property (nonatomic, readonly) NSString *locality;

///Postal code.
@property (nonatomic, readonly) NSString *postalCode;

///subAdministrativeArea. A lower-level admin area, typically associated with the County.
@property (nonatomic, readonly) NSString *subAdministrativeArea;

///subLocality. Neighborhood or local regional name.
@property (nonatomic, readonly) NSString *subLocality;

///subThorougfare. The number portion of the street address.E.g. if the street address were 190 Main St, the subThoroughfare would be "190".
@property (nonatomic, readonly) NSString *subThoroughfare;

//thoroughfare. The street name portion of the street address. E.g. if the street address were 190 Main St, the thoroughfare would be "Main St"
@property (nonatomic, readonly) NSString *thoroughfare;

/**To construct an MQPlacemark instance manually, use this constructor.
 *@param coordinate The latitude and longitude of the location associated with this placemark.
 *@param addressDictionary containing values for keys found in the ABPersonAddress keys list
 */
- (id)initWithCoordinate:(CLLocationCoordinate2D)coordinate addressDictionary:(NSDictionary *)addressDictionary;


@end
