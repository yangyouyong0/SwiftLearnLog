//
//  WebViewController.swift
//  LearnBBS
//
//  Created by yangyouyong on 15/5/5.
//  Copyright (c) 2015年 yangyouyong. All rights reserved.
//

import UIKit

class WebViewController: UIViewController,UIWebViewDelegate,UIActionSheetDelegate,NSURLConnectionDelegate,NSURLConnectionDataDelegate {

    // 内链
    var innerPage = [
                            "ms.hujiang.com/bbs/topic",
                            "s.hujiang.com/bbs/topic",
                            "ms.hujiang.com/bbs/wzhj",
                            "pass.hujiang.com/m/",
                            "ms.hujiang.com/u/",
                            "ms2.hujiang.com/bbs/topic",
                            "s.hujiang.com/topic",
                            "ms.hujiang.com/bbs/my/",
                            "captcha.qq.com/cap_union_show",
                            "about:blank"
                            ]
    var webView:UIWebView = UIWebView()
    var url:String = ""
    var backBtn:UIButton = UIButton()
    var showLeftItem = true
    var isFirstLoad = true
    var gotoNewVC = false
    var FirstLoadEnd = false
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.webView = UIWebView(frame: self.view.bounds)
        self.webView.delegate = self
        self.view.addSubview(self.webView)
        self.navigationItem.titleView = UIImageView(image: UIImage(named: "XuebaTitle")!)
        
        if self.showLeftItem {
        backBtn = UIButton(frame: CGRectMake(0, 0, 44, 44))
        backBtn.setTitle("back", forState: .Normal)
        backBtn.setTitleColor(UIColor.blackColor(), forState: UIControlState.Normal)
        backBtn.addTarget(self, action:"back", forControlEvents:.TouchUpInside)
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(customView: backBtn)
        }
        
