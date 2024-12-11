//
//  DynamicJSONManager.swift
//  Sippy
//
//  Created by Syed Kashan on 8/27/19.
//  Copyright © 2019 Syed Kashan. All rights reserved.
//

import Foundation

typealias DJM = DynamicJSONManager

class DynamicJSONManager {
    
    static var shared = DynamicJSONManager()
    private var json: [String: Any] = [:]
    
    private func updateJSON(json: [String: Any]) {
        self.json = json
    }
    private func getJSON() -> [String: Any] {
        return self.json
    }
    
    func parseJSONIfDownloaded(completionHandler: @escaping (_ status: Bool) -> Void) {
        if let path = Bundle.main.path(forResource: "AppLanEn", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let json = data.getJSONFromData() {
                    DynamicJSONManager.shared.updateJSON(json: json)
                    completionHandler(true)
                }
                //Chosen Language based parsing
                //let language = L102Language.currentAppleLanguage()
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }
    func parseJSONIfDownloadedFr(completionHandler: @escaping (_ status: Bool) -> Void) {
        if let path = Bundle.main.path(forResource: "AppLanFr", ofType: "json") {
            do {
                let data = try Data(contentsOf: URL(fileURLWithPath: path), options: .alwaysMapped)
                if let json = data.getJSONFromData() {
                    DynamicJSONManager.shared.updateJSON(json: json)
                    completionHandler(true)
                }
                //Chosen Language based parsing
                //let language = L102Language.currentAppleLanguage()
            } catch let error {
                fatalError(error.localizedDescription)
            }
        }
    }
}

extension DynamicJSONManager {
    func getValue(view: String, variable: String) -> String {
        guard let node = DynamicJSONManager.shared.json [view] as? [String: Any] else { return "" }
        guard let value = node[variable] as? String else { return "" }
        return value
    }
    
    func getValueWithArrayOfString(view: String, variable: String) -> [String] {
        guard let node = DynamicJSONManager.shared.json [view] as? [String: Any] else { return [] }
        guard let value = node[variable] as? [String] else { return [] }
        return value
    }
    
    func getValue(variable: String) -> String {
        guard let value = DynamicJSONManager.shared.json [variable] as? String else { return "" }
        return value
    }
    func getValueArray(variable: String) -> [[String: Any]] {
        guard let value = DynamicJSONManager.shared.json [variable] as?  [[String: Any]] else { return [] }
        return value
    }
    
    func getValueWithArrayType(view: String, variable: String) -> [Any] {
        guard let node = DynamicJSONManager.shared.json [view] as? [String: Any] else { return [] }
        guard let value = node[variable] as? [Any] else { return [] }
        return value
    }
}
