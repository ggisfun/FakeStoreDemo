//
//  Alert+Extension.swift
//  FakeStoreDemo
//
//  Created by Adam Chen on 2025/7/20.
//

import UIKit

extension UIViewController {
    func showAlert(title: String,
                   message: String,
                   okTitle: String = "確定",
                   onOK: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: okTitle, style: .default) { _ in onOK?() })
        self.present(alert, animated: true)
    }

    func showAlertWithCancel(title: String,
                             message: String,
                             okTitle: String = "確定",
                             cancelTitle: String = "取消",
                             onOK: (() -> Void)? = nil,
                             onCancel: (() -> Void)? = nil) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: .alert)

        alert.addAction(UIAlertAction(title: cancelTitle, style: .cancel) { _ in onCancel?() })
        alert.addAction(UIAlertAction(title: okTitle, style: .default) { _ in onOK?() })

        self.present(alert, animated: true)
    }

}
