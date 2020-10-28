//
//  ViewController.swift
//  hotdog classifier
//
//  Created by Shimaa Badawy on 10/28/20.
//

import UIKit
import CoreML
import Vision

class ViewController: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {

    @IBOutlet weak var imageView: UIImageView!
    
    let imagePicker = UIImagePickerController()
    
    override func viewDidLoad() {
        
        super.viewDidLoad()
        imagePicker.delegate = self
        imagePicker.sourceType = .photoLibrary
        imagePicker.allowsEditing = false
        // Do any additional setup after loading the view.
        
    }

    @IBAction func cameraPressed(_ sender: UIBarButtonItem) {
        
        present(imagePicker, animated: true, completion: nil)
        
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let pickedImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            
            imageView.image = pickedImage
            guard let ciimage = CIImage(image: pickedImage) else{fatalError("Error converting image")}
            
            classify(image:ciimage)
            
        }
        
        imagePicker.dismiss(animated: true, completion: nil)
        
    }
    
    func classify(image:CIImage) -> Bool {
        
        guard let model = try? VNCoreMLModel (for: Inceptionv3().model)else{fatalError()}
        
        let request = VNCoreMLRequest(model: model) { (request, error) in
            
            guard let results = request.results as? [VNClassificationObservation] else {fatalError("Model failed to process image")}
            if let result = results.first {
                
                if result.identifier.contains("hotdog"){self.navigationItem.title = "Hotdog!"}
                else {self.navigationItem.title = "Not hotdog"}
                
            }
            
        }
        
        let handler = VNImageRequestHandler(ciImage: image)
        
        do{
        try handler.perform([request])
        }catch{print("Error classifing iamge")}
        
        return true
        
    }
    
    
}

