//
//  AnswerTableViewController.swift
//  practica5
//
//  Created by Marina Cebollero on 19/12/18.
//  Copyright © 2018 g818. All rights reserved.
//

import UIKit

class AnswerTableViewController: UITableViewController {

    struct QuizAnswer: Codable {
        let quizId: Int
        let answer: String
        let result: Bool
    }
    
    var quizAnswer = [QuizAnswer]()
    @IBOutlet weak var quizLabel: UILabel!
    @IBOutlet weak var quizImage: UIImageView!
    @IBOutlet weak var respuestaLabel: UILabel!
    @IBOutlet weak var quizAnswerText: UITextField!
    
    var quizInheritedImageUrlStr: String!
    var quizInheritedQuestion: String!
    var quizInheritedAnswer: String!
    var quizInheritedId: Int!
    var idString: String!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        quizLabel.text = quizInheritedQuestion
        let quizInheritedImageUrl = URL(string: quizInheritedImageUrlStr)
        let data = try? Data(contentsOf: quizInheritedImageUrl!, options: [])
        let quizInheritedImage = UIImage(data: data!)
        quizImage.image = quizInheritedImage
        
        // Do any additional setup after loading the view.
    }
    
    
    func getQuizAnswer() {
        let queue = DispatchQueue(label: "download queue")
        idString = String(quizInheritedId)
        let quizAnswerUrl = "/quizzes/\(idString)/check?answer=\(quizAnswerText.text)"
        queue.async {
            UIApplication.shared.isNetworkActivityIndicatorVisible = true
            let url = URL(string: quizAnswerUrl)!
            if let jsonAnswer = try? Data(contentsOf: url){
                if let  quizData = (try? JSONDecoder().decode(QuizAnswer.self, from: jsonAnswer)) {
                    DispatchQueue.main.async {
                        self.quizAnswer.append(quizData)
                    }
                }
                else{
                    print("error")
                }
            }
            else{
                print("error")
            }
            
            defer{
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }  }
    
    
    @IBAction func submitAnswer(_ sender: Any) {
        getQuizAnswer()
        if quizAnswer[0].result == true{
            respuestaLabel.text = "Correcto!"
            
        }
        else{
            respuestaLabel.text = "Incorrecto"
        }
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        // #warning Incomplete implementation, return the number of sections
        return 0
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        // #warning Incomplete implementation, return the number of rows
        return 0
    }

    /*
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "reuseIdentifier", for: indexPath)

        // Configure the cell...

        return cell
    }
    */

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */

    /*
    // Override to support editing the table view.
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCellEditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
            // Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
            // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }
    */

    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
