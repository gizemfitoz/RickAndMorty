//
//  BaseViewController.swift
//  RickAndMorty
//
//  Created by Gizem Fitoz on 3.04.2021.
//

import UIKit
import Extensions

class BaseViewController: UIViewController, StoryboardLoadable {
    var indicatorview = UIActivityIndicatorView(style: .medium)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.view.addSubview(indicatorview)
        indicatorview.center = self.view.center
    }
    
    func showError(error: String) {
        let alertController = UIAlertController(title: "Error", message: error, preferredStyle: .alert)
        alertController.addAction(UIAlertAction(title: "Ok", style: .default, handler: nil))
        self.present(alertController, animated: true, completion: nil)
    }
    
    public func showLoadingView() {
        indicatorview.startAnimating()
    }
    
    func hideLoadingView() {
        indicatorview.stopAnimating()
    }
}
