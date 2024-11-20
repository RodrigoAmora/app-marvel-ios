//
//  AboutViewController.swift
//  Marvel App
//
//  Created by Rodrigo Amora on 16/11/24.
//

import Foundation
import UIKit

class AboutViewController: BaseViewController {
    
    // MARK: - IBOutlets
    @IBOutlet weak var createdByLabel: UILabel!
    @IBOutlet weak var emailAuthorLabel: UILabel!
    @IBOutlet weak var siteAuthorLabel: UILabel!
    @IBOutlet weak var versionLabel: UILabel!
    
    // MARK: - View life cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        self.initViews()
    }
    
    // MARK: - Methods
    private func initViews() {
        let versao = String(localized: "version_app")
        self.versionLabel.text = String(format: versao, self.getVersionApp() ?? "")
        self.versionLabel.textAlignment = .center
        
        self.createdByLabel.text = String(localized: "created_by")
        self.createdByLabel.textAlignment = .center
        
        self.emailAuthorLabel.text = String(localized: "email_author")
        self.emailAuthorLabel.textAlignment = .center
        
        self.siteAuthorLabel.text = String(localized: "site_author")
        self.siteAuthorLabel.textAlignment = .center
    }
}
