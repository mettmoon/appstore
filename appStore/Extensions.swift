//
//  Extensions.swift
//  appStore
//
//  Created by Peter Moon on 15/03/2018.
//  Copyright © 2018 WEJOApps. All rights reserved.
//

import UIKit

public extension UIImage {
    
    //color와 size에 맞는 UIImage생성
    public convenience init?(color: UIColor, size: CGSize = CGSize(width: 1, height: 1)) {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, 0.0)
        color.setFill()
        UIRectFill(rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        guard let cgImage = image?.cgImage else { return nil }
        self.init(cgImage: cgImage)
    }
    
    //newSize로 스케일링
    func scaled(toSize newSize:CGSize) -> UIImage{
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0.0);
        self.draw(in: CGRect(origin: CGPoint.zero, size: CGSize(width: newSize.width, height: newSize.height)))
        let newImage:UIImage = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return newImage
    }

}

extension CALayer {
    
    //애플 앱 느낌의 아이콘모양화
    func appleIconization(){
        self.masksToBounds = true
        self.borderWidth = 1 / UIScreen.main.scale
        self.borderColor = UIColor.lightGray.cgColor
        self.cornerRadius = self.frame.size.width * 0.19
        
    }
}
extension URL {
    //해당 url에서 비동기로 이미지를 다운로드
    func toImage(_ completion:@escaping ((UIImage?) -> Void)){
        URLSession.shared.dataTask(with: self) { (data, urlResponse, error) in
            guard let data = data else{
                completion(nil)
                return
            }
            completion(UIImage(data:data))
            }.resume()

    }
}

extension Int {
    
    //만, 천단위 숫자를 간략하게 표기
    var roundedWithAbbreviations: String {
        let number = Double(self)
        let thousand = number / 1000
        let million = number / 1000000
        if million >= 1.0 {
            return "\(round(million*10)/10)만"
        }
        else if thousand >= 1.0 {
            return "\(round(thousand*10)/10)천"
        }
        else {
            return "\(Int(number))"
        }
    }
}
