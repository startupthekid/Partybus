//
//  MapViewController.swift
//  Partybus
//
//  Created by Brendan Conron on 11/15/16.
//  Copyright © 2016 Swoopy Studios. All rights reserved.
//

import UIKit
import Mapbox
import ReactiveSwift

class MapViewController: UIViewController {

    // MARK: - Views

    @IBOutlet weak var mapView: MGLMapView!

    // MARK: - Bindable 

    let stopAnnotations = MutableProperty<[StopAnnotation]>([])
    let routePolylines = MutableProperty<[RoutePolyline]>([])

    // MARK: - Appearance

    private let appearanceProvider: MapViewAppearanceProviding

    // MARK: - Initialization

    init(appearanceProvider: MapViewAppearanceProviding) {
        self.appearanceProvider = appearanceProvider
        super.init(nibName: "MapViewController", bundle: nil)
    }

    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

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
        configureMap()
        configureBindings()
    }

    private func configureMap() {
        mapView.styleURL = MGLStyle.lightStyleURL(withVersion: 9)
        mapView.delegate = appearanceProvider
    }

    private func configureBindings() {
        stopAnnotations.producer.on(value: { [weak self] annotations in
            guard let vSelf = self else { return }
            vSelf.mapView.removeAnnotations(vSelf.mapView.annotations ?? [])
            vSelf.mapView.addAnnotations(annotations)
            let camera = MGLMapCamera(lookingAtCenter: annotations.first?.coordinate ?? CLLocationCoordinate2D(latitude: 42, longitude: -71), fromDistance: 2500, pitch: 0, heading: 0)
            vSelf.mapView.setCamera(camera, animated: false)
        })
            .start()

        routePolylines.producer.on(value: { [weak self] polylines in
            guard let vSelf = self else { return }
            vSelf.mapView.remove(polylines)
            vSelf.mapView.add(polylines)
        })
            .start()

    }

}
