//
//  ErrorObject.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import Foundation

// MARK: - ErrorObject

struct ErrorObject: Codable, Error {
    let success: Bool
    let error: ErrorInfo
}

// MARK: - ErrorInfo

struct ErrorInfo: Codable {
    let code: Int
    let info: String
}

