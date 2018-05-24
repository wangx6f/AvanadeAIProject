//
//  Constants.swift
//  AvanadeAIProject
//
//  Created by Xinyuan Wang on 1/16/18.
//  Copyright © 2018 Avanade. All rights reserved.
//

import Foundation
import UIKit

struct Constants {
    
    static public let commentTableCellReuseIdentifier = "commentTableCell"
    static public let commentTableCellNIBName = "CommentTableCell"
    
    static public let detailTableCellReuseIdentifier = "detailTableCell"
    static public let detailTableCellNIBName = "DetailTableCell"
    
    static public let collectionCellReuseIdentifier = "imageCollectionCell"
    static public let collectionCellNIBName = "ImageCollectionCell"
    
    static public let genderOptions = ["Optional","Male","Female","Other"]
    static public let majorOptions = ["Optional",
                                      "Accounting",
                                      "Aerospace Engineering",
                                      "Agribusiness Management",
                                      "Agricultural Education",
                                      "Animal & Veterinary&nbsp; Science",
                                      "Animal Health Science",
                                      "Anthropology",
                                      "Apparel Merchandising & Mgt",
                                      "Architecture",
                                      "Art",
                                      "Biology",
                                      "Botany",
                                      "Business",
                                      "Cal Poly University",
                                      "Chemical Engineering",
                                      "Chemistry",
                                      "Civil Engineering",
                                      "Communication",
                                      "Computer Information Systems",
                                      "Computer Science",
                                      "Ctr for Science & Math Educ",
                                      "Dance",
                                      "E-Business - All College",
                                      "Early Childhood Studies",
                                      "Economics",
                                      "Education",
                                      "Education Specialist",
                                      "Educational Leadership",
                                      "Electrical & Computer Engr",
                                      "Engineering - All College",
                                      "Engineering Management",
                                      "Engineering Tech-Manufacture",
                                      "Engineering Tech-Mechanical",
                                      "Engineering Technology",
                                      "English",
                                      "Engr Tech-Construction",
                                      "Engr Tech-Electronics/Computer",
                                      "Ethnic & Women's Studies",
                                      "Finance, Real Estate & Law",
                                      "Food Science and Technology",
                                      "Food and Nutrition",
                                      "Foreign Languages",
                                      "Geography",
                                      "Geological Sciences",
                                      "Grad Bus Admin - All College",
                                      "Graduate-Professional Studies",
                                      "History",
                                      "Hotel & Restaurant Management",
                                      "Industrial & Manufacturing Egr",
                                      "Industrial Engineering",
                                      "Interdisciplinary General Ed",
                                      "Interior Architecture",
                                      "International Agriculture",
                                      "International Business & Mkt",
                                      "International Programs",
                                      "Kinesiology & Health Promotion",
                                      "Landscape Architecture",
                                      "Learning Resource Center",
                                      "Liberal Studies",
                                      "Library",
                                      "Management & Human Resources",
                                      "Manufacturing Engineering",
                                      "Master of Public Adminis",
                                      "Materials Engineering",
                                      "Mathematics",
                                      "Mechanical Engineering",
                                      "Microbiology",
                                      "Military Science & Leadership",
                                      "Music",
                                      "Philosophy",
                                      "Physics",
                                      "Plant Science",
                                      "Political Science",
                                      "Psychology",
                                      "Regenerative Studies",
                                      "Science - All College",
                                      "Science, Technology, Society",
                                      "Social Work",
                                      "Sociology",
                                      "Spanish",
                                      "Statistics",
                                      "Systems Engineering",
                                      "Teacher Education",
                                      "Technology & Operations Mgmt",
                                      "Theatre",
                                      "Urban & Regional Planning",
                                      "Zoology"]
    
    static public let lightBlue = UIColor(red: CGFloat(0.24), green: CGFloat(0.47), blue: CGFloat(0.85), alpha: CGFloat(1))
    
    static public let AVANADE_TERMS_URL = "https://www.avanade.com/en/utility/terms-of-use"
    
    static public let AVANADE_HOME_URL = "https://www.avanade.com/"
}
