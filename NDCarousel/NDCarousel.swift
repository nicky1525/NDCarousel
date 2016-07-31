//
//  NDCarousel.swift
//  NDCarousel
//
//  Created by Nicole De La Feld on 15/03/2016.
//  Copyright © 2016 nicky1525. All rights reserved.
//

import UIKit

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

protocol NDCarouselDelegate {
    func didSelectImageAtIndex()
    func didDeselectImageAtIndex()
}

public class NDCarousel: UIView {
    private var slideIndicator: UIPageControl!
    private var images: Array<UIImage>!
    private var animationTimer: NSTimer?
    private var scrollView:UIScrollView!
    private var currentPage:Int?
    private var slideBackgroundColor = UIColor.whiteColor()
    var delegate: NDCarouselDelegate!
    
    /*
     make it usable from storyboard or just programmatically
     add touch
     pinch to zoom
     stop autoscroll for few seconds when user interacts
     give chance to chose between array of images, array of strings or array of url and use a library to download images asynchronously"
     chose animation direction
    */

    private override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    public required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    public func initWithImages(images:[UIImage], scrollDirection:ScrollDirection, animationInterval:Float, displaySlideIndicator:Bool) {
        // Setup all the images
        setUpWithImages(images, scrollDirection: scrollDirection)
        
        // Add Animation
        if  animationInterval > 0 {
            autoScrollWithInterval(NSTimeInterval(animationInterval))
        }
        
        // Hide or show slideIndicator
        if !displaySlideIndicator {
            slideIndicator.hidden = true
        }
    }
    
    public func setSlideIndicatorSelectedColor(color:UIColor) {
        slideIndicator.currentPageIndicatorTintColor = color
    }
    
    public func setSlideIndicatorTintColor(color:UIColor) {
        slideIndicator.pageIndicatorTintColor = color
    }
    
    public func setSlideBackgroundColor(color:UIColor) {
        slideBackgroundColor = color
    }
    
    // Call this method to load the carousel images passing an array of UIImages
    private func setUpWithImages(images:Array<UIImage>, scrollDirection:ScrollDirection) {
        self.images = images
        scrollView = UIScrollView(frame: self.frame)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.showsVerticalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        
        for i in 0 ..< self.images.count {
            var slideRect: CGRect!
            if scrollDirection == .Horizontal {
                slideRect = CGRect(x: scrollView.frame.size.width * CGFloat(i), y: 0, width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                slideIndicator = UIPageControl(frame: CGRect(x: 0, y: scrollView.frame.size.height - 20, width: scrollView.frame.size.width, height: 20))
            }
            else {
                slideRect = CGRect(x: 0, y: scrollView.frame.size.height * CGFloat(i), width: scrollView.frame.size.width, height: scrollView.frame.size.height)
                slideIndicator = UIPageControl(frame: CGRect(x: 5, y: scrollView.frame.size.height/2, width: 20, height: scrollView.frame.size.height))
            }
            
            let slide = UIView(frame: slideRect)
            slide.backgroundColor = slideBackgroundColor
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slide.frame.size.width, height: slide.frame.height))
            imageView.image = images[i]
            imageView.contentMode = .ScaleAspectFill
            slide.addSubview(imageView)
            scrollView.addSubview(slide)
        }
        
        scrollView.contentSize = CGSize(width: scrollView.frame.size.width * CGFloat(images.count), height: scrollView.frame.size.height)
        slideIndicator.numberOfPages = images.count
        slideIndicator.pageIndicatorTintColor = UIColor.lightGrayColor()
        slideIndicator.currentPageIndicatorTintColor = UIColor.grayColor()
        currentPage = slideIndicator.currentPage
        self.addSubview(slideIndicator)
        self.addSubview(scrollView)
        
    }
    
    // Call this method to animate the carousel using the desired interval. If timeinterval is 0 no animation
    private func autoScrollWithInterval(interval: NSTimeInterval) {
        animationTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector:#selector(autoScroll), userInfo: nil, repeats: true)
    }
    
    @objc private func autoScroll() {
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
    public func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        slideIndicator.currentPage = Int(page)
        currentPage = slideIndicator.currentPage
    }
    
}
