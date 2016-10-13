//
//  ViewController.swift
//  NDCarousel
//
//  Created by Nicole De La Feld on 15/03/2016.
//  Copyright © 2016 nicky1525. All rights reserved.
//

import UIKit

class ViewController: UIViewController, NDCarouselDelegate {
    @IBOutlet weak var carousel: NDCarousel!

    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        let names = ["photo1", "photo2","photo3", "photo4", "photo5"]
        var images = [UIImage]()
        for photo in names {
            let image = UIImage(named: photo)
            images.append(image!)
        }
        
        _ = carousel.initWithImages(images: images, animationInterval: 4, displaySlideIndicator: true)
            .setSlideBackgroundColor(color: UIColor.black) // Not visible in this case cause the images is as big as the slide, default is White
            .setSlideIndicatorTintColor(color: UIColor.white) // Default is lightGray
            .setSlideIndicatorSelectedColor(color: UIColor.black) // Default is DarkGray
        
        // Conform to the NDCarouselDelegate if you need the user to be able to tap on it
        carousel.delegate = self
    }
    
    func didSelectImageAtIndex(index:Int) {
        // Use the index of the image to do what you need..
        print("Tap on image number \(index + 1)")
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
}