        self.loadData()
    }


    final func loadData() {
//        self.webView.loadRequest(NSURLRequest(URL: NSURL(string:self.url)!))
        
        let requestURL = NSURL(string: self.url)!
        let request = NSURLRequest(URL: requestURL)
        NSURLConnection.sendAsynchronousRequest(request, queue: NSOperationQueue.mainQueue()) { (response, data, error) -> Void in
            
            // 替换xmlString 中需要去掉的固定标签 -- 更改为去掉data 解析出的htmlstring 去掉固定标签对里的内容
                
                let htmlString = NSString(data: data, encoding: NSUTF8StringEncoding)!
                let htmlStr = htmlString as String
                var finishHtmlStr = htmlStr
            
            // 过滤导航标签
                let startRange = htmlStr.rangeOfString("<header")
                let endRange = htmlStr.rangeOfString("</header>")
                if  startRange?.startIndex != nil && endRange?.endIndex != nil {
                    let headerRange = Range(start: startRange!.startIndex, end: endRange!.endIndex)
                        finishHtmlStr = htmlStr.stringByReplacingCharactersInRange(headerRange, withString: "<replaced>此处被替换了</replaced>")
                    println("finished html string \(finishHtmlStr)")
                    println("startRange:\(startRange) endRange:\(endRange)")
                }
                    dispatch_async(dispatch_get_main_queue()){
                        self.webView.loadHTMLString(finishHtmlStr, baseURL: request.URL)
                    }
            // 同理,过滤底部链接<footer>
            // 过滤 浮动广告 -- JS 实现
            
            // MARK:- AEXML 个人探索用法
            var document = AEXMLDocument()
            var str = document.readXMLData(data)
            // println("document is \(document.xmlString)")
            
            // MARK:- AEXML 标准用法
            var error: NSError?
            if let xmlDoc = AEXMLDocument(xmlData: data, error: &error) {
            // println("xmlString is \(xmlDoc)")
            }else{
            // println("error is \(error?.userInfo)")
            }
            
            // MARK:- SWXMLHash 解析
            var xml = SWXMLHash.parse(data)
            // println(xml.all)
            var finalXml = SWXMLHash.parse(data)
            var finalArray = finalXml.all
            
        }
        
        println(self.url)
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
    }
    
    func back() {
        self.navigationController?.popViewControllerAnimated(true)
        println(self.navigationController)
    }
    
    // MARK: - WebViewDelegate
    func webView(webView: UIWebView, shouldStartLoadWithRequest request: NSURLRequest, navigationType: UIWebViewNavigationType) -> Bool {
        
       // 如果是选择帖子类型，则在本页面内刷新
        var range = request.URL?.absoluteString?.rangeOfString("bbs/topiclist?tagid")
        if (range != nil) {
            return true
        }
        
        // 修改“首次打开内嵌论坛，点击赞、发帖，登录账号，帖子列表页点击左上角‘返回’，返回页面是登录页”的问题
        // 修改删除帖子后跳转到不正常页面的问题

        if (request.URL?.absoluteString == "http://ms.hujiang.com/bbs/wzhj") {
            if self.navigationController?.viewControllers.count > 1{
                self.navigationController?.popToRootViewControllerAnimated(true)
                return false
            }
        }

        // 检索出重定向URL，并替换当前URL
        let absoluteURLString = request.URL!.absoluteString
        let decodedURLString = absoluteURLString!.stringByReplacingPercentEscapesUsingEncoding(NSUTF8StringEncoding)
        let strRange = (decodedURLString! as NSString).rangeOfString("&page")
        
        println("range is \(strRange), decodeString is \(decodedURLString), absoluteString is \(absoluteURLString)")
        println("start range is \(strRange.location) ")
        if strRange.location != NSNotFound {
            let redirectURLString = (decodedURLString! as NSString).substringFromIndex(strRange.location + 6)
            self.webView.loadRequest(NSURLRequest(URL: NSURL(string: redirectURLString)!))
        }
        
        var found = true
//        for url:String in self.innerPage {
//            if decodedURLString!.rangeOfString(url) != nil {
//                found = true
//            }
//        }
        
        
        if found {
            println("found is true,\(self.isFirstLoad),\(navigationType.rawValue)")
            if self.isFirstLoad {
            self.isFirstLoad = false
            println("first login")
            return true
            }
            else {
                let ssoUrlArray = [
                                    "https://graph.qq.com/oauth2.0/authorize?response_type=code",
                                    "http://xui.ptlogin2.qq.com/cgi-bin/xlogin?",
                                    "http://openmobile.qq.com/oauth2.0/m_authlist?",
                                    "http://captcha.qq.com/cap_union_show",
//                                    "ms.hujiang.com/bbs/wzhj",
                                    "about:blank"
                                    ]
                for urlString:String in ssoUrlArray {
                    if  decodedURLString?.rangeOfString(urlString) != nil {
                        return true
                    }
                }
                
                if  !self.gotoNewVC && self.FirstLoadEnd {
                   let webVC = WebViewController()
                    webVC.url = request.URL!.absoluteString!
                    self.navigationController!.pushViewController(webVC, animated: true)
                    self.webView.reload()
                    self.gotoNewVC = true

                }
                
                return true
            }
          
        } else {
            println("--------show alert")
            return false
        }
    }
    
    func webViewDidStartLoad(webView: UIWebView) {
        
    }
    
    func webViewDidFinishLoad(webView: UIWebView) {
        
        self.FirstLoadEnd = true
        self.gotoNewVC = false
        
//        let headBar = webView.stringByEvaluatingJavaScriptFromString("document.getElementsById('Div')")!
//        let document = webView.stringByEvaluatingJavaScriptFromString("document.documentElement.innerHTML")!
//        let div = webView.stringByEvaluatingJavaScriptFromString("document.getElementsByTagName('header')")
        
//        var jsStr = NSMutableString()
//        // 0.删除顶部的导航条
//        jsStr.appendString("var header = document.getElementsByTagName('header')[0];")
//        jsStr.appendString("header.parentNode.removeChild(header);")
//        
//        webView.stringByEvaluatingJavaScriptFromString(jsStr as String)
//        
//        // 1.删除底部的链接
//        var jsFootStr = NSMutableString()
//        jsFootStr.appendString("var footer = document.getElementsByTagName('footer')[0];")
//        jsFootStr.appendString("footer.parentNode.removeChild(footer);")
//        webView.stringByEvaluatingJavaScriptFromString(jsFootStr as String)
//        
//        // 2.删除浮动广告
//        var jsAdStr = NSMutableString()
//        jsAdStr.appendString("var list = document.body.childNodes;")
//        jsAdStr.appendString("var len = list.length;")
//        jsAdStr.appendString("var banner = list[len - 1];")
//        jsAdStr.appendString("banner.parentNode.removeChild(banner);")
//        webView.stringByEvaluatingJavaScriptFromString(jsAdStr as String)
        
//        println("load -------- finished\(headBar), document is \(div)")
    }
    
    func webView(webView: UIWebView, didFailLoadWithError error: NSError) {
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

class BBSViewController: UIViewController,UIWebViewDelegate,UIActionSheetDelegate {
    
    // 正式环境
    static let kGoBBSWebURL:String = "http://ms.hujiang.com/bbs/wzhj"
    var needRefresh:Bool = false
//    var webVC:WebViewController = WebViewController()
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    
}

extension UIWebView {

    // 开始加载动画
    
    func startProgressAnimation() {
        
    }
    
    // 动画加载完
    func setProgressBarFulled(){
        
    }
    
    //  加载失败，
    func setProgressBarFailed() {
        
    }
}
