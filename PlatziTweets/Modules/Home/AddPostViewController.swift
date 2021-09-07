//
//  AddPostViewController.swift
//  PlatziTweets
//
//  Created by Camilo Rozo on 7/09/21.
//

import UIKit
import Simple_Networking
import SVProgressHUD
import NotificationBannerSwift

class AddPostViewController: UIViewController {

    // MARK: -IBOutlet
    @IBOutlet weak var postTextView: UITextView!
    
    // MARK: -Actions
    @IBAction func addPostAction() {
        savePost()
    }
    @IBAction func dismissAction() {
        dismiss(animated: true, completion: nil)
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()

        
    }
    
    private func savePost() {
        // crear request
        guard let postComment = postTextView.text, !postComment.isEmpty else {
            NotificationBanner( subtitle: "No hay post a publicar", style: .warning).show()
            return
        }
        let request = PostRequest(text: postTextView.text, imageUrl: nil, videoUrl: nil, location: nil)
        SVProgressHUD.show()
        
        SN.post(endpoint: Endpoints.post,
                model: request) { (response: SNResultWithEntity<Post, ErrorResponse>) in
            SVProgressHUD.dismiss()
            switch response{
            case .success(response: let response):
                NotificationBanner( subtitle: "\(response)", style: .success).show()
                self.dismiss(animated: true, completion: nil)
            case .error(error: let error):
                NotificationBanner( subtitle: "Error al enviar post, \(error.localizedDescription)", style: .warning).show()
            case .errorResult(entity: let entity):
                NotificationBanner( subtitle: "Error al enviar post, \(entity.error)", style: .warning).show()
            }
            
        }
        
    }
    
 
}
