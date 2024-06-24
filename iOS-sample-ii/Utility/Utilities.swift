//
//  Utilities.swift
//  iOS-sample-ii
//
//  Created by Parth iOS  on 12/7/2023.
//

import Foundation
import PDFKit
import AVFoundation


class Utilities: NSObject {

    static func showPopup(title: String, type: AlertType) {
        DispatchQueue.main.async {
            if type == .Success {
                let banner = Banner(title: nil, subtitle: title, image: nil, backgroundColor: Colors.theme.returnColor())
                banner.dismissesOnTap = true
                banner.show(duration: 2.0)
            }else {
                let banner = Banner(title: nil, subtitle: title, image: nil, backgroundColor: Colors.red.returnColor())
                banner.dismissesOnTap = true
                banner.show(duration: 2.0)
            }
        }
    }
    
    static func generatePdfThumbnail(of thumbnailSize: CGSize , for documentUrl: URL, atPage pageIndex: Int) -> UIImage? {
        let pdfDocument = PDFDocument(url: documentUrl)
        let pdfDocumentPage = pdfDocument?.page(at: pageIndex)
        return pdfDocumentPage?.thumbnail(of: thumbnailSize, for: PDFDisplayBox.trimBox)
    }
    
    static func setUserDefaultValue() {
        if !UserDefaults.standard.bool(forKey: UserDefaultType.isFirstTimeOnly) {
            UserDefaults.standard.set(true, forKey: UserDefaultType.isFirstTimeOnly)
            UserDefaults.standard.set(nil, forKey: UserDefaultType.accessToken)
            UserDefaults.standard.setValue("ForTestingFCMtoken", forKey: UserDefaultType.fcmToken)
            UserDefaults.standard.set(false, forKey: UserDefaultType.isLogin)
        }
    }
    
    static func generateThumbnail(for asset:AVAsset) -> UIImage? {
        let assetImgGenerate : AVAssetImageGenerator = AVAssetImageGenerator(asset: asset)
        assetImgGenerate.appliesPreferredTrackTransform = true
        let time = CMTimeMake(value: 1, timescale: 2)
        let img = try? assetImgGenerate.copyCGImage(at: time, actualTime: nil)
        if img != nil {
            let frameImg  = UIImage(cgImage: img!)
           return frameImg
        }
        return nil
    }
    
}
