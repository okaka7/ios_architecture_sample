//
//  FileURL.swift
//  iOSArchitectureKKSample
//
//  Created by Kota Kawanishi on 2019/09/17.
//  Copyright © 2019 Kota Kawanishi. All rights reserved.
//

import UIKit

struct File {
    // DocumentディレクトリのfileURLを取得
    static func getDocumentsURL() -> NSURL {
        let documentsURL = FileManager.default.urls(for: .libraryDirectory, in: .userDomainMask)[0] as NSURL
        return documentsURL
    }
    
    // ディレクトリのパスにファイル名をつなげてファイルのフルパスを作る
    static func fileInDocumentsDirectory(filename: String) -> String {
        let fileURL = getDocumentsURL().appendingPathComponent(filename)
        return fileURL!.path
    }
    
    static func saveImage (image: UIImage, path: String ) -> Bool {
        let pngImageData = image.pngData()
        do {
            let documentsURL = FileManager.default.urls(for: .libraryDirectory,
                                                        in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(path)
            #if DEBUG
            log.debug(fileURL)
            #endif
            try pngImageData!.write(to: fileURL, options: .atomic)
        } catch {
            print(error)
            return false
        }
        return true
    }
    
    static func loadImageFromPath(path: String) -> UIImage? {
        let image = UIImage(contentsOfFile: path)
        if image == nil {
            print("missing image at: \(path)")
        }
        return image
    }
}
