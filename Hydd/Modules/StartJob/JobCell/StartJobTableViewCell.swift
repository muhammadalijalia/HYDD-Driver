//
//  JobTableViewCell.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 09/02/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import UIKit

class StartJobTableViewCell: UITableViewCell {
    
    @IBOutlet weak var viewInstructions: UIView!
    @IBOutlet weak var viewFlightNo: RoundShadowView!
    @IBOutlet weak var viewNameBoardData: UIView!
    @IBOutlet weak var viewNameBoard: UIView!
    @IBOutlet weak var viewMission: RoundShadowView!
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
    @IBOutlet weak var labelBabySeat: UILabel!
    @IBOutlet weak var labelBabySeat0_18: UILabel!
    @IBOutlet weak var labelBabySeat0_18Desc: UILabel!
    @IBOutlet weak var babySeatView0: UIView!
    @IBOutlet weak var babySeatCount0: UILabel!
    @IBOutlet weak var labelInfantSeat15_36: UILabel!
    @IBOutlet weak var labelInfantSeat15_36Desc: UILabel!
    @IBOutlet weak var babySeatView1: UIView!
    @IBOutlet weak var babySeatCount1: UILabel!
    @IBOutlet weak var labelInfantSeat22_36: UILabel!
    @IBOutlet weak var labelInfantSeat22_36Desc: UILabel!
    @IBOutlet weak var babySeatView2: UIView!
    @IBOutlet weak var babySeatCount2: UILabel!
    @IBOutlet weak var userNameTextField: UITextField!
    @IBOutlet weak var lblFlightStatic: UILabel!
    @IBOutlet weak var lblFlightNumber: UILabel!
    @IBOutlet weak var labelInstructionStatic: UILabel!
    @IBOutlet weak var labelOptional: UILabel!
    @IBOutlet weak var instructionsTextField: UITextView!
    @IBOutlet weak var labelNameBoard: UILabel!
    @IBOutlet weak var viewArrow: UIView!
    @IBOutlet weak var viewEndTime: UIView!
    @IBOutlet weak var amountView: UIView!
    @IBOutlet weak var orderTypeView: UIView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        viewArrow.isHidden = false
        viewEndTime.isHidden = false
    }
    
}

extension StartJobTableViewCell: SetupCell {
    func configureCell<T>(object: T) {
        guard let data = object as? CarSummaryModel else {return}
        let date = Date(timeIntervalSince1970: Double(data.pickupDateTimestamp ))
        DispatchQueue.main.async {
            if data.modelImageServer.count > 5 {
                ImageManager.shared.setImage(url: data.carImage, imageView: self.imageVehicle)
            }
        }
        //   viewArrow.isHidden = true
        //  viewEndTime.isHidden = true
        //Formatter for french date
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
        
        //formatter for time
        let timeFormatter = DateFormatter()
        timeFormatter.locale = Locale.init(identifier: "fr")
        timeFormatter.dateFormat = "HH:mm"
        timeFormatter.timeStyle = DateFormatter.Style.short
        let strPickupTime = timeFormatter.string(from: date)
        let StartTime = strPickupTime.components(separatedBy: ":")
        let startHour = StartTime[0]
        let startMinutes = StartTime[1]
        
        let dateEnd = Date(timeIntervalSince1970: Double(data.endDateTimestamp))
        let dateEndFormatter = DateFormatter()
        dateEndFormatter.timeZone = TimeZone(abbreviation: "UTC +2:00")
        dateEndFormatter.locale = NSLocale.current
        dateEndFormatter.dateFormat = dateEnd.dateFormatWithSuffix() //Specify your format that you want
        //        let strEndTime = dateFormatter.string(from: dateEnd)
        let frFullEndDate = strPickupDate.components(separatedBy: " ")
        let daysEnd = frFullEndDate[0].uppercased()
        let monthEnd = frFullEndDate[1].uppercased()
        let yearEnd = frFullDate[2]
        let tareekhEnd = frFullEndDate[3]
        
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
                self.labelAmount.attributedText = "\(data.totalFare)€".styled(as: .helveticaRegular_20sp_red)
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
            
            self.labelPickUp.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "pickup").styled(as: .gibsonRegular_10sp_grey)
            self.labelPickupLocation.attributedText = data.pickupLocation.styled(as: .gibsonRegular_14sp)
            
