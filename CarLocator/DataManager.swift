//
//  DataManager.swift
//  CarLocator
//
//  Created by DNA on 18/07/2016.
//  Copyright © 2016 jojo. All rights reserved.
//

import Foundation
import CoreLocation

class DataManager {
    static let sharedInstance = DataManager()
    var locations : [CLLocation]
    
    private init() {
        locations = [CLLocation]()
    }
}