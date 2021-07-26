//
//  CryptoProcessor.swift
//  AeroPlan
//
//  Created by Ilya Bochkov on 14.05.21.
//

import CryptoKit
import Foundation

enum CryptoProcessor {
    static func sha256(_ input: String) -> String? {
        guard let data = input.data(using: .utf8) else { return nil }
        let digest = SHA256.hash(data: data)
        return digest.hex
    }
}

private extension Digest {
    var bytes: [UInt8] { Array(makeIterator()) }
    var data: Data { Data(bytes) }

    var hex: String {
        bytes.map { String(format: "%02X", $0) }.joined()
    }
}
