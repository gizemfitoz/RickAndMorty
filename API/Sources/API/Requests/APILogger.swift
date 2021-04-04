//
//  APILogger.swift
//  
//
//  Created by Gizem Fitoz on 4.04.2021.
//

import Foundation
import Alamofire

final class APILogger: EventMonitor {
    func requestDidResume(_ request: Request) {
        let url = request.request?.url?.absoluteString ?? ""
        let method = request.request?.method?.rawValue ?? ""
        print("⚡️ \(method.uppercased()) \(url)")
    }
}
