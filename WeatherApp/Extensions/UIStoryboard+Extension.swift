//
//  UIStoryboard+Extension.swift
//  WeatherApp
//
//  Created by yangpc on 11/08/2019.
//  Copyright © 2019 yang hee jung. All rights reserved.
//

import UIKit

extension UIStoryboard {

    static var main: UIStoryboard {
        return UIStoryboard(name: "Main", bundle: nil)
    }

    static var locationSearch: UIStoryboard {
        return UIStoryboard(name: "LocationSearch", bundle: nil)
    }

    static var weatherDetail: UIStoryboard {
        return UIStoryboard(name: "WeatherDetail", bundle: nil)
    }

    func instantiateViewController<T: UIViewController>() -> T {
        return instantiateViewController(withIdentifier: "\(T.self)") as! T
    }
}
