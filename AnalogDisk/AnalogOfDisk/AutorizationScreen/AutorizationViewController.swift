//
//  AutorizationViewController.swift
//  AnalogOfDisk
//
//  Created by Ольга on 19.10.2023.
//

import Foundation
import UIKit

protocol AutorizationViewProtocol {
    var didFinish: (()->())? {get set}
}

class AutorizationViewController: UIViewController, AutorizationViewProtocol {
    
    var didFinish: (()->())?
    private let loginButton: UIButton = {
        let button = UIButton()
        button.layer.cornerRadius = 10
        button.layer.masksToBounds = true
        button.backgroundColor = UIColor(red: 0.22, green: 0.247, blue: 0.961, alpha: 1)
        button.setTitleColor(.white, for: .normal)
        button.setTitle(NSLocalizedString("autorization.login_button", comment: ""), for: .normal)
        button.addTarget(self, action: #selector(loginAction), for: .touchUpInside)
        return button
    }()
    private let logoView: UIImageView = {
        let view = UIImageView()
        view.contentMode = .scaleAspectFit
        view.image = UIImage(named: "logo")
        return view
    }()
  
    override func viewDidLoad() {
        super.viewDidLoad()
        setupConstraints()
    }
    
    @objc func loginAction() {
        let logincVC = LoginViewController()
        logincVC.didFinish = self.didFinish
        self.navigationController?.pushViewController(logincVC, animated: true)
    }
}

extension AutorizationViewController {
    func setupConstraints() {
        loginButton.translatesAutoresizingMaskIntoConstraints = false
        logoView.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(logoView)
        view.addSubview(loginButton)
        logoView.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.centerY.equalTo(view.safeAreaLayoutGuide.snp.centerY).offset(-60)
            make.height.equalTo(195)
        }
        loginButton.snp.makeConstraints { make in
            make.centerX.equalTo(view.safeAreaLayoutGuide.snp.centerX)
            make.top.equalTo(view.safeAreaLayoutGuide.snp.bottom).offset(-130)
            make.height.equalTo(50)
            make.width.equalTo(320)
        }
    }
}
