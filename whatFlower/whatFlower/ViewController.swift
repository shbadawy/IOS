//
//  ViewController.swift
//  whatFlower
//
//  Created by Shimaa Badawy on 10/28/20.
//

import UIKit
import CoreML
import Vision
import Alamofire
import SwiftyJSON
import SDWebImage

class ViewController: UIViewController,UIImagePickerControllerDelegate,UINavigationControllerDelegate {
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var textbox: UILabel!
    
    let imagePicker = UIImagePickerController()
    let wikipediaURl = "https://en.wikipedia.org/w/api.php"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
    }
    
    @IBAction func cameraPressed(_ sender: Any) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        guard let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage else {fatalError("Error converting image")}
        imageView.image = pickedImage
        
        guard let ciimage = CIImage(image: pickedImage) else {fatalError("Error convering CIImage")}
        classify(image:ciimage)
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func classify(image:CIImage){
        
        guard let model = try? VNCoreMLModel (for: FlowerClassifier().model) else {fatalError("Error getting model")}
        let request = try VNCoreMLRequest(model: model) { (request, error) in
            
            guard let result = request.results?.first as? VNClassificationObservation else {fatalError("Error getting result")}
            self.navigationItem.title = result.identifier.capitalized
            self.requestInfo(flowerName: result.identifier)
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do {
            try handler.perform([request])
        }catch{print("Error classifing model")}
        
    }
    
    func requestInfo(flowerName:String) {
        
        let parameters : [String:String] = [
            "format" : "json",
            "action" : "query",
            "prop" : "extracts|pageimages",
            "exintro" : "",
            "explaintext" : "",
            "titles" : flowerName,
            "indexpageids" : "",
            "redirects" : "1",
            "pithumbsize" : "500"
        ]
        
        Alamofire.request(wikipediaURl, method: .get, parameters: parameters).responseJSON { (response) in
            
            if response.result.isSuccess {
                
                print("Got it successfully")
                let json = JSON(response.result.value!)
                let pageid = json["query"]["pageids"][0].stringValue
                let information = json["query"]["pages"][pageid]["extract"].stringValue
                let imageURL = json["query"]["pages"][pageid]["thumbnail"]["source"].stringValue
                print(information)
                self.textbox.text = information
                self.imageView.sd_setImage(with: URL(string: imageURL))
                
            }
            
        }
        
        
        
    }
    
}

