//
//  FormatStyle.swift
//  HYDD-driver
//
//  Created by Syed Kashan on 03/06/2020.
//  Copyright © 2020 Syed Kashan. All rights reserved.
//

import Foundation
import UIKit

//Need Protocol to maintain typecast

protocol FormatStyle { }

protocol ViewStyle { }

extension UILabel: FormatStyle { }

extension UIButton: FormatStyle { }

extension UITextField: FormatStyle { }

extension UITextView: FormatStyle { }

extension UIBarButtonItem: FormatStyle { }

extension UIView: ViewStyle { }
