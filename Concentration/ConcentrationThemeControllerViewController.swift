
//  Created by Antonio Bang on 8/21/18.
//  Copyright © 2018 UCLAExtension. All rights reserved.
//

import UIKit

class ConcentrationThemeControllerViewController: UIViewController {
    
    let themes = [
        "Sports": "⚽️🏀🏈⚾️🎾🏐🏉🎱🏓⛷🎳⛳️",
        "Animals": "🐶🦆🐹🐸🐘🦍🐓🐩🐦🦋🐙🐏",
        "Faces": "😀😌😎🤓😠😤😭😰😱😳😜😇"
    ]
    
    @IBAction func changeTheme(_ sender: Any) {
        //find a view controller
        if let cvc = splitViewDetailConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme;
            }
        }
        //save the last controller to a strong pointer
        else if let cvc = lastSegueToConcentrationViewController {
            if let themeName = (sender as? UIButton)?.currentTitle, let theme = themes[themeName] {
                cvc.theme = theme;
            }
            //push a controller to a navigation controller withour seguing
            navigationController?.pushViewController(cvc, animated: true)
        }
        else {
            performSegue(withIdentifier: "Choose Theme", sender: sender);
        }
    }
    
    private var splitViewDetailConcentrationViewController: ConcentrationViewController? {
        return splitViewController?.viewControllers.last as? ConcentrationViewController;
    }
    
    private var lastSegueToConcentrationViewController: ConcentrationViewController?;
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "Choose Theme" {
            if let themeName = (sender as? UIButton )?.currentTitle, let theme = themes[themeName] {
                if let cvc = segue.destination as? ConcentrationViewController{
                    cvc.theme = theme;
                    lastSegueToConcentrationViewController = cvc; //set the controller
                }
            }
        }
    }


}
