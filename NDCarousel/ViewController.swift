//
//  ViewController.swift
//  NDCarousel
//
//  Created by Nicole De La Feld on 15/03/2016.
//  Copyright © 2016 nicky1525. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    @IBOutlet weak var carousel: NDCarousel!

    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
       
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        let names = ["photo1", "photo2", "photo3", "photo4"]
        var images = Array<UIImage>()
        for photo in names {
            let image = UIImage(named: photo)
            images.append(image!)
        }
        carousel.setUpWithImages(images)
    }
    

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

