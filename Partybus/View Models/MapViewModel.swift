//
//  MapViewModel.swift
//  Partybus
//
//  Created by Brendan Conron on 11/16/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import Foundation
import ReactiveSwift

// TODO: Rename this entire class cluster: https://trello.com/b/mY9VZ8Qw/ios

struct MapViewModel: MapViewModelProtocol {

    let routes = MutableProperty<[Route]>([])

}
