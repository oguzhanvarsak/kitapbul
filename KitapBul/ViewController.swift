import UIKit
import MTBBarcodeScanner

class SwiftExampleViewController: UIViewController {
    
    @IBOutlet var previewView: UIView!
    var scanner: MTBBarcodeScanner?
    static var ISBN: String?
    @IBOutlet weak var segment: UISegmentedControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        scanner = MTBBarcodeScanner(previewView: previewView)

        // Alternatively, limit the type of codes you can scan:
        // scanner = MTBBarcodeScanner(metadataObjectTypes: [AVMetadataObject.ObjectType.qr.rawValue], previewView: previewView)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        MTBBarcodeScanner.requestCameraPermission(success: { success in
            if success {
                do {
                    try self.scanner?.startScanning(resultBlock: { codes in
                        if let codes = codes {
                            for code in codes {
                                let stringValue = code.stringValue!
                                print(stringValue)
                                SwiftExampleViewController.ISBN = stringValue
                                self.performSegue(withIdentifier: "popover", sender: nil)
                            }
                        }
                    })
                } catch {
                    NSLog("Unable to start scanning")
                }
            } else {
                UIAlertView(title: "Scanning Unavailable", message: "This app does not have permission to access the camera", delegate: nil, cancelButtonTitle: nil, otherButtonTitles: "Ok").show()
            }
        })
        
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        self.scanner?.stopScanning()
        
        super.viewWillDisappear(animated)
    }
    
    @IBAction func segmentAct(_ sender: Any) {
        
        if segment.selectedSegmentIndex == 0 {
            
        } else {
            let ac = UIAlertController(title: "ISBN Kodu:", message: nil, preferredStyle: .alert)
            ac.addTextField()

            let submitAction = UIAlertAction(title: "Ara", style: .default) { [unowned ac] _ in
                let answer = ac.textFields![0]
                SwiftExampleViewController.ISBN = answer.text
                self.performSegue(withIdentifier: "popover", sender: nil)
            }

            ac.addAction(UIAlertAction(title: "İptal", style: UIAlertAction.Style.cancel, handler: { action in
                self.segment.selectedSegmentIndex = 0
             }))
            
            

            ac.addAction(submitAction)
            present(ac, animated: true)
        }
    }

}
