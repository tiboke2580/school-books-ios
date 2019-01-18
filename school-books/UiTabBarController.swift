//
//  uiTabBarController.swift
//  school-books
//
//  Created by Thibaut Maddelein on 18/01/2019.
//  Copyright © 2019 Thibaut Maddelein. All rights reserved.
//

import UIKit

class UiTabBarController: UITabBarController{
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.hidesBackButton = true;
    }
}
