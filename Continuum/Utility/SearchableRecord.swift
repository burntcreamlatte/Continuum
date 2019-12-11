//
//  SearchableRecord.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/11/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import Foundation
import CloudKit

protocol SearchableRecord {
    func matches(searchTerm: String) -> Bool
}
