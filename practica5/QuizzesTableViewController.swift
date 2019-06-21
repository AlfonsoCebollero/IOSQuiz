//
//  QuizzesTableViewController.swift
//  practica5
//
//  Created by Marina Cebollero on 26/11/18.
//  Copyright © 2018 g818. All rights reserved.
//

import UIKit

struct Pagina: Codable {
    
    let pageno: Int?
    let nextUrl: String?
    let quizzes: [Quiz]?
}

struct Quiz: Codable {
    let id: Int?
    let author: Author?
    let attachment: Attachment?
    let question: String?
    let favourite: Bool?
    let tips: [String]?
    
    struct Attachment: Codable {
        let filename: String?
        let mime: String?
        let url: String?
    }
    
    struct Author: Codable {
        let id: Int?
        let isAdmin: Bool?
        let username: String?
        
    }
}






class QuizzesTableViewController: UITableViewController {

    var quizzesUrl = "https://quiz2019.herokuapp.com/api/quizzes?token=cce47f8c370326807d5a"
    var pagina = [Pagina]()
    @IBOutlet weak var quizTable: UITableView!
    var quiz = [Quiz]()
    var quizImg: UIImage!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        getQuizzes()
    }
    
    // MARK: Acciones
    
    func getQuizzes() {
        getQuizzesGCD()
    }
    
    func getQuizzesGCD() {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
        let queue = DispatchQueue(label: "download queue")
        queue.async {
            // No hay que escapar caracteres conflictivos
            let url = URL(string: self.quizzesUrl)!
            print(url)
            if let jsonData = try? Data(contentsOf: url){
                if let  quizData = (try? JSONDecoder().decode(Pagina.self, from: jsonData)) {
                    DispatchQueue.main.async {
                        self.pagina.append(quizData)
                        for quiz in quizData.quizzes!{
                            self.quiz.append(quiz)
                        }
                        self.tableView.reloadData()
                        self.quizzesUrl = quizData.nextUrl!
                        if (quizData.nextUrl?.elementsEqual("") == false){
                            self.getQuizzesGCD()
                        }
                    }
                }
                else{
                    print("error")
                }
            }
            else{
                print("error")
            }
            
            DispatchQueue.main.async {
                UIApplication.shared.isNetworkActivityIndicatorVisible = true
                self.tableView.reloadData()
                
            }
            defer{
                DispatchQueue.main.async {
                    UIApplication.shared.isNetworkActivityIndicatorVisible = false
                }
            }
        }  }
    
    // MARK: - Table view data source
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return quiz.count
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let quizCell = tableView.dequeueReusableCell(withIdentifier: "quizCell", for: indexPath) as! QuizzesTableViewCell
        let imgUrlStr = quiz[indexPath.row].attachment?.url
        let imgUrl:URL = URL(string: imgUrlStr!)!
        let data = try? Data(contentsOf: imgUrl, options: [])
        quizImg = UIImage(data: data!)
        quizCell.questionImage?.image = quizImg
        quizCell.question?.text = quiz[indexPath.row].question
        return quizCell
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
        if segue.identifier == "ShowQuiz"{
            let destination = segue.destination as! QuizViewController
            if let indexCellSelected = tableView.indexPathForSelectedRow?.row{
                destination.quizInheritedImageUrlStr = quiz[indexCellSelected].attachment?.url
                destination.quizInheritedQuestion = quiz[indexCellSelected].question
                destination.quizInheritedId = quiz[indexCellSelected].id
                destination.inheritedTips = quiz[indexCellSelected].tips!
            }
            
        }
        
    }

    
    
    
}


