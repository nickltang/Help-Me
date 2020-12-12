//
//  Mood.swift
//  low-key
//
//  Created by Eunice Oh on 12/11/20.
//  Copyright © 2020 Eunice Oh. All rights reserved.
//

import Foundation

struct Mood: Codable {
    let mood: String
    let date: TimeInterval
    var dictionary: [String: Any] {
            let data = (try? JSONEncoder().encode(self)) ?? Data()
            return (try? JSONSerialization.jsonObject(with: data, options: .mutableContainers) as? [String: Any]) ?? [:]
        }
    
    enum CodingKeys: String, CodingKey {
        case mood
        case date
    }
}
