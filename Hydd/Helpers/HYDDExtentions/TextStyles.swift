import UIKit

enum TextStyle {
	case gibsonRegular_15sp
    case gibsonRegular_14sp
    case gibsonRegular_14sp_white
    case gibsonRegular_14sp_hyddBlue
    case gibsonRegular_40sp_blue
    case gibsonRegular_40sp
    case gibsonRegular_16sp
    case gibsonRegular_16sp_gray
    case gibsonRegular_18sp_gray
    case gibsonRegular_18sp
    case gibsonRegular_28sp
    case gibsonRegular_30sp
    case gibsonRegular_50sp
    case gibsonRegular_21sp
    case gibsonRegular_24sp
    case gibsonRegular_24sp_white
    case gibsonRegular_13sp
    case gibsonRegular_12sp
    case helveticaRegular_18sp_gray
    case helveticaRegular_19sp_gray
    case helveticaRegular_20sp
    case helveticaRegular_20sp_gray
    case helveticaBold_20sp_gray
    case helveticaRegular_20sp_blue
    case helveticaRegular_20sp_red
    case helveticaRegular_10sp
    case helveticaRegular_16sp
    case helveticaBold_18sp
    case helveticaBold_10sp
    case gibsonRegular_15sp_placeholder
    case gibsonRegular_10sp_red
    case gibsonRegular_10sp_grey
    case gibsonRegular_12sp_grey
    case gibsonRegular_13sp_red
    case gibsonSemi_16sp
}

extension TextStyle {
	var attributes: [NSAttributedString.Key: Any] {
        switch self {
        case .gibsonRegular_40sp_blue:
            return [.font: UIFont(name: "Gibson-Regular", size: 40) as Any,
                    .foregroundColor: UIColor(red: 58/255.0, green: 204/255.0, blue: 225/255.0, alpha: 1)]
        case .gibsonRegular_15sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 15) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_14sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 14) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_16sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 16) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_18sp_gray:
            return [.font: UIFont(name: "Gibson-Regular", size: 18) as Any,
                    .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .gibsonRegular_16sp_gray:
            return [.font: UIFont(name: "Gibson-Regular", size: GETHEIGHT(16)) as Any,
                    .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .gibsonRegular_18sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 18) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_10sp_grey:
            return [.font: UIFont(name: "Gibson-Regular", size: 10) as Any,
                    .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .gibsonRegular_12sp_grey:
            return [.font: UIFont(name: "Gibson-Regular", size: 12) as Any,
                    .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .gibsonRegular_13sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 13) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_10sp_red:
            return [.font: UIFont(name: "Gibson-Regular", size: 10) as Any,
                    .foregroundColor: UIColor.red]
        case .gibsonRegular_13sp_red:
            return [.font: UIFont(name: "Gibson-Regular", size: 10) as Any,
                    .foregroundColor: UIColor.red]
        case .gibsonRegular_15sp_placeholder:
            return [.font: UIFont(name: "Gibson-Regular", size: 15) as Any,
                    .foregroundColor: UIColor(red: 120/255.0, green: 132/255.0, blue: 158/255.0, alpha: 1)]
        case .gibsonRegular_12sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 12) as Any,
                    .foregroundColor: UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)]
        case .helveticaRegular_20sp:
            return [.font: UIFont(name: "HelveticaNeue-Medium", size: GETHEIGHT(20)) as Any,
                    .foregroundColor: UIColor(red: 255/255.0, green: 255/255.0, blue: 255/255.0, alpha: 1)]
        case .helveticaRegular_20sp_blue:
            return [.font: UIFont(name: "HelveticaNeue-Medium", size: 20) as Any,
                    .foregroundColor: UIColor(red: 58/255.0, green: 204/255.0, blue: 225/255.0, alpha: 1)]
        case .helveticaRegular_20sp_red:
            return [.font: UIFont(name: "HelveticaNeue-Medium", size: 20) as Any,
                    .foregroundColor: UIColor(red: 255/255.0, green: 92/255.0, blue: 92/255.0, alpha: 1)]
        case .helveticaRegular_10sp:
            return [.font: UIFont(name: "HelveticaNeue-Medium", size: 10) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
            case .helveticaRegular_19sp_gray:
                       return [.font: UIFont(name: "HelveticaNeue-Medium", size: GETHEIGHT(19)) as Any,
                               .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
            case .helveticaRegular_18sp_gray:
                                 return [.font: UIFont(name: "HelveticaNeue-Medium", size: GETHEIGHT(18)) as Any,
                                         .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .helveticaRegular_20sp_gray:
            return [.font: UIFont(name: "HelveticaNeue-Medium", size: GETHEIGHT(20)) as Any,
                    .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .helveticaBold_18sp:
            return [.font: UIFont(name: "HelveticaNeue-Bold", size: 18) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .helveticaBold_10sp:
            return [.font: UIFont(name: "HelveticaNeue-Bold", size: 10) as Any,
                    .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]

        case .helveticaBold_20sp_gray:
            return [.font: UIFont(name: "HelveticaNeue-Bold", size: GETHEIGHT(20)) as Any,
                    .foregroundColor: UIColor(red: 149/255.0, green: 157/255.0, blue: 173/255.0, alpha: 1)]
        case .gibsonRegular_28sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 28) as Any,
            .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_50sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 50) as Any,
            .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_21sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 21) as Any,
            .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_24sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 24) as Any,
            .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_40sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 40) as Any,
            .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonSemi_16sp:
            return [.font: UIFont(name: "Gibson-SemiBold", size: 16) as Any,
                .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .helveticaRegular_16sp:
            return [.font: UIFont(name: "HelveticaNeue-Medium", size: 16) as Any,
                    .foregroundColor: UIColor.white]
        case .gibsonRegular_30sp:
            return [.font: UIFont(name: "Gibson-Regular", size: 30) as Any,
        .foregroundColor: UIColor(red: 69/255.0, green: 79/255.0, blue: 99/255.0, alpha: 1)]
        case .gibsonRegular_14sp_hyddBlue:
            return [.font: UIFont(name: "Gibson-Regular", size: 14) as Any,
                    .foregroundColor: UIColor.hyddblue]
        case .gibsonRegular_14sp_white:
            return [.font: UIFont(name: "Gibson-Regular", size: 14) as Any,
                    .foregroundColor: UIColor.white]
        case .gibsonRegular_24sp_white:
                  return [.font: UIFont(name: "Gibson-Regular", size: 24) as Any,
                          .foregroundColor: UIColor.white]
    }
}

}


