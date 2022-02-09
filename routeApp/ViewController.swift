//
//  ViewController.swift
//  routeApp
//
//  Created by Андрей Чистяков on 08.02.2022.
//

import UIKit
import MapKit
import CoreLocation

class ViewController: UIViewController {
    
    let mapView: MKMapView = {
        
        let mapView = MKMapView()
        mapView.translatesAutoresizingMaskIntoConstraints = false
        
        return mapView
    }()

    let addAdressButton: UIButton = {
        let button = UIButton()
        button.setTitle("Add", for: .normal)
        button.backgroundColor = .blue
        button.layer.cornerRadius = 16
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        button.translatesAutoresizingMaskIntoConstraints = false
        
        return button
    }()
    
    let routeButton: UIButton = {
        let button = UIButton()
        button.setTitle("Route", for: .normal)
        button.backgroundColor = .darkGray
        button.layer.cornerRadius = 16
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    let resetButton: UIButton = {
        let button = UIButton()
        button.setTitle("Reset", for: .normal)
        button.backgroundColor = .red
        button.layer.cornerRadius = 16
        button.titleEdgeInsets = UIEdgeInsets(top: 5, left: 7, bottom: 5, right: 7)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.isHidden = true
        return button
    }()
    
    var annotationsArray = [MKPointAnnotation]()
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
 
        setConstraints()
        
        addAdressButton.addTarget(self, action: #selector(addAdressButtonTapped), for: .touchUpInside)
        routeButton.addTarget(self, action: #selector(routeButtonTapped), for: .touchUpInside)
        resetButton.addTarget(self, action: #selector(resetButtonTapped), for: .touchUpInside)
        
    }

    @objc func addAdressButtonTapped() {
        alertAddAdress(title: "Add adress", placeholder: "Enter address"){ [self] (text) in
        
            setupPlaceMark(adress: text)
            
            if annotationsArray.count > 2 {
                routeButton.isHidden = false
                resetButton.isHidden = false
            }
        }
    }
    
    @objc func routeButtonTapped() {
        print("tapRoute")
    }
    
    @objc func resetButtonTapped() {
        print("tapReset")
    }
    
    
    
    private func setupPlaceMark(adress: String){
        
        let geocoder = CLGeocoder()
        geocoder.geocodeAddressString( adress) { [self](placemarks, error) in
            if let error = error {
                print(error.localizedDescription)
                alertError(title: "Error", message: error.localizedDescription)
                return
            }
            
            guard let placemarks = placemarks else{
                alertError(title: "Error", message: "No points")
                return
            }
            
            let placemark = placemarks.first
            
            let annotation = MKPointAnnotation()
            annotation.title = "\(adress)"
            
            guard let placemarkLocation = placemark?.location else { return }
            
            annotation.coordinate = placemarkLocation.coordinate
            
            annotationsArray.append(annotation)
            
         
            
            mapView.showAnnotations(annotationsArray, animated: true)
            
            
        }
        
    }
    
}

extension ViewController{
    
    func setConstraints() {
        view.addSubview(mapView)
        NSLayoutConstraint.activate([
            mapView.topAnchor.constraint(equalTo: view.topAnchor, constant: 0),
            mapView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 0),
            mapView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: 0),
            mapView.bottomAnchor.constraint(equalTo: view.bottomAnchor, constant: 0)
        ])
    
        mapView.addSubview(addAdressButton)
        NSLayoutConstraint.activate([
            addAdressButton.topAnchor.constraint(equalTo: mapView.topAnchor, constant: 50),
            addAdressButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            addAdressButton.heightAnchor.constraint(equalToConstant: 40),
            addAdressButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        mapView.addSubview(routeButton)
        NSLayoutConstraint.activate([
            routeButton.leadingAnchor.constraint(equalTo: mapView.leadingAnchor, constant: 20),
            routeButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20),
            routeButton.heightAnchor.constraint(equalToConstant: 40),
            routeButton.widthAnchor.constraint(equalToConstant: 70)
        ])
        
        mapView.addSubview(resetButton)
        NSLayoutConstraint.activate([
            resetButton.trailingAnchor.constraint(equalTo: mapView.trailingAnchor, constant: -20),
            resetButton.bottomAnchor.constraint(equalTo: mapView.bottomAnchor, constant: -20),
            resetButton.heightAnchor.constraint(equalToConstant: 40),
            resetButton.widthAnchor.constraint(equalToConstant: 70)
        ])
    }
    
}
