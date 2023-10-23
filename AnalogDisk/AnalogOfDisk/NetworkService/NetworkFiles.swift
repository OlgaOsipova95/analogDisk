//
//  NetworkFiles.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation

struct NetworkFiles: Codable {
    let items: [NetworkFilesItem]
    
    enum CodingKeys: String, CodingKey {
        case items
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        items = try container.decode([NetworkFilesItem].self, forKey: .items)
    }
}

struct NetworkFilesItem: Codable {
    let path: String
    let size: Int
    let name: String
    let date: String
    let file: String
    let id: String
    let preview: String
    let type: String
    
    enum CodingKeys: String, CodingKey {
        case path
        case size
        case name
        case date = "modified"
        case id = "resource_id"
        case file
        case preview
        case type = "mime_type"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        path = try values.decode(String.self, forKey: .path)
        date = try values.decode(String.self, forKey: .date)
        name = try values.decode(String.self, forKey: .name)
        size = try values.decode(Int.self, forKey: .size)
        file = try values.decode(String.self, forKey: .file)
        id = try values.decode(String.self, forKey: .id)
        preview = try values.decode(String.self, forKey: .preview)
        type = try values.decode(String.self, forKey: .type)
    }
}

struct Link: Codable {
    var link: URL
    
    enum CodingKeys: String, CodingKey {
        case link = "href"
    }
    
    init(from decoder: Decoder) throws {
        let values = try decoder.container(keyedBy: CodingKeys.self)
        let linkString = try values.decode(String.self, forKey: .link)
        link = URL(string: linkString)!
    }
}
