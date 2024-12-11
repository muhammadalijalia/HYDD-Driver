//
//  MapTableViewCell.swift
//  HYDD-driver
//
//  Created by Macbook Pro on 22/03/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit
import GoogleMaps

protocol MapTableViewCellDelegate: class {
    func gotoMap(index: Int)
}

class MapTableViewCell: UITableViewCell {

    @IBOutlet weak var viewMap: GMSMapView!
    @IBOutlet weak var labelTime: UILabel!
    var index: Int = 0
    var coordinates: CLLocationCoordinate2D?
    let markerCar = GMSMarker()
    
    weak var delegate: MapTableViewCellDelegate?
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    @IBAction func actionOpenGoogle(_ sender: UIButton) {
        delegate?.gotoMap(index: self.index)
    }
}
extension MapTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let ordinates = coordinates else { return }
        viewMap.camera = GMSCameraPosition(target: ordinates, zoom: 15)
        markerCar.icon = UIImage(named: "icon_location")
        markerCar.position = ordinates
        markerCar.map = viewMap
    }
}
