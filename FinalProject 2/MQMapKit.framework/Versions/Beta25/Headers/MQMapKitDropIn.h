/*
 *  MQMapKitDropIn.h
 *  MQMapKit
 *
 *  Created by heinrich953 on 21-04-2011.
 *  Copyright 2011 MapQuest. All rights reserved.
 *
 */

// define _useMapquestLib_=0 to switch off translation
//#ifndef _useMapquestLib_ 
    // Use MQ (MapQuestKit)

    // Classes
    #define MKMapView                   MQMapView
    #define MKOverlay                   MQOverlay
    #define MKOverlayView               MQOverlayView
    #define MKAnnotationView            MQAnnotationView
    #define MKPinAnnotationView         MQPinAnnotationView
    #define MKReverseGeocoder           MQReverseGeocoder
    #define MKPlacemark                 MQPlacemark
    #define MKAnnotation                MQAnnotation
    #define MKPointAnnotation           MQPointAnnotation
    #define MKUserLocation              MQUserLocation
    #define MKPointAnnotation           MQPointAnnotation
    #define MKShape                     MQShape
    #define MKPolygon                   MQPolygon
    #define MKMultiPoint                MQMultiPoint
    #define MKPolyline                  MQPolyLine
    #define MKCircle                    MQCircle
    #define MKPolygonView               MQPolygonView
    #define MKPolylineView              MQPolylineView
    #define MKOverlayPathView           MQOverlayPathView
    #define MKCircleView                MQCircleView

    // Protocols
    #define MKReverseGeocoderDelegate   MQReverseGeocoderDelegate
    #define MKMapViewDelegate           MQMapViewDelegate

    // typedefs
    #define MKMapType                   MQMapType
    #define MKMapPoint                  MQMapPoint
    #define MKMapSize                   MQMapSize
    #define MKMapRect                   MQMapRect
    #define MKZoomScale                 MQZoomScale
    #define MKCoordinateRegion          MQCoordinateRegion
    #define MKCoordinateSpan            MQCoordinateSpan
    #define MKPinAnnotationColor        MQPinAnnotationColor
    #define MKPinAnnotationColorRed     MQPinAnnotationColorRed
    #define MKPinAnnotationColorGreen   MQPinAnnotationColorGreen
    #define MKPinAnnotationColorPurple  MQPinAnnotationColorPurple
    #define MKAnnotationViewDragState   MQAnnotationViewDragState

    // Functions
    #define MKMapRectMake               MQMapRectMake
    #define MKMapPointMake              MQMapPointMake
    #define MKMapSizeMake               MQMapSizeMake
    #define MKMapPointForCoordinate     MQMapPointForCoordinate
    #define MKCoordinateForMapPoint     MQCoordinateForMapPoint
    #define MKMapRectGetMaxX            MQMapRectGetMaxX
    #define MKMapRectGetMaxY            MQMapRectGetMaxY
    #define MKMapRectGetMinX            MQMapRectGetMinX
    #define MKMapRectGetMinY            MQMapRectGetMinY
    #define MKMapRectGetMidX            MQMapRectGetMidX
    #define MKMapRectGetMidY            MQMapRectGetMidY
    #define MKMapRectGetWidth           MQMapRectGetWidth
    #define MKMapRectGetHeight          MQMapRectGetHeight
    #define MKMapPointEqualToPoint      MQMapPointEqualToPoint
    #define MKMapSizeEqualToSize        MQMapSizeEqualToSize
    #define MKMapRectIntersection       MQMapRectIntersection
    #define MKMapRectIsEmpty            MQMapRectIsEmpty
    #define MKMapRectIsNull             MQMapRectIsNull
    #define MKMapRectIntersectsRect     MQMapRectIntersectsRect
    #define MKMapRectDivide             MQMapRectDivide
    #define MKMapRectContainsRect       MQMapRectContainsRect
    #define MKMapRectContainsPoint      MQMapRectContainsPoint
    #define MKMapRectEqualToRect        MQMapRectEqualToRect
    #define MKCoordinateRegionMake      MQCoordinateRegionMake
    #define MKCoordinateSpanMake        MQCoordinateSpanMake
    #define MKMapRectUnion              MQMapRectUnion
    #define MKMapRectInset              MQMapRectInset
    #define MKMapRectOffset             MQMapRectOffset
    #define MKCoordinateRegionForMapRect    MQCoordinateRegionForMapRect
    #define MKMetersPerMapPointAtLatitude   MQMetersPerMapPointAtLatitude
    #define MKMapPointsPerMeterAtLatitude   MQMapPointsPerMeterAtLatitude
    #define MKMetersBetweenMapPoints    MQMetersBetweenMapPoints
    #define MKStringFromMapPoint        MQStringFromMapPoint
    #define MKStringFromMapSize         MQStringFromMapSize
    #define MKStringFromMapRect         MQStringFromMapRect
    #define MKMapRectSpans180thMeridian MQMapRectSpans180thMeridian
    #define MKMapRectRemainder          MQMapRectRemainder
    #define MKRoadWidthAtZoomScale      MQRoadWidthAtZoomScale

    // Globals
    #define MKMapSizeWorld              MQMapSizeWorld
    #define MKMapRectWorld              MQMapRectWorld
    #define MKMapRectNull               MQMapRectNull


    // enums
    #define MKAnnotationViewDragStateNone       MQAnnotationViewDragStateNone
    #define MKAnnotationViewDragStateStarting   MQAnnotationViewDragStateStarting
    #define MKAnnotationViewDragStateDragging   MQAnnotationViewDragStateDragging
    #define MKAnnotationViewDragStateCanceling  MQAnnotationViewDragStateCanceling
    #define MKAnnotationViewDragStateEnding     MQAnnotationViewDragStateEnding
    #define MKMapTypeStandard           MQMapTypeStandard
    #define MKMapTypeSatellite          MQMapTypeSatellite
    #define MKMapTypeHybrid             MQMapTypeHybrid
    #define MKErrorCode                 MQErrorCode
    #define MKErrorUnknown              MQrrorUnknown
    #define MKErrorServerFailure        MQErrorServerFailure
    #define MKErrorLoadingThrottled     MQErrorLoadingThrottled
    #define MKErrorPlacemarkNotFound    MQErrorPlacemarkNotFound


//#endif
