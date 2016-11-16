//
//  MapViewController.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Mapbox

class MapViewController: UIViewController {

    // MARK: - Views

    @IBOutlet weak var mapView: MGLMapView!

    // MARK: - UIViewController

    override func viewDidLoad() {
        super.viewDidLoad()
        setup()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }

    // MARK: - Setup

    private func setup() {
        self.configureMap()
    }

    private func configureMap() {
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
    }

}
