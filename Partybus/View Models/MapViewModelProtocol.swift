//
//  MapViewModelProtocol.swift
//  Partybus
//
//  Created by Brendan Conron on 11/17/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import ReactiveSwift

protocol MapViewModelProtocol {

    var routes: MutableProperty<[Route]> { get }
    
}
