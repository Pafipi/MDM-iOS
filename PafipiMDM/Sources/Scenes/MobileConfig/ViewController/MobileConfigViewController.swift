//
//  MobileConfigViewController.swift
//  PafipiMDM
//
//  Created by Piotr Fraccaro on 04/06/2021.
//

import SafariServices

protocol MobileConfigViewControllerDelegate: AnyObject {
    
    func didFinish()
}

public final class MobileConfigViewController: SFSafariViewController {
    
    weak var viewControllerDelegate: MobileConfigViewControllerDelegate?
    
    public class func create(with url: URL) -> MobileConfigViewController {
        let vc = MobileConfigViewController(url: url)
        vc.delegate = vc
        return vc
    }
}

// MARK: - SFSafariViewControllerDelegate

extension MobileConfigViewController: SFSafariViewControllerDelegate {
    
    public func safariViewControllerDidFinish(_ controller: SFSafariViewController) {
        viewControllerDelegate?.didFinish()
    }
}