            self.labelDropoff.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "dest").styled(as: .gibsonRegular_12sp_grey)
            self.labelDropoffLocation.attributedText = data.destinationLocation.styled(as: .gibsonRegular_14sp)
            
            self.labelClassVehicle.attributedText = data.category.styled(as: .gibsonRegular_14sp)
            self.labelVehicle.attributedText = "\(data.brand), \(data.modelName)".styled(as: .gibsonRegular_10sp_grey)
            let numberCar = DJM.shared.getValue(view: "start_job_view", variable: "no_car").styled(as: .gibsonRegular_12sp_grey)
            numberCar.append("x1".styled(as: .gibsonRegular_16sp))
            self.labelNumberCar.attributedText = numberCar
            if data.orderName == "Transfer"{
                let hours = DJM.shared.getValue(view: "start_job_view", variable: "est_time").styled(as: .gibsonRegular_12sp_grey)
                hours.append("\(String(data.eta))".styled(as: .gibsonRegular_16sp))
                self.labelHours.attributedText = hours
                
                let km = DJM.shared.getValue(view: "start_job_view", variable: "est_km").styled(as: .gibsonRegular_12sp_grey)
                km.append("\(Int(data.total_km)) kms".styled(as: .gibsonRegular_16sp))
                self.labelKm.attributedText = km
            } else{
                let hours = DJM.shared.getValue(view: "start_job_view", variable: "hours").styled(as: .gibsonRegular_12sp_grey)
                hours.append("\(String(data.total_hours)) hours".styled(as: .gibsonRegular_16sp))
                self.labelHours.attributedText = hours
                
                let km = DJM.shared.getValue(view: "start_job_view", variable: "kms").styled(as: .gibsonRegular_12sp_grey)
                km.append("\(Int(data.total_km)) kms".styled(as: .gibsonRegular_16sp))
                self.labelKm.attributedText = km
            }
            setupNew(data: data)
        } else {
            viewArrow.isHidden = true
            viewEndTime.isHidden = true
            if data.orderName == "Transfer"{
                self.labelClass.attributedText = DJM.shared.getValue(view: "earnings_view", variable: "transfer").styled(as: .helveticaRegular_20sp_blue)
            } else {
                self.labelClass.attributedText = DJM.shared.getValue(view: "earnings_view", variable: "directed").styled(as: .helveticaRegular_20sp_blue)
            }
            if HUM.shared.user?.access == "full"{
                self.labelAmount.attributedText = "\(data.totalFare)€".styled(as: .helveticaRegular_20sp_red)
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
            
            
            self.labelPickUp.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "pickup").styled(as: .gibsonRegular_10sp_grey)
            self.labelPickupLocation.attributedText = data.pickupLocation.styled(as: .gibsonRegular_14sp)
            
            self.labelDropoff.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "dest").styled(as: .gibsonRegular_12sp_grey)
            self.labelDropoffLocation.attributedText = data.destinationLocation.styled(as: .gibsonRegular_14sp)
            
            self.labelClassVehicle.attributedText = data.category.styled(as: .gibsonRegular_14sp)
            self.labelVehicle.attributedText = "\(data.brand), \(data.modelName)".styled(as: .gibsonRegular_10sp_grey)
            let numberCar = DJM.shared.getValue(view: "start_job_view", variable: "no_car").styled(as: .gibsonRegular_12sp_grey)
            numberCar.append("x1".styled(as: .gibsonRegular_16sp))
            self.labelNumberCar.attributedText = numberCar
            if data.orderName == "Transfer"{
                let hours = DJM.shared.getValue(view: "start_job_view", variable: "est_time").styled(as: .gibsonRegular_12sp_grey)
                hours.append("\(String(data.eta))".styled(as: .gibsonRegular_16sp))
                self.labelHours.attributedText = hours
                
                let km = DJM.shared.getValue(view: "start_job_view", variable: "est_km").styled(as: .gibsonRegular_12sp_grey)
                km.append("\(Int(data.total_km)) kms".styled(as: .gibsonRegular_16sp))
                self.labelKm.attributedText = km
            } else{
                let hours = DJM.shared.getValue(view: "start_job_view", variable: "hours").styled(as: .gibsonRegular_12sp_grey)
                hours.append("\(String(data.total_hours)) hours".styled(as: .gibsonRegular_16sp))
                self.labelHours.attributedText = hours
                
                let km = DJM.shared.getValue(view: "start_job_view", variable: "kms").styled(as: .gibsonRegular_12sp_grey)
                km.append("\(Int(data.total_km)) kms".styled(as: .gibsonRegular_16sp))
                self.labelKm.attributedText = km
            }
            
            
            setupNew(data: data)
        }
        
    }
    func setupNew(data: CarSummaryModel) {
        babySeatCount0.attributedText = "0".styled(as: .gibsonRegular_14sp)
        babySeatCount1.attributedText = "0".styled(as: .gibsonRegular_14sp)
        babySeatCount2.attributedText = "0".styled(as: .gibsonRegular_14sp)
        let _ = babySeatView0.isAcceptedView
        let _ = babySeatView1.isAcceptedView
        let _ = babySeatView2.isAcceptedView
        data.babySeats.forEach({
            if $0.id == 1 {
                babySeatCount0.attributedText = "\($0.seats)".styled(as: .gibsonRegular_14sp_white)
                babySeatView0.backgroundColor = .hyddblue
            } else if $0.id == 2 {
                babySeatCount1.attributedText = "\($0.seats)".styled(as: .gibsonRegular_14sp_white)
                babySeatView1.backgroundColor = .hyddblue
            } else {
                babySeatCount2.attributedText = "\($0.seats)".styled(as: .gibsonRegular_14sp_white)
                babySeatView2.backgroundColor = .hyddblue
            }
        })
        labelBabySeat.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_babyseat").styled(as: .gibsonRegular_16sp)
        labelNameBoard.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "nameboard").styled(as: .gibsonRegular_16sp)
        labelBabySeat0_18.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_babyseat1").styled(as: .gibsonRegular_14sp)
        labelBabySeat0_18Desc.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_infantseat1").styled(as: .gibsonRegular_12sp_grey)
        labelInfantSeat15_36Desc.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_infantseat2").styled(as: .gibsonRegular_12sp_grey)
        labelInfantSeat15_36.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_babyseat2").styled(as: .gibsonRegular_14sp)
        labelInfantSeat22_36.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_babyseat3").styled(as: .gibsonRegular_14sp)
        labelInfantSeat22_36Desc.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "title_infantseat3").styled(as: .gibsonRegular_12sp_grey)
        viewInstructions.isHidden = true
        labelInstructionStatic.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "instructions").styled(as: .gibsonRegular_16sp)
        if data.instructions.count > 2 {
            viewInstructions.isHidden = false
            //  labelOptional.setLabelFeatures(text: "(Optional)", font: "Gibson-Regular", size: 13)
            instructionsTextField.text = data.instructions
        }
        
        //        viewNameBoard.isHidden = true
        //        viewNameBoardData.isHidden = true
        //        if data.nameBoard.count > 2 {
        //            viewNameBoard.isHidden = false
        //            viewNameBoardData.isHidden = false
        //            userNameTextField.attributedText = data.nameBoard.styled(as: .gibsonRegular_18sp)
        //        }
        
        if data.status == "pending"{
            viewNameBoard.isHidden = true
            viewNameBoardData.isHidden = true
            viewFlightNo.isHidden = true
        } else {
            viewNameBoard.isHidden = true
            viewNameBoardData.isHidden = true
            viewFlightNo.isHidden = true
            if data.nameBoard.count > 2 {
            viewNameBoard.isHidden = false
            viewNameBoardData.isHidden = false
            userNameTextField.attributedText = data.nameBoard.styled(as: .gibsonRegular_18sp)
            }
            if data.flightNumber.count > 2 {
                viewFlightNo.isHidden = false
                lblFlightStatic.attributedText = DJM.shared.getValue(view: "start_job_view", variable: "flight").styled(as: .gibsonRegular_16sp)
                lblFlightNumber.attributedText = "\(data.flightNumber)".styled(as: .gibsonRegular_16sp)
            }
        }
    }
}
