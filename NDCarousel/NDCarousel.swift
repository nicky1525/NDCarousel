//
//  NDCarousel.swift
//  NDCarousel
//
//  Created by Nicole De La Feld on 15/03/2016.
//  Copyright © 2016 nicky1525. All rights reserved.
//

import UIKit

/*
 public enum ScrollDirection {
    case Horizontal
    case Vertical
}

enum AnimationDirection {
    case LeftToRight
    case RightToLeft
    case TopToBottom
    case BottomToTop
}
*/

@objc public protocol NDCarouselDelegate {
    func didSelectImageAtIndex(_ index:Int)
}

open class NDCarousel: UIView {
    fileprivate var slideIndicator: UIPageControl!
    fileprivate var images = [UIImage]()
    fileprivate var animationTimer: Timer?
    fileprivate var scrollView:UIScrollView!
    fileprivate var currentPage:Int?
    fileprivate var isSlideIndicatorVisible = true
    fileprivate var slideBackgroundColor = UIColor.white
    open  var delegate: NDCarouselDelegate?
    
    
    /*
     make it usable from storyboard or just programmatically
     pinch to zoom
     stop autoscroll for few seconds when user interacts
     add vertical arrangement
     give chance to chose between array of images, array of strings and use a library to download images asynchronously
     chose animation direction
     handle screen rotation
    */

    fileprivate override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    open func initWithImages(_ images:[UIImage], animationInterval:Float, displaySlideIndicator:Bool) -> NDCarousel{
        // Setup all the images
        setUpWithImages(images)
        
        isSlideIndicatorVisible = displaySlideIndicator
        
        // Add Animation
        if  animationInterval > 0 {
            autoScrollWithInterval(TimeInterval(animationInterval))
        }
        
        return self
    }
    
    open func setSlideIndicatorSelectedColor(_ color:UIColor) -> NDCarousel {
        slideIndicator.currentPageIndicatorTintColor = color
        return self
    }
    
    open func setSlideIndicatorTintColor(_ color:UIColor) -> NDCarousel {
        slideIndicator.pageIndicatorTintColor = color
        return self
    }
    
    open func setSlideBackgroundColor(_ color:UIColor) -> NDCarousel {
        slideBackgroundColor = color
        return self
    }
    
    
    // MARK: Private
    @objc fileprivate func tapHandler(_ sender:UITapGestureRecognizer) {
        let imageViewTapped = sender.view as! UIImageView
        let image = imageViewTapped.image
        let index = images.index(of: image!)
        delegate?.didSelectImageAtIndex(index!)
    }
    
    // Call this method to load the carousel images passing an array of UIImages
    fileprivate func setUpWithImages(_ images:[UIImage]) {
        self.images = images
        scrollView = UIScrollView(frame: self.frame)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.isPagingEnabled = true
        scrollView.bounces = false
        
        for i in 0 ..< self.images.count {
//            var slideRect: CGRect!
//            if scrollDirection == .Horizontal {
            
//            }
//            else {
//                slideRect = CGRect(x: 0, y: scrollView.frame.size.height * CGFloat(i), width: scrollView.frame.size.width, height: scrollView.frame.size.height)
//                slideIndicator = UIPageControl(frame: CGRect(x: 5, y: scrollView.frame.size.height/2, width: 20, height: scrollView.frame.size.height))
//            }
            
            let slideRect = CGRect(x: scrollView.frame.size.width * CGFloat(i), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
            
            
            let slide = UIView(frame: slideRect)
            slide.backgroundColor = slideBackgroundColor
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slide.frame.size.width, height: slide.frame.height))
            imageView.image = images[i]
            imageView.contentMode = .scaleAspectFill
            imageView.isUserInteractionEnabled = true
            let gestureRecogniser = UITapGestureRecognizer(target: self, action:#selector(tapHandler))
            imageView.addGestureRecognizer(gestureRecogniser)
            slide.addSubview(imageView)
            scrollView.addSubview(slide)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        slideIndicator = UIPageControl(frame: CGRect(x: 0, y: scrollView.frame.size.height - 20, width: scrollView.frame.size.width, height: 20))
        slideIndicator.numberOfPages = images.count
        slideIndicator.pageIndicatorTintColor = UIColor.lightGray
        slideIndicator.currentPageIndicatorTintColor = UIColor.gray
        currentPage = slideIndicator.currentPage

        self.addSubview(scrollView)
        if isSlideIndicatorVisible {
            self.addSubview(slideIndicator)
        }
    }
    
    // Call this method to animate the carousel using the desired interval. If timeinterval is 0 no animation
    fileprivate func autoScrollWithInterval(_ interval: TimeInterval) {
        animationTimer = Timer.scheduledTimer(timeInterval: interval, target: self, selector:#selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc fileprivate func autoScroll() {
        var frame = CGRect()
        if currentPage! + 1  < slideIndicator.numberOfPages {
            frame.origin.x = CGFloat(currentPage! + 1) * CGFloat(self.frame.width)
        }
        else {
            frame.origin.x = 0
        }
        frame.origin.y = 0
        frame.size = self.frame.size
        scrollView.scrollRectToVisible(frame, animated: true)
    }
}

//MARK: ScrollViewDelegate
extension NDCarousel:  UIScrollViewDelegate {
    public func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        slideIndicator.currentPage = Int(page)
        currentPage = slideIndicator.currentPage
    }
}
