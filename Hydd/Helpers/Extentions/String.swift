//
//  String.swift
//  Sippy
//
//  Created by Syed Kashan on 10/14/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import UIKit
extension String {
    var localized: String {
        return NSLocalizedString(self, tableName: nil, bundle: Bundle.main.getBundleName(), value: "", comment: "")
    }
    //Validations
    var isValidEmail: Bool {
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,6}"
        return NSPredicate(format: "SELF MATCHES %@", emailRegex).evaluate(with: self)
    }
    
    var isValidPassword: Bool {
        if self.count >= 5 { return true } else { return false }
    }
    
    var isValidCardNumber: Bool {
        if self.count >= 14 { return true } else { return false }
    }
    
    var isValidCVV: Bool {
        if self.count == 4 || self.count == 3 { return true } else { return false }
    }
    
    var isValidName: Bool {
        if self.isEmpty { return false } else { return true }
    }
    
    var isValidFName: Bool {
        if self.count >= 3 { return true } else { return false }
    }
    
    var isValidLName: Bool {
        if self.count >= 3 { return true } else { return false }
    }
    
    var isValidPhone: Bool {
        if self.count >= 6 { return true } else { return false }
    }
    var isUaeNumber: Bool {
        if self.count == 13 { return true } else { return false }
    }
    
    var isDobValid: Bool {
        if self.isEmpty { return false } else { return true }
    }
    
    func convertToFormat(formate: String) -> String {
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        dateFormatter.locale = Locale(identifier: "en_US_POSIX")
        guard let date = dateFormatter.date(from: self) else { return self}
        dateFormatter.timeZone = TimeZone.current
        dateFormatter.dateFormat = "\(formate)"
        return  dateFormatter.string(from: date)
    }
    
    enum APPFont: String {
        case csBlack = "CircularStd-Black"
        case csBlackItalic = "CircularStd-BlackItalic"
        case csBold = "CircularStd-Bold"
        case csBoldItalic = "CircularStd-BoldItalic"
        case csBook = "CircularStd-Book"
        case csBookItalic = "CircularStd-BookItalic"
        case csMedium = "CircularStd-Medium"
        case csMediumItralic = "CircularStd-MediumItalic"
        case gorgia = "Georgia"
    }
    
    func setAttributedStringfor(font: APPFont, letterSpaceing: CGFloat, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        
        guard let font = UIFont(name: "\(font.rawValue)", size: size)  else { return  NSMutableAttributedString()}
        
        let attributedString = NSMutableAttributedString(string: "\(self)", attributes: [
            .font: font,
            .foregroundColor: color,
            .kern: letterSpaceing
            ])
        return attributedString
    }
    func setAttributedStringforUndeline(font: APPFont, letterSpaceing: CGFloat, size: CGFloat, color: UIColor) -> NSMutableAttributedString {
        
        guard let font = UIFont(name: "\(font.rawValue)", size: size)  else { return  NSMutableAttributedString()}
        let attributedString = NSMutableAttributedString(string: "\(self)", attributes: [
            .font: font,
            .foregroundColor: color,
            .kern: letterSpaceing,
            .underlineStyle: NSUnderlineStyle.single.rawValue
            ])
        return attributedString
    }
    
    var htmlToAttributedString: NSAttributedString? {
        guard let data = data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToString: String {
        return htmlToAttributedString?.string ?? ""
    }
    var htmlToAttributedStringToH1: NSAttributedString? {
            let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(Fonts.CircularStdBook)'; color:white; font-size: 25\">%@</span>", self)
           guard let data = modifiedFont.data(using: .utf8) else { return NSAttributedString() }
           do {
               return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
           } catch {
               return NSAttributedString()
           }
       }
    var htmlToAttributedStringToH2: NSAttributedString? {
         let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(Fonts.CircularStdBook)'; color:white; font-size: 21\">%@</span>", self)
        guard let data = modifiedFont.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToAttributedStringToH1Black: NSAttributedString? {
         let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(Fonts.CircularStdBook)'; color:black; font-size: 25\">%@</span>", self)
        guard let data = modifiedFont.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    var htmlToAttributedStringTo15Black: NSAttributedString? {
         let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(Fonts.CircularStdBook)'; color:black; font-size: 15\">%@</span>", self)
        guard let data = modifiedFont.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    func htmlToString(size: Int) -> NSAttributedString? {
        let modifiedFont = String(format: "<span style=\"font-family: '-apple-system', '\(Fonts.CircularStdBook)'; color:black; font-size: \(size);display:inline-block; margin: 0px;\">%@</span>", self)
        guard let data = modifiedFont.data(using: .utf8) else { return NSAttributedString() }
        do {
            return try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
        } catch {
            return NSAttributedString()
        }
    }
    func removeHtmlTags() -> String? {
        do {
            guard let data = self.data(using: .unicode) else {
                return nil
            }
            let attributed = try NSAttributedString(data: data, options: [.documentType: NSAttributedString.DocumentType.html, .characterEncoding: String.Encoding.utf8.rawValue], documentAttributes: nil)
            return attributed.string
        } catch {
            return nil
        }
    }
    
    func styled(as style: TextStyle) -> NSMutableAttributedString {
        return  NSMutableAttributedString(string: self, attributes: style.attributes)
    }
    
    func strikeThrough(as style: TextStyle) -> NSMutableAttributedString {
        let attributeString: NSMutableAttributedString =  NSMutableAttributedString(string: self)
        attributeString.addAttribute(NSAttributedString.Key.strikethroughStyle, value: 2, range: NSRange(location: 0, length: attributeString.length))
        attributeString.addAttributes(style.attributes, range: NSRange(location: 0, length: attributeString.length))
        return NSMutableAttributedString(attributedString: attributeString)
    }
    
    func getSubscript(i: Int) -> Character {
        return self[index(startIndex, offsetBy: i)]
    }
    
    enum PlacesStatus {
        case success, empty, invalidKey, failure, serverFail, invalid
    }
    var placesStatus: PlacesStatus {
        switch self {
        case "OK":
            return .success
        case "ZERO_RESULTS":
            return .empty
        case "REQUEST_DENIED":
            return .invalidKey
        case "INVALID_REQUEST":
            return .failure
        case "UNKNOWN_ERRO":
            return .serverFail
        default:
            return .invalid
        }
    }
}
