//
//  QuizViewController.swift
//  practica5
//
//  Created by Marina Cebollero on 18/12/18.
//  Copyright © 2018 g818. All rights reserved.
//
import UIKit

struct QuizAnswer: Codable {
    let quizId: Int
    let answer: String
    let result: Bool
}

class QuizViewController: UIViewController {
    
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var respuestaLabel: UILabel!
    @IBOutlet weak var quizAnswerText: UITextField!
    var checkAnswer: Bool!
    var quizInheritedImageUrlStr: String!
    var quizInheritedQuestion: String!
    var quizInheritedAnswer: String!
    var quizInheritedId: Int!
    var idString: String!
    var inheritedTips = [String]()
    var session = URLSession.shared
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizLabel.text = quizInheritedQuestion
        let quizInheritedImageUrl = URL(string: quizInheritedImageUrlStr)
        let data = try? Data(contentsOf: quizInheritedImageUrl!, options: [])
        let quizInheritedImage = UIImage(data: data!)
        quizImage.image = quizInheritedImage
        
        // Do any additional setup after loading the view.
    }
    
    private func getAnswer(){
        idString = String(quizInheritedId)
        let answerUrl = "https://quiz2019.herokuapp.com/api/quizzes/\(idString!)/check?token=8d004f988f04a9020778&answer=\(quizAnswerText.text!)"
        guard let url = URL(string: answerUrl) else {
            print("Error al transformar el String a url")
            return
        }
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let queue = DispatchQueue(label: "download queue")
        queue.async {
            // No hay que escapar caracteres conflictivo
            print(url)
            if let data = try? Data(contentsOf: url) {
                let decoder = JSONDecoder()
                if let answer = try? decoder.decode(QuizAnswer.self, from: data) {
                    DispatchQueue.main.async {
                        if (answer.result){
                            self.respuestaLabel.text = "CORRECTO"
                            
                            
                        } else {
                            self.respuestaLabel.text = "INCORRECTO"
                        }
                    }
           
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                
            }
            defer{
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }  }
        }
    }
        
    @IBAction func submitAnswer(_ sender: Any) {
        getAnswer()
          }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowTips"{
            let destination = segue.destination as! PistasTableViewController
            destination.inheritedTips = inheritedTips
            }
            
        }
        

    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

        }
        

    

