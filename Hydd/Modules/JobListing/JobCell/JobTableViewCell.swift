//
//  JobTableViewCell.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 26/01/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class JobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewCell: UIView!
    @IBOutlet weak var labelClass: UILabel!
    @IBOutlet weak var labelAmount: UILabel!
    @IBOutlet weak var labelStartTime: UILabel!
    @IBOutlet weak var labelEndTime: UILabel!
    @IBOutlet weak var labelPickUp: UILabel!
    @IBOutlet weak var labelPickupLocation: UILabel!
    @IBOutlet weak var labelDropoff: UILabel!
    @IBOutlet weak var labelDropoffLocation: UILabel!
    @IBOutlet weak var labelClassVehicle: UILabel!
    @IBOutlet weak var labelVehicle: UILabel!
    @IBOutlet weak var imageVehicle: UIImageView!
    @IBOutlet weak var labelNumberCar: UILabel!
    @IBOutlet weak var labelHours: UILabel!
    @IBOutlet weak var labelKm: UILabel!
    @IBOutlet weak var arrowView: UIView!
    @IBOutlet weak var endTimeView: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var orderTypeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    override func prepareForReuse() {
        super.prepareForReuse()
        arrowView.isHidden = false
        endTimeView.isHidden = false
    }
}

extension JobTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let data = object as? CarSummaryModel else {return}
        let date = Date(timeIntervalSince1970: Double(data.pickupDateTimestamp))
        //Formatter for french date
        DispatchQueue.main.async {
            if data.modelImageServer.count > 5 {
                ImageManager.shared.setImage(url: data.carImage, imageView: self.imageVehicle)
            }
        }
        let dateFormatter = DateFormatter()
        dateFormatter.timeZone = TimeZone(abbreviation: "UTC +2:00") //Set timezone that you want
        dateFormatter.locale = Locale.init(identifier: "fr")
        dateFormatter.dateFormat = date.dateFormatWithSuffix() //Specify your format that you want
        let strPickupDate = dateFormatter.string(from: date)
        let frFullDate = strPickupDate.components(separatedBy: " ")
        let days = frFullDate[0].uppercased()
        let month = frFullDate[1].uppercased()
        let year = frFullDate[2]
        let tareekh = frFullDate[3]
        
        //formatter for time start
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale.init(identifier: "fr")
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeStyle = DateFormatter.Style.short
        let strPickupTime = timeFormatter.string(from: date)
        let StartTime = strPickupTime.components(separatedBy: ":")
        let startHour = StartTime[0]
        let startMinutes = StartTime[1]
        
        //End dates format
        let dateEnd = Date(timeIntervalSince1970: Double(data.endDateTimestamp))
        let dateEndFormatter = DateFormatter()
        dateEndFormatter.timeZone = TimeZone(abbreviation: "UTC +2:00")
        dateEndFormatter.locale = NSLocale.current
        dateEndFormatter.dateFormat = dateEnd.dateFormatWithSuffix() //Specify your format that you want
        let strEndTime = dateFormatter.string(from: dateEnd)
        let frFullEndDate = strPickupDate.components(separatedBy: " ")
        let daysEnd = frFullEndDate[0].uppercased()
        let monthEnd = frFullEndDate[1].uppercased()
        let yearEnd = frFullEndDate[2]
        let tareekhEnd = frFullEndDate[3]
        print(strEndTime)
        
        //formatter for time End
        let timeFormatterEnd = DateFormatter()
        timeFormatterEnd.locale = Locale.init(identifier: "fr")
        timeFormatterEnd.dateFormat = "HH:mm"
        timeFormatterEnd.timeStyle = DateFormatter.Style.short
        let strEndupTime = timeFormatterEnd.string(from: dateEnd)
        let timeEnd = strEndupTime.components(separatedBy: ":")
        let endHour = timeEnd[0]
        let endMinutes = timeEnd[1]
        
        if data.status == "close" || data.status == "cancel"{
            if data.orderName == "Transfer"{
                self.labelClass.attributedText = DJM.shared.getValue(view: "earnings_view", variable: "transfer").styled(as: .helveticaRegular_20sp_blue)
            } else {
                self.labelClass.attributedText = DJM.shared.getValue(view: "earnings_view", variable: "directed").styled(as: .helveticaRegular_20sp_blue)
            }
            if HUM.shared.user?.access == "full"{
                           self.labelAmount.attributedText = "\(Int(data.totalFare))€".styled(as: .helveticaRegular_20sp_red)
                       } else{
                           let centerX = NSLayoutConstraint(item: orderTypeView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
                           amountView.isHidden = true
                           self.contentView.addConstraint(centerX)
                       }
            let attStartTime = "\(days)\n".styled(as: .helveticaRegular_10sp)
            attStartTime.append("\(tareekh)\n".styled(as: .helveticaBold_18sp))
            attStartTime.append("\(month)\n".styled(as: .helveticaRegular_10sp))
            attStartTime.append("\(year)\n".styled(as: .helveticaRegular_10sp))
            attStartTime.append("\(startHour)h\(startMinutes)".styled(as: .helveticaBold_18sp))
            self.labelStartTime.attributedText = attStartTime
            
            let attEndTime = "\(daysEnd)\n".styled(as: .helveticaRegular_10sp)
            attEndTime.append("\(tareekhEnd)\n".styled(as: .helveticaBold_18sp))
            attEndTime.append("\(monthEnd)\n".styled(as: .helveticaRegular_10sp))
            attEndTime.append("\(yearEnd)\n".styled(as: .helveticaRegular_10sp))
            attEndTime.append("\(endHour)h\(endMinutes)".styled(as: .helveticaBold_18sp))
            self.labelEndTime.attributedText = attEndTime
            
            self.labelPickUp.attributedText = DJM.shared.getValue(view: "job_listing_view", variable: "pickup").styled(as: .gibsonRegular_10sp_grey)
            self.labelPickupLocation.attributedText = data.pickupLocation.styled(as: .gibsonRegular_14sp)
            
            self.labelClassVehicle.attributedText = data.category.styled(as: .gibsonRegular_14sp)
            self.labelVehicle.attributedText = "\(data.brand), \(data.modelName)".styled(as: .gibsonRegular_10sp_grey)
            
        } else {
            arrowView.isHidden = true
            endTimeView.isHidden = true
            if data.orderName == "Transfer"{
                           self.labelClass.attributedText = DJM.shared.getValue(view: "earnings_view", variable: "transfer").styled(as: .helveticaRegular_20sp_blue)
                       } else {
                           self.labelClass.attributedText = DJM.shared.getValue(view: "earnings_view", variable: "directed").styled(as: .helveticaRegular_20sp_blue)
                       }
            if HUM.shared.user?.access == "full"{
                self.labelAmount.attributedText = "\(Int(data.totalFare))€".styled(as: .helveticaRegular_20sp_red)
            } else{
                let centerX = NSLayoutConstraint(item: orderTypeView, attribute: NSLayoutConstraint.Attribute.centerX, relatedBy: NSLayoutConstraint.Relation.equal, toItem: contentView, attribute: NSLayoutConstraint.Attribute.centerX, multiplier: 1, constant: 0)
                amountView.isHidden = true
                self.contentView.addConstraint(centerX)
            }
            let attStartTime = "\(days)\n".styled(as: .helveticaRegular_10sp)
            attStartTime.append("\(tareekh)\n".styled(as: .helveticaBold_18sp))
            attStartTime.append("\(month)\n".styled(as: .helveticaRegular_10sp))
            attStartTime.append("\(year)\n".styled(as: .helveticaRegular_10sp))
            attStartTime.append("\(startHour)h\(startMinutes)".styled(as: .helveticaBold_18sp))
            self.labelStartTime.attributedText = attStartTime
            
            self.labelPickUp.attributedText = DJM.shared.getValue(view: "job_listing_view", variable: "pickup").styled(as: .gibsonRegular_10sp_grey)
            self.labelPickupLocation.attributedText = data.pickupLocation.styled(as: .gibsonRegular_14sp)
            
            self.labelClassVehicle.attributedText = data.category.styled(as: .gibsonRegular_14sp)
            self.labelVehicle.attributedText = "\(data.brand), \(data.modelName)".styled(as: .gibsonRegular_10sp_grey)
            viewCell.borderColor = themeColor
            if data.status == "in_progress" || data.status == "waiting for client" || data.status == "client onboard" {
                viewCell.borderWidth = 1
            } else {
                viewCell.borderWidth = 0
            }
        }
    }
}
extension Date {
    
    func dateFormatWithSuffix() -> String {
        // return "dd'\(self.daySuffix())' MMMM yyyy"
        return "EE MMM yyyy dd'\(self.daySuffix())'"
    }
    
    func daySuffix() -> String {
        let calendar = Calendar.current
        let components = (calendar as NSCalendar).components(.day, from: self)
        let dayOfMonth = components.day
        switch dayOfMonth {
        case 1, 21, 31:
            return "st"
        case 2, 22:
            return "nd"
        case 3, 23:
            return "rd"
        default:
            return "th"
        }
    }
}
