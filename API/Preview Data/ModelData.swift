//
//  ModelData.swift
//  API
//
//  Created by Thammasat Thonggamgaew on 11/3/2567 BE.
//

import Foundation
var previewNews: ResponseBody = try! load("news.json")
var newsMangerPreview = NewsManager()

func load<T: Decodable>(_ filename: String) throws -> T {
    let data: Data
    
    guard let file = Bundle.main.url(forResource: filename, withExtension: nil) else {
        fatalError("Couldn't find \(filename)")
    }
    do {
        data = try Data(contentsOf: file)
    } catch {
        fatalError("Couldn't load \(filename)")
    }
    
    // decode
    do {
        let decode = try JSONDecoder().decode(T.self, from: data)
        return decode
    } catch {
        fatalError("Couldn't parse \(filename)")
    }
    
}
