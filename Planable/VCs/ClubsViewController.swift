//
//  ClubsViewController.swift
//  Planable
//
//  Created by Terry Zhuang on 5/14/21.
//

import UIKit

class ClubsViewController: UIViewController {

    @IBOutlet weak var clubTableView: UITableView!
    
    var searchText = ""
    var clubs = ["4Boston", "Accounting Academy", "Acoustics", "African Student Organization", "Against The Current Acapella", "AHANA Graduate Student Association", "AHANA Management Academy", "AHANA Pre-Law Student Association", "AIDS Awareness Committee", "Al Noor: The Boston College Middle East and Islamic Journal", "Allies", "Alpha Sigma Nu", "Ambassadors", "American Chemical Society", "American Red Cross", "Americans for Informed Democracy", "Amnesty International", "Animal Advocates", "Anime of Boston College", "Appalachia Volunteers", "Arab Students Association", "Army ROTC", "Arrupe International Immersion", "Art Club", "Ascend", "Asian Baptist Student Koinonia", "Asian Christian Fellowship", "Asinine Sketch and Improv Comedy", "Avid Listeners of Boston College", "Association of Latino Professionals in Finance and Accounting", "Athletes in Action Sports Ministry", "BC ALIVE", "BC bOp! – Jazz Ensemble", "BC Television", "Baking Club", "Baseball, club", "Basketball, Men's & Women's club", "Bellarmine Law Society", "Best Buddies", "Beta Gamma Sigma", "Bike BC", "Black Experience in America Through Song", "Black Law Students Association (BLSA)", "Black Student Forum", "Board of Student Advisers - Law School", "Boston Liturgical Dance Ensemble", "Boston College Symphony Orchestra", "Bostonians, The", "Buddhism Club", "Business and Law Society", "Bystander Intervention Education", "Campus Activities Board", "Campus School Volunteers", "Cancer Affects Siblings Too", "Cape Verdean Student Association", "Caribbean Culture Club", "Carroll School of Management Honors Program", "Catholic Relief Services Student Ambassadors", "Chamber Music Society", "Charity: water", "Cheerleading", "Chess Club", "Chemistry Club - American Chemical Society Student Chapter", "Chinese Students Association", "Christian Legal Society, BC Law School", "Circle K", "Class Councils", "Climate Justice at Boston College", "Club Sports Executive Board", "Coaching Corps", "College Bowl", "College Democrats", "College Republicans", "Committee for Creative Enactments", "Common Tones", "Computer Science Society", "Conspiracy Theory", "Consult Your Community", "Consulting Club", "Contemporary Theater" ,"Conversations About Social and Environmental (CASE) Impact", "Cooking Club", "Crew, Men's club", "CSOM Honors Program", "CSON SENATE", "Cuban-American Student Association", "Cura Program", "Cycling, Coed", "Dance Ensemble", "Dance Organization", "Dialogue - Undergraduate Essay Journal", "Dominican Association", "Dramatics Society", "Duihua", "Dynamics", "Eagle EMS", "Eagle Political Society", "Eagle Volunteers", "Eagles for Israel", "Economics Association", "EcoPledge", "Education For Students By Students", "Elections Committee", "Electronic State of Mind", "Elements: The Undergraduate Research Journal", "Emerging Leader Program", "English Language Learners", "Environmental Law Society - ELS", "Episcopal Eagles", "Equestrian Team, Coed", "Esports Club", "Ethos - Student Bioethics Research Journal", "EXCEL Coaches", "FACES", "Fashion Club", "Federalist Society", "Females Incorporating Sisterhood Through Step (F.I.S.T.S.)", "Festival of Friendship", "Field Hockey, Coed", "Figure Skating, Coed", "Finance Academy", "First-Generation Club", "First Year Service Program", "French Club", "Fuego del Corazon", "Full Swing", "Fulton Debating Society", "Gamma Kappa Alpha (Italian)", "The Gavel", "Generation Citizen", "Geology Association", "German Club", "Global Medical Brigades of Boston College", "Global Zero", "GlobeMed", "Golden Eagles Dance Team", "Golden Key International Honour Society", "Golf, Coed", "Grad Tech Club", "Graduate Consortium in Women's Studies", "Graduate Education Association (GEA)", "Graduate History Alliance", "Graduate Management Association", "Graduate Nurses' Association", "Graduate Student Association", "Graduate Women in Business", "Gratia Plena", "Habitat for Humanity", "Hawai'i Club", "Health Coaches", "Heights Boys and Girls Club", "Heights, Inc.", "Heightsmen", "Hellenic Society", "Hello... Shovelhead!", "Hillel", "Hollywood Eagles", "Hoops for Hope", "I AM THAT GIRL: Boston College", "Ice Hockey, Men's & Women's", "Ignatian Family Teach-in for Justice", "Ignatian Society", "Il Circolo Italiano", "Information Systems Academy", "Intellectual Property and Technology Forum, Law School", "Interfaith Coalition", "International Club", "InterVarsity Christian Fellowship", "Investment Banking, Sales & Trading Club", "Investment Club", "Iranian Culture Club", "Irish Dance", "Irish Society", "Jamaica Magis", "Jammin' Toast", "Japan Club", "Jemez Pueblo Service Exchange Program", "Jenks Leadership Program", "Kairos", "Kaleidoscope International Journal", "Knights of Columbus of Boston College", "Korean Students Association", "L'Association Haitienne", "Lacrosse, Men's and Women's", "Lamda Law Students Association", "Latin American Business Club", "Latin American Law Students Association", "Law Students Association", "LGBC - Lesbian, Gay, and Bisexual Community at BC", "Laughing Medusa, The", "LeaderShape Institute", "Lean In", "Let’s Get Ready BC", "Liturgical Arts Group", "Loyola Volunteers", "LSOE Student Senate", "LTS Learning to Serve", "Madrigal Singers", "Marketing Academy", "Mathematics Society", "Medical Humanities Journal", "Medical Journal Club", "Medlife", "Mendel Society", "Mentoring Through the Arts", "Middle Eastern and Islamic Studies", "Ministry of Silly Walks", "Mock Trial Program", "Model United Nations", "Mt. Alvernia Make a Difference", "Mu Kappa Tau (Marketing)", "Multi-Cultural Christian Fellowship", "Music Guild", "Musical Theatre Wing", "Muslim Student Association", "My Mother's Fleabag", "NETwork Against Malaria", "Niche: Biology Club", "Omicron Delta Epsilon (Economics)", "On Tap", "Orchestra, Boston College Symphony", "Order of the Cross and Crown (Seniors in A & S)", "Organization of Latin American Affairs", "Orthodox Christian Fellowship", "Outdoor Club", "Peer Advisers, Career Center", "Perr Advisors, Carroll School Pep Band", "Phaymus Dance Entertainment", "Phi Beta Kappa (Liberal Arts)", "Philippine Society", "Philosophical Society", "Policy Council of Boston College", "Portfolio Challenge", "Pre-Dental Society", "Productions", "Pro-Life Club", "Project Sunshine", "Project Swim", "Psi Chi", "Public Health Club", "Quality of Student Life Committee", "Quiet Waters", "Rallying Efforts Against Contemporary Trafficking", "Random Acts of Kindness Club", "REACT to FILM Boston College", "Reading Group, The", "Ready, Set, PUNCHLINE!", "Real Estate Club", "Real Food", "Relay for Life", "Residence Hall Association", "Retro Gaming Club", "Rugby, Men's & Women's", "Sailing Team, BC", "Science Club for Girls", "Screaming Eagles Marching Band", "Senior Week Committee", "Sexual Chocolate", "Sharps", "Shaw Leadership Program", "Sigma Pi Sigma (Physics)", "Sigma Theta Tau (Nursing)", "Slavic Club", "Smart Woman Securities", "Soccer, Men's & Women's", "Society of Physics Students", "Sons of St. Patrick", "Soul, Love, And Meaning!(SLAM!)", "South Asian Student Association", "Southeast Asian Student Association", "Special Olympics", "Sports Business Society", "Squash, Men's & Women's", "Start @ Shea", "St. Thomas More Society", "Student Admission Program", "Student Association", "Student Business Consortium", "Student Conduct Board", "Student Martial Arts Club", "Student Nurses Association", "Student Organization Funding Committee", "Students for a Sensible Drug Policy", "Students for Education Reform", "Students for Justice in Palestine", "Students Taking Initiative to Creative Heights (STITCH)", "Stylus", "Sub Turri Yearbook", "Symphonic Band", "Symphony Orchestra", "Synergy Hip Hop Dance Company", "Table Tennis", "Taiwanese Cultural Organization", "Torch, The", "Theater Department Workshop", "Timmy Global Health", "To Write Love On Her Arms", "Transfer Ambassador Program", "Ultimate Frisbee, Men's and Women's", "Undergraduate Government of Boston College", "UGBC Leadership Academy", "UGBC, AHANA Leadership Council", "UGBC, GLBTQ Leadership Council", "UGBC, Student Assembly", "UGBC, Council for Students with Disabilities", "Ultimate Frisbee, Men's & Women's", "United Front", "University Chorale", "University Wind Ensemble", "UPrising Dance Crew", "Venture Competition", "Vietnamese Students Association", "Voices of Imani", "Volleyball, Men's & Women's", "Water Polo, Men's & Women's", "Welles Remy Crowther Red Bandana 5k", "WeRunBC", "Wishmakers On Campus", "Women's Law Center", "Women’s Summit", "Women In Business", "Word of Mouth", "Writers’ Circle", "WZBC 90.3 FM", "WZBC SPORTS", "WZBC Sports Radio"]
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        clubTableView.delegate = self
        clubTableView.dataSource = self
        
    }
    

}
extension ClubsViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return clubs.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = clubTableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = clubs[indexPath.row]
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 60
    }
    
    
}
