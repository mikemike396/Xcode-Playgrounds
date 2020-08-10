//: A UIKit based Playground for presenting user interface
  
import UIKit
import PlaygroundSupport

class MyViewController : UIViewController
{
    var label = UILabel()
    
    @objc func tapFunction(sender:UITapGestureRecognizer)
    {
        print("test")
        let actionSheet = UIAlertController(title: nil, message: nil, preferredStyle: .actionSheet)

        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("FORGET_THIS_DEVICE", comment: ""), style: .destructive , handler:{ (UIAlertAction)in
            
        }))


        actionSheet.addAction(UIAlertAction(title: NSLocalizedString("CANCEL_BUTTON", comment: ""), style: .cancel, handler:{ (UIAlertAction)in
        }))

        if let presenter = actionSheet.popoverPresentationController
        {
//            presenter.sourceView = label
//            presenter.sourceRect = label.bounds
//            presenter.permittedArrowDirections = UIPopoverArrowDirection.up
            presenter.sourceView = self.view
                      presenter.sourceRect = CGRect(x: self.view.bounds.midX, y: self.view.bounds.midY, width: 0, height: 0)
                      presenter.permittedArrowDirections = []

         }
        
        self.present(actionSheet, animated: true, completion:
        {
        })
    }
    
    override func loadView() {
        let view = UIView()
        view.backgroundColor = .white

        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!1"
        label.textColor = .black
        label.isUserInteractionEnabled = true
        let tap = UITapGestureRecognizer(target: self, action: #selector(tapFunction(sender:)))
        label.addGestureRecognizer(tap)
        
        view.addSubview(label)
        self.view = view
    }
}
// Present the view controller in the Live View window
let viewController = MyViewController()
viewController.preferredContentSize = CGSize(width: 768, height: 768)
PlaygroundPage.current.liveView = viewController
