//
//  MapsViewModel.swift
//  GrainChainExample
//
//  Created by Adrian Dominguez Gómez on 21/03/20.
//  Copyright © 2020 Adrian Dominguez Gómez. All rights reserved.
//

import UIKit
import MapKit
enum typeScreen {
    case recordRoute
    case visualizeRoute
}
class MapsViewModel {
    
    var typeScreen:typeScreen  = .recordRoute
    
        let regionRadius: CLLocationDistance = 200
        var route : Route? = nil
        var initialLocation = CLLocation(latitude: 21.282778, longitude: -157.829444)
     init(){
        route = Route()
    
    }
    func getInitialLocation()-> CLLocation?{
        if route?.pointsRoute.count ?? 0 > 0 {
            return self.getFirsPoint()
        }
        return nil
        
    }
    func getOverlay(overlay:MKOverlay)->MKOverlayRenderer{
        
        let pr = MKPolylineRenderer(overlay: overlay)
                pr.strokeColor =  UIColor.green
                pr.lineWidth = 5
        return pr
    }
    func addRouteInRoutes(){
        
        StorageRoutes.shared.AddCard(route: self.route!)
    }
    func setNameRoute(name:String){
        self.route?.nameRoute = name
    }
    func getRoute() -> MKPolyline?
    {
        if let rout = self.route {
            return rout.getPoligone()
        }
        return nil
    }
    
    func ExistOneLocalization()-> Bool{
        return route?.pointsRoute.count ?? 0 > 0
    }
    func getFirsPoint()-> CLLocation? {
        
        if self.route?.pointsRoute.count ?? 0 > 1 {
            if let element = self.route?.pointsRoute[0] {
                    return element
            }
        }
        return nil
    }
    func getLastPoint()-> CLLocation? {
           
        if self.route!.pointsRoute.count < 2 {
            return nil
        }
        
        if let element = self.route?.pointsRoute[(self.route!.pointsRoute.count )-1] {
                   return element
          
        }
           
           
           return nil
       }
    func addPoint(point:CLLocation){
        self.route?.addPoint(cordinate: point)
        
    }
    
    func getDistance()-> Double {
        return route!.getDistance()
    }
    
    func getDuration() -> Double {
        return route!.getDuration()
    }

    func clearRoute(){
        self.route?.clearRute()
    }
    func getInformation() -> String{
        let time = String(format:"%0.02f minutes",((self.getDuration() ) / 60) )
        return  "Time     : " + time + "\nDistance : " + String(format: "%0.02f meters",self.getDistance() )
    }
}
