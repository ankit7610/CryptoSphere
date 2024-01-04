//
//  LocalFileManager.swift
//  SwiftCoin
//
//  Created by Ankit Kaushik on 24/12/23.
//

import Foundation
import SwiftUI
class LocalFileManager{
    static let instance = LocalFileManager()
    private init(){
        
    }
    func saveImage(image:UIImage,imageName:String,FolderName:String){
        createFolderIfNeeded(folderName: FolderName)
        guard
            let data=image.pngData(),
            let url = GetURLForImage(imageNAME:imageName, folderName:FolderName)
        else{return}
        do {
            try data.write(to: url)
        } catch let error {
            print("Error \(error)")
        }
    }
    func GetImage(imageName:String,folderName:String){
        guard let url = GetURLForImage(imageNAME:imageName, folderName:folderName),
              FileManager.default.fileExists(atPath:url.path) else{return}
    }
    private func createFolderIfNeeded(folderName:String){
        guard let url = getURLForFolder(Foldername:folderName) else{return}
        if !FileManager.default.fileExists(atPath: url.path){
            do{
                try FileManager.default.createDirectory(at:url, withIntermediateDirectories:true,attributes:nil)
            } catch let Error{
                print("\(Error)")
            }
        }
    }
    private func getURLForFolder(Foldername:String) -> URL? {
        guard let url = FileManager.default.urls(for:.cachesDirectory, in:.userDomainMask).first else {
            return nil
        }
        return url.appendingPathComponent(Foldername)
    }
    private func GetURLForImage(imageNAME:String,folderName:String) -> URL? {
        guard let FolderURL = getURLForFolder(Foldername:folderName) else{return nil}
        return FolderURL.appendingPathComponent(imageNAME + ".png")
    }
}
