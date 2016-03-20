//
//  NDCarousel.swift
//  NDCarousel
//
//  Created by Nicole De La Feld on 15/03/2016.
//  Copyright © 2016 nicky1525. All rights reserved.
//

import UIKit

class NDCarousel: UIView, UIScrollViewDelegate {
    
    private var pageControl: UIPageControl!
    private var images: Array<UIImage>!
    private var animationTimer: NSTimer?
    private var scrollView:UIScrollView!
    private var currentPage:Int?
    
    //Set Defaults
    /*
    Background color,
    animation timeInterval
    pageControl selected item color
    pageControl unselected item color
    pageControl visible or not
    scrollDirection..
    pinch to zoom
    stop autoscroll for few seconds when user interacts
    */
    
    //make it usable from storyboard or just programmatically
    //give chance to chose between array of images, array of strings or array of url and use a library to download images asynchronously"

    override init(frame: CGRect) {
        super.init(frame: frame)
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
    }
    
    // Call this method to load the carousel images passing an array of UIImages or an array of Strings(in this case there will be an asynchronous download of the images???)
    func setUpWithImages(images:Array<UIImage>) {
        self.images = images
        scrollView = UIScrollView(frame: self.frame)
        scrollView.delegate = self
        scrollView.showsHorizontalScrollIndicator = false
        scrollView.pagingEnabled = true
        scrollView.bounces = false
        
        let scrollSize = scrollView.frame.size
        
        for var i = 0 ; i < self.images.count; i++ {
            let slideRect = CGRect(x: scrollSize.width * CGFloat(i), y: 0, width: scrollSize.width, height: scrollSize.height)
            let slide = UIView(frame: slideRect)
            slide.backgroundColor = UIColor.whiteColor()
            
            let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: slide.frame.size.width, height: slide.frame.height))
            imageView.image = images[i]
            imageView.contentMode = .ScaleAspectFill
            slide.addSubview(imageView)
            scrollView.addSubview(slide)
        }
        
        pageControl = UIPageControl(frame: CGRect(x: 0, y: scrollSize.height - 20, width: scrollSize.width, height: 20))
        pageControl.numberOfPages = images.count
        pageControl.pageIndicatorTintColor = UIColor.lightGrayColor()
        pageControl.currentPageIndicatorTintColor = UIColor.grayColor()
        currentPage = pageControl.currentPage
        
        scrollView.contentSize = CGSize(width: scrollSize.width * CGFloat(images.count), height: scrollSize.height)
        self.addSubview(scrollView)
        self.addSubview(pageControl)
    }
    
    // Call this method to animate the carousel using the desired interval. Default is set to 6.0 seconds
    func autoScrollWithInterval(interval: NSTimeInterval) {
        animationTimer = NSTimer.scheduledTimerWithTimeInterval(interval, target: self, selector: Selector("autoScroll"), userInfo: nil, repeats: true)
    }
    
    private func autoScroll() {
        var frame = CGRect()
        if currentPage! + 1  < pageControl.numberOfPages {
            frame.origin.x = CGFloat(currentPage! + 1) * CGFloat(self.frame.width)
        }
        else {
            frame.origin.x = 0
        }
        frame.origin.y = 0
        frame.size = self.frame.size
        scrollView.scrollRectToVisible(frame, animated: true)
    }
    
    //MARK: ScrollViewDelegate
    func scrollViewDidScroll(scrollView: UIScrollView) {
        let pageWidth = scrollView.frame.size.width
        let page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1
        pageControl.currentPage = Int(page)
        currentPage = pageControl.currentPage
    }
}
