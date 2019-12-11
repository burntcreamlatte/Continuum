//
//  Comment.swift
//  Continuum
//
//  Created by Aaron Shackelford on 12/10/19.
//  Copyright © 2019 Aaron Shackelford. All rights reserved.
//

import Foundation
import CloudKit

class Comment {
    var text: String
    weak var post: Post?
    var timestamp: Date
    let recordID: CKRecord.ID
    
    
    init(text: String, post: Post?, timestamp: Date = Date(), recordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.text = text
        self.post = post
        self.timestamp = timestamp
        self.recordID = recordID
    }
    
    convenience init?(ckRecord: CKRecord, post: Post?) {
        guard let text = ckRecord[CommentConstants.textKey] as? String,
            let timestamp = ckRecord[CommentConstants.timestampKey] as? Date else { return nil }
        
        self.init(text: text, post: post, timestamp: timestamp, recordID: ckRecord.recordID)
    }
}

extension Comment: SearchableRecord {
    func matches(searchTerm: String) -> Bool {
        return text.contains(searchTerm)
    }
    
    
}

enum CommentConstants {
    static let recordType = "Comment"
    static let textKey = "text"
    static let postReferenceKey = "post"
    static let timestampKey = "timestamp"
}
