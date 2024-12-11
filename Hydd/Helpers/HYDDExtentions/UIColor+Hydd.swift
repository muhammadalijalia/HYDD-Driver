import UIKit

extension UIColor {
    @nonobjc class var hyddblue: UIColor {
        return UIColor(red: 58/255.0, green: 204/255.0, blue: 225/255.0, alpha: 1)
    }
    @nonobjc class var greySeperator: UIColor {
        return UIColor(red: 244/255.0, green: 244/255.0, blue: 246/255.0, alpha: 1)
    }
    @nonobjc class var hyddRed: UIColor {
        return UIColor(red: 255/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1)
    }
}

extension UIColor {
    
    struct HYDDColors {
        static let tfBoarderColor = UIColor(red: 231, green: 231, blue: 231)
        static let navigationTitle = UIColor.white
    }
    convenience init(red: Int, green: Int, blue: Int) {
        assert(red >= 0 && red <= 255, "Invalid red component")
        assert(green >= 0 && green <= 255, "Invalid green component")
        assert(blue >= 0 && blue <= 255, "Invalid blue component")
        self.init(red: CGFloat(red) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: 1.0)
    }
    convenience init(netHex: Int) {
        self.init(red: (netHex >> 16) & 0xff, green: (netHex >> 8) & 0xff, blue: netHex & 0xff)
    }
}
