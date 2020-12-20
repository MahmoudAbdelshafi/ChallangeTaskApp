//
//  Currency.swift
//  challengeTask
//
//  Created by Mahmoud Abdelshafi on 12/20/20.
//

import Foundation

// MARK: - Currency

struct Currency: Codable {
    let success: Bool?
    let timestamp: Int?
    let base: String?
    let date: String?
    let rates: [String: Double]?
}

// MARK: - Rates

struct Rates: Codable {
}
