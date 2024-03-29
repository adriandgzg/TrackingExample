//
//  StorageRoutes.swift
//  GrainChainExample
//
//  Created by Adrian Dominguez Gómez on 21/03/20.
//  Copyright © 2020 Adrian Dominguez Gómez. All rights reserved.
//

import UIKit
let keyRoutes = "StorageRoutes"
let arrPropertyRoutes = "Routes"
class StorageRoutes :NSObject, NSCoding{
  
    
 
    //create Singleton
    
    static let shared = StorageRoutes()
    
    var arrRoutes : [Route]? = []
    override init(){
       
        if let arr = StorageRoutes.self.loadRoutesSaved()?.arrRoutes {
            self.arrRoutes = arr
        }
    }
    init(arrRoutes:[Route]){
        self.arrRoutes = arrRoutes
    }
    
    required convenience init?(coder: NSCoder) {
         guard  let ArrRoutes = coder.decodeObject(forKey: arrPropertyRoutes ) as? [Route] else
                {
                    self.init(arrRoutes: [])
                    return
                }
                self.init(arrRoutes: ArrRoutes)
     }
    
     func encode(with coder: NSCoder) {
            coder.encode(self.arrRoutes , forKey: arrPropertyRoutes)
       }
       
    
 
       func saveCardsInUserDefaults(){
           let defaults = UserDefaults.standard
        
           if #available(iOS 13, *) {
               // use UICollectionViewCompositionalLayout
              let enrolledCard = try? NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
             defaults.set(enrolledCard, forKey:keyRoutes)
           } else {
               // show sad face emoji
              let EnrolledCards = NSKeyedArchiver.archivedData(withRootObject: self)
             defaults.set(EnrolledCards, forKey:keyRoutes)
           }
          
         
          
       }
  class func loadRoutesSaved()-> StorageRoutes?{
    let defaults = UserDefaults.standard
        guard let StorageRoutes = defaults.object(forKey: keyRoutes) as? Data else {
            return nil
        }
        guard let routesObject = NSKeyedUnarchiver.unarchiveObject(with: StorageRoutes) as? StorageRoutes else {
            return nil
        }
//        print("player name is \(Enrolleds.arrEnrolled.count)")
    return routesObject
    }
    
    func AddCard(route:Route){
        arrRoutes?.append(route)
        
        saveCardsInUserDefaults()
    }
    func Sincronize(){
//        NSKeyedArchiver.archivedData(withRootObject: self)
       
//        NSKeyedArchiver.archivedData(withRootObject: self, requiringSecureCoding: false)
//        guard (try? NSKeyedArchiver.archivedData(withRootObject: self as StorageRoutes, requiringSecureCoding: false) as NSData) != nil
//            else {
//                fatalError("Can't encode data") }
         
        saveCardsInUserDefaults()

    }
   
    
    func exist(cardID:String)-> [Route]{
        return self.arrRoutes ?? []
    }
   
    func deleteCard(index:Int){
        self.arrRoutes?.remove(at: index)
        self.Sincronize()
    }
   
    func clearAllEnrolled(){
        
        self.arrRoutes = []
        self.Sincronize()
    }
    func deleteRouteWith(name:String){
        
        var index = -1
        for route in self.arrRoutes ?? [] {
             index += 1
            if route.nameRoute == name  {
                break
            }
           
        }
        self.arrRoutes?.remove(at: index)
        self.Sincronize()
    }
}
