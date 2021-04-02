//
//  File.swift
//  
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit

public protocol StoryboardLoadable {
    static func storyboardName() -> String
    static func storyboardIdentifier() -> String
}

public extension StoryboardLoadable where Self: UIViewController {
    static func storyboardName() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }
    
    static func storyboardIdentifier() -> String {
        return String(describing: Self.self).replacingOccurrences(of: "ViewController", with: "")
    }
}

public extension UIStoryboard {
    static func loadViewController<T>() -> T where T: StoryboardLoadable, T: UIViewController {
        return UIStoryboard(name: T.storyboardName(), bundle: nil)
            .instantiateViewController(withIdentifier: T.storyboardIdentifier()) as! T
    }
}
