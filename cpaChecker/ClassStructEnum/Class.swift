//
//  Class.swift
//  cpaChecker
//
//  Created by Steven Dito on 5/28/19.
//  Copyright © 2019 Steven Dito. All rights reserved.
//

import Foundation
import RealmSwift

class Class {
    
    var courseNum: String
    var title: String
    var courseDescription: String?
    var isAccounting: Bool
    var isBusiness: Bool
    var isEthics: Bool
    var numUnits: Int
    
    var offeredFall: Bool?
    var offeredWinter: Bool?
    var offeredSpring: Bool?
    var offeredSummer: Bool?

    
    init(courseNum: String, title: String, description: String?, isAccounting: Bool, isBusiness: Bool, isEthics: Bool, numUnits: Int, offeredFall: Bool?, offeredWinter: Bool?, offeredSpring: Bool?, offeredSummer: Bool?) {
        self.courseNum = courseNum
        self.title = title
        self.courseDescription = description
        self.isAccounting = isAccounting
        self.isBusiness = isBusiness
        self.isEthics = isEthics
        self.numUnits = numUnits
        self.offeredFall = offeredFall
        self.offeredWinter = offeredWinter
        self.offeredSpring = offeredSpring
        self.offeredSummer = offeredSummer
    }
    
}
extension Class: Hashable {
    static func == (lhs: Class, rhs: Class) -> Bool {
        return lhs.courseNum == rhs.courseNum
    }
    func hash(into hasher: inout Hasher) {
        hasher.combine(courseNum)
    }
}


func createClasses() -> [Class] {
    
    let agb214 = Class.init(courseNum: "ABG 214", title: "Agribusiness Financial Accounting", description: "Principles of financial accounting for the agriculture and food industry. Introduction of basic concepts and standards underlying financial accounting systems. Emphasizes the construction of the financial accounting statements and the impact of business transactions on information presented to interested stakeholders. Not open to students with credit in BUS 214. Course may be offered in classroom-based or hybrid format. 3 lectures, 1 activity.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let agb323 = Class.init(courseNum: "AGB 323", title: "Agribusiness Managerial Accounting", description: "Decision making using agribusiness accounting information. Focus on setting and monitoring objectives, analysis, forecasting and budgeting, business ethics, and decision making. Topics covered within the food supply chain. 3 lectures, 1 activity.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus207 = Class.init(courseNum: "BUS 207", title: "Legal Responsibilities of Business", description: "Examination of the American legal system and important legal principles for business operations, such as those involved with contracts, torts, agency, business organizations, and employment. Emphasis on how legal principles help define socially responsible conduct. Case studies. 4 lectures.", isAccounting: false, isBusiness: true, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus212 = Class.init(courseNum: "BUS 212", title: "Financial Accounting for Nonbusiness Majors", description: "Introduction to financial accounting theory and practice with an emphasis on financial statement preparation and analysis. Not open to Business majors. 4 lectures.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus214 = Class.init(courseNum: "BUS 214", title: "Financial Accounting", description: "Principles of financial accounting for Business majors. The course prepares students to understand and interpret financial statement information. Financial reporting standards are explored to give students an understanding of how financial events are reflected in financial statements. Not open to students with credit in AGB 214. 4 lectures.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus215 = Class.init(courseNum: "BUS 215", title: "Managerial Accounting", description: "Applications of accounting for making business decisions. Content includes planning and control issues including cost behavior, budget preparation, performance reporting; addresses social responsibility and employee motivational and behavioral considerations. Preparation of spreadsheet applications useful for decision-making. 4 lectures. Prerequisite: Demonstrated competency in electronic spreadsheet, word processing, and presentation applications; BUS 212 or BUS 214 or equivalent.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus301 = Class.init(courseNum: "BUS 301", title: "Global Financial Institutions and Markets", description: "Role of private and public financial institutions in allocating capital globally and promoting international commerce. Financial institutions covered include the FED, IMF, World Bank, investment banks and others. Detailed exploration of the history and functions of these institutions. 4 lectures. Prerequisite: ECON 222.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus302 = Class.init(courseNum: "BUS 302", title: "International and Cross Cultural Management", description: "Dimensions of culture and its variations within and across nations. Impact of culture on managing in a global context. Development of managerial competencies requisite to working in and supervising multicultural groups in international corporations. Frameworks for analyzing cultural and contextual influences on organizational behavior, culture shock and readjustment, expatriation and repatriation, cultural change and innovation, intercultural conflict, and ethical dilemmas. Case studies, behavioral simulations, self-assessments and fieldwork. 4 lectures. Prerequisite: Completion of GE Area A with grades of C- or better; completion of GE Areas C1, C2, D1, D2, and D3; completion of GE Area D4 or E.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus303 = Class.init(courseNum: "BUS 303", title: "Introduction to International Business", description: "Special terms, concepts, and institutions associated with the environment in which international companies operate. Students will be enabled to understand, analyze and offer solutions to global business problems. 4 lectures. Prerequisite: A grade of C- or better in ECON 222.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: false, offeredSpring: false, offeredSummer: false)
    let bus319 = Class.init(courseNum: "BUS 319", title: "Accounting Information Systems", description: "Comprehensive coverage of manual and computerized accounting processes and internal controls. 4 lectures. Prerequisite: BUS 214 or Accounting minors with credit in AGB 214.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus320 = Class.init(courseNum: "BUS 320", title: "Federal Income Taxation for Individuals", description: "Federal income taxation and planning for individuals. Federal role of taxation in the business decision-making process. Issues related to individual income tax preparation and introduction to basic property transactions. 4 lectures. Prerequisite: BUS 319.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus321 = Class.init(courseNum: "BUS 321", title: "Intermediate Accounting I", description: "Comprehensive coverage of financial reporting issues. Covers financial statements, assets other than investments and intangibles, and liabilities. 4 lectures. Prerequisite: BUS 319", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus322 = Class.init(courseNum: "BUS 322", title: "Intermediate Accounting II", description: "Comprehensive coverage of financial reporting issues. Covers investments, intangibles, equities, revenue recognition and the Cash Flows Statement. 4 lectures. Prerequisite: BUS 321 with minimum grade of C-; Business majors must have formally declared their concentration to enroll.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus342 = Class.init(courseNum: "BUS 342", title: "Fundamentals of Corporate Finance", description: "Theory and applications of financing business operations. Financial management of current and fixed assets from internal and external sources. Analysis, planning, control, and problem solving. The use of technology in the form of financial calculators and/or spreadsheets. 4 lectures. Prerequisite: BUS 214 with a grade of C- or better, or consent of instructor; and STAT 252 or any 300 level statistics course.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus346 = Class.init(courseNum: "BUS 346", title: "Principles of Marketing", description: "Development of an understanding of the marketing process: identifying target markets; developing and launching products or services; and managing pricing, promotion, and distribution strategies. 2 lectures, 2 discussions. Prerequisite: ECON 222 with a grade of C- or better for Business Administration and Economics majors; or ECON 201 with a grade of C- or better for Industrial Technology majors; or ECON 201 or ECON 222 with a grade of C- or better for all other majors; or consent of instructor.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let bus387 = Class.init(courseNum: "BUS 387", title: "Organizational Behavior", description: "Application of behavioral, social and organizational science concepts to management. Exploration of the interactions between individuals and the organizations in which they work and live. Individual, interpersonal, team, intergroup and organizational levels of analysis included in topics such as expectations, perception, communications, creativity, leadership style, cultural and ethical behavior, group dynamics, team effectiveness and work design. 4 lectures. Prerequisite: Completion of GE Area A with grades of C- or better; ECON 221; and BUS 207. Recommended: STAT 252.", isAccounting: false, isBusiness: true, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let bus391 = Class.init(courseNum: "BUS 391", title: "Information Systems", description: "Computer applications in business and industry. Information systems and integrated systems concepts, computer hardware and software, strategic uses of information systems, databases, data warehousing, decision support systems and artificial intelligence, network basics, electronic commerce, systems development, ethical use of information, employing technology in a socially responsible manner, and emerging trends and technologies in information systems. 4 lectures. Prerequisite: BUS 212 or BUS 214 for Industrial Technology and Packaging majors; BUS 214 for all other majors.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let bus401 = Class.init(courseNum: "BUS 401", title: "General Management and Strategy", description: "Application of interdisciplinary skills to business and corporate strategy analysis formulation and implementation of business, corporate and global level strategies. Consideration of interdependence between external environments and internal systems. Focus on responsibilities, tasks, and skills of general managers, including socially responsible behavior and governance. Case studies, group problem solving, experiential class activities. Capstone course of Business core curriculum. 4 seminars. Prerequisite: BUS 342, BUS 346, BUS 387, BUS 391, senior standing, and completion of one of the following: ITP 303, ITP 326, ITP 330, ITP 341, or ITP 371.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus412 = Class.init(courseNum: "BUS 412", title: "Advanced Managerial Accounting", description: "Product costing systems including hybrid costing systems, management control systems, cost allocation, activity based costing, cost information for decision making, new manufacturing environments, and strategic control systems. International dimension integrated in the course content. 4 lectures. Prerequisite: BUS 215.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: nil, offeredWinter: nil, offeredSpring: nil, offeredSummer: nil)
    let bus404 = Class.init(courseNum: "BUS 404", title: "Governmental and Social Influences on Business", description: "Analysis from legal, economic, political, and ethical perspectives, of the changing domestic and international environments of the business enterprise. Topics include administrative law, agencies and regulatory policy, antitrust law, public policy analysis, business-government relations, and corporate responsibility. Case studies. 4 lectures. Prerequisite: BUS 207 and ECON 222.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus416 = Class.init(courseNum: "BUS 416", title: "Volunteer Income Tax Assistance - Senior Project", description: "Training and practice in the preparation of state and federal individual income tax returns. Coverage of the deductions and credits applicable to individuals. Students provide free tax assistance and income tax preparation to community residents under the supervision of qualified professionals. 2 lectures, 2 activities. Prerequisite: BUS 320 or equivalent, senior standing.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: false, offeredWinter: true, offeredSpring: false, offeredSummer: false)
    let bus417 = Class.init(courseNum: "BUS 417", title: "Taxation of Corporations and Partnerships", description: "Comparative study of the taxation of C corporations and flow-through tax entities, including S corporations, partnerships and limited liability companies. 4 lectures. Prerequisite: BUS 320 or equivalent.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: false, offeredSpring: false, offeredSummer: false)
    let bus323 = Class.init(courseNum: "BUS 323", title: "Intermediate Accounting III", description: "Detailed examination of the technical and theoretical aspects of accounting for leases, pensions, income taxes, accounting changes and errors, and consolidated financial reporting. 4 lectures. Prerequisite: BUS 322", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus424 = Class.init(courseNum: "BUS 424", title: "Accounting Ethics", description: "Study of professional values underlying the accounting profession. Methods for incorporation of ethical reasoning into accounting decision-making. Role of accounting ethics in development of financial statements. 4 lectures.", isAccounting: true, isBusiness: true, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus425 = Class.init(courseNum: "BUS 425", title: "Auditing", description: "Survey of the auditing environment including institutional, ethical, and legal liability dimensions. Introduction to audit planning, assessing materiality and audit risk, collecting and evaluating audit evidence, considering the internal control structure, substantive testing, and reporting. 4 lectures. Prerequisite: BUS 322.", isAccounting: true, isBusiness: true, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus463 = Class.init(courseNum: "BUS 463", title: "Senior Project: Low Income Taxpayer Clinic", description: "Acquire fundamental knowledge of federal tax laws and procedures in a clinical setting. Practice with multiple authoritative accounting, auditing and tax databases, conduct legal research, and business writing. Resolve real world accounting, auditing and tax controversies for Low Income Taxpayer Clinic clients. Prerequisite: Senior standing; BUS 320; Graduation Writing Requirement; and approval of the Instructor.", isAccounting: true, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus384 = Class.init(courseNum: "BUS 384", title: "Human Resources Management", description: "Introduction to functional areas of the discipline including staffing, compensation, employee development and labor relations. Additional workplace issues addressed include performance and human capital management, employer legal and social responsibility for employee wellbeing, managing a diverse/global workforce, and using human resource information systems. 4 lectures. Prerequisite: Completion of GE Area A with grades of C- or better; completion of GE Areas C1 and C2; and completion of GE Areas D1-D4.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let bus410 = Class.init(courseNum: "BUS 410", title: "The Legal Environment of International Business", description: "U.S., foreign, and international law affecting international business transactions. U.S. and foreign cultural, ethical, and political norms and legal institutions, and their effect on law and business. 4 lectures. Prerequisite: BUS 207 and ECON 222.", isAccounting: false, isBusiness: true, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: false, offeredSummer: false)
    let econ221 = Class.init(courseNum: "ECON 221", title: "Microeconomics", description: "Microeconomic principles. Marginal and equilibrium analysis of commodity and factor markets in determination of price and output. Normative issues of efficiency and equity. 4 lectures.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let econ222 = Class.init(courseNum: "ECON 222", title: "Macroeconomics", description: "Introduction to economic problems. Macroeconomic analysis and principles. Aggregate output, employment, prices, and economic policies for changing these variables. International trade and finance. Issues of economic growth and development. Comparative economic systems and economies in transition. 4 lectures. Fulfills GE D2. ", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let econ303 = Class.init(courseNum: "ECON 303", title: "Economics of Poverty, Discrimination and Immigration", description: "Economic analysis of the cause, extent and impact of poverty, discrimination and immigration and of the policies designed to address these socioeconomic issues. Emphasis on the experience of African-Americans, Latinos, and women in the United States. 4 lectures. Crosslisted as ECON/HNRS 303. Fulfills GE Area D5 and USCP. Prerequisite: Junior standing; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and ECON 201 or ECON 222.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let econ304 = Class.init(courseNum: "ECON 404", title: "Comparative Economic Systems", description: "Analysis of economic systems as a set of mechanisms and institutions for decision making, and the implementation of decisions regarding income distribution, the levels of consumption and production, and the level of economic welfare. 4 lectures. Fulfills GE Area D5. Prerequisite: Junior standing; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and ECON 201 or ECON 222.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: false, offeredSpring: false, offeredSummer: false)
    let econ311 = Class.init(courseNum: "ECON 311", title: "Intermediate Microeconomics I", description: "Consumer behavior and the theory of demand; production, cost, supply functions; perfect competition; monopoly and oligopoly; labor markets. 4 lectures. Prerequisite: ECON 201; or ECON 221 and ECON 222; and MATH 141 or MATH 221.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let econ312 = Class.init(courseNum: "ECON 312", title: "Intermediate Microeconomics II", description: "Game theory; risk, uncertainty and information; choice over time; asset markets; general equilibrium; welfare economics, externalities and public goods. 4 lectures. Prerequisite: ECON 311.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let econ313 = Class.init(courseNum: "ECON 313", title: "Intermediate Macroeconomics", description: "Analysis of national income, price level, employment, international trade and economic growth. Development of the theory of national income determination. Evaluation of roles of monetary and fiscal policy. 4 lectures. Corequisite: ECON 311.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let econ339 = Class.init(courseNum: "ECON 339", title: "Econometrics", description: "Application of statistical methods useful in economics. General linear regression model. Specific issues and problems related to economic models: multicollinearity, autocorrelation, heteroscedasticity, dummy variables, lagged variables, and simultaneous equation estimation. Application and evaluation of selected examples of empirical economic research. Microcomputer applications. 4 lectures. Prerequisite: either ECON 221 and ECON 222; or ECON 201; MATH 141 or MATH 221, and STAT 252 or STAT 302.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let itp371 = Class.init(courseNum: "ITP 371", title: "Supply Chain Management in Manufacturing and Services", description: "Introduction to supply chain management and performance metrics. Supply or value chains dealing with hard goods and services from design to daily management. Project management techniques and technology for making and implementing decisions. Course may be offered in classroom-based or online format. 4 lectures. Prerequisite: A grade of C- or better, or consent of instructor, in: MATH 141 or MATH 221, and STAT 217 or STAT 218 or STAT 251 or any 300 or 400 level statistics course.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let math141 = Class.init(courseNum: "MATH 141", title: "Calculus I", description: "Limits, continuity, differentiation. Introduction to integration. 4 lectures. Crosslisted as HNRS/MATH 141. Fulfills GE Area B1; for students admitted Fall 2016 or later, a grade of C- or better in one GE Area B1 course is required to fulfill GE Area B. Prerequisite: Appropriate Math Placement Level; or MATH 117 and high school trigonometry; or MATH 118 and high school trigonometry; or MATH 119.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let math142 = Class.init(courseNum: "MATH 142", title: "Calculus II", description: "Techniques of integration, applications to physics, transcendental functions. 4 lectures. Crosslisted as HNRS/MATH 142. Fulfills GE B1; for students admitted Fall 2016 or later, a grade of C- or better in one GE B1 course is required to fulfill GE Area B. Prerequisite: MATH 141 with a grade of C- or better or consent of instructor.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let math221 = Class.init(courseNum: "MATH 221", title: "Calculus for Business and Economics", description: "Polynomial calculus for optimization and marginal analysis, and elementary integration. Not open to students with credit in MATH 142. 4 lectures. Fulfills GE Area B1; for students admitted Fall 2016 or later, a grade of C- or better in one GE Area B1 course is required to fulfill GE Area B. Prerequisite: Appropriate Math Placement Level; or MATH 117; or MATH 118.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: false, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let phil101 = Class.init(courseNum: "PHIL 101", title: "Introduction to Philosophy", description: "Foundational methods and central issues in contemporary philosophy including logic, epistemology, metaphysics and ethics. Advising and orientation to the Philosophy major for freshmen in their first quarter at Cal Poly. 4 lectures. Prerequisite: Philosophy majors only.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: false, offeredSpring: false, offeredSummer: false)
    let phil231 = Class.init(courseNum: "PHIL 231", title: "Philosophical Classics: Ethics and Political Philosophy", description: "Readings from primary philosophical texts, from the ancient and modern periods, with focus on the identification, evaluation and contemporary relevance of the central ethical and political themes and arguments presented in them. Course may be offered in classroom-based or online format. 4 lectures. Crosslisted as HNRS/PHIL 231. Fulfills GE Area C2. Prerequisite: Completion of GE Area A with grades of C- or better; or for PHIL majors GE Area A3 with a grade of C- or better. Recommended: PHIL 126.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: true)
    let phil331 = Class.init(courseNum: "PHIL 331", title: "Ethics", description: "Analyses of various traditional and contemporary positions on the difference between right and wrong, if there is one. Theories of metaethics and normative ethics including the divine command theory, relativism, intuitionism, noncognitivism, virtue ethics, egoism, utilitarianism and duty-based ethics. 4 lectures. Fulfills GE Area C4. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let phil332 = Class.init(courseNum: "PHIL 332", title: "History of Ethics", description: "The history of moral thought from Homer and the Pre-Socratics to the 20th century, and focus on theories of moral goodness and rightness of action. Related issues and areas of thought, e.g. metaphysics, theology, science, politics, psychology freedom/determinism to be considered, where they shed light on moral thought. 4 lectures. Fulfills GE Area C4. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: nil, offeredWinter: nil, offeredSpring: nil, offeredSummer: nil)
    let phil335 = Class.init(courseNum: "PHIL 335", title: "Social Ethics", description: "Examination of contemporary moral problems, solutions to these problems, and the arguments for these solutions, with emphasis on two or more of the following sample problem areas: abortion, suicide and euthanasia, capital punishment, family ethics, race relations, social justice, war, women's issues. 4 lectures. Crosslisted as PHIL 335/HNRS 336. Fulfills GE C4 and USCP. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let phil336 = Class.init(courseNum: "PHIL 336", title: "Feminist Ethics, Gender, Sexuality and Society", description: "Critical examination of the relations between gender, sexuality, ethnicity, society and ethics from feminist perspectives, with special attention paid to problems in contemporary applied ethics. Joint focus on theory and application. 4 lectures. Crosslisted as PHIL/WGS 336. Fulfills GE Area C4 and USCP. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let phil337 = Class.init(courseNum: "PHIL 337", title: "Business Ethics", description: "Critical examination of ethical problems that arise in business. 4 lectures. Fulfills GE Area C4. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: false, offeredWinter: true, offeredSpring: false, offeredSummer: false)
    let phil339 = Class.init(courseNum: "PHIL 339", title: "Biomedical Ethics", description: "Critical examination of problems in biomedical ethics, proposed solutions to these problems, and the arguments for such solutions. Emphasis on two or more of the following sample problem areas: concepts of health and disease, human experimentation, informed consent, behavior control, genetic intervention, new birth technologies, euthanasia and physician-assisted dying. 4 lectures. Fulfills GE Area C4. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: false, offeredSpring: true, offeredSummer: false)
    let phil340 = Class.init(courseNum: "PHIL 340", title: "Environmental Ethics", description: "Analyses of various positions on the moral status of nonhuman entities and problems such as the treatment of animals, wilderness preservation, population, pollution and global warming. 4 lectures. Fulfills GE Area C4. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: true, offeredWinter: false, offeredSpring: false, offeredSummer: false)
    let phil341 = Class.init(courseNum: "PHIL 341", title: "Professional Ethics", description: "Moral problems as they arise in professions such as law, medicine, engineering, research and education: deception, paternalism, confidentiality, discrimination and others. Consideration of various professional codes of ethics. 4 lectures. Fulfills GE Area C4. Prerequisite: Junior standing or Philosophy major; completion of GE Area A with grades of C- or better; completion of one course in GE Area B1 with a grade of C- or better; and completion of GE Area C2.", isAccounting: false, isBusiness: false, isEthics: true, numUnits: 4, offeredFall: false, offeredWinter: false, offeredSpring: true, offeredSummer: false)
    let stat251 = Class.init(courseNum: "STAT 251", title: "Statistical Inference for Management I", description: "Descriptive statistics. Probability and counting rules. Random variables and probability distributions. Sampling distributions and point estimation. Confidence intervals and tests of hypotheses for a single mean and proportion. 4 lectures. Fulfills GE Area B1; for students admitted Fall 2016 or later, a grade of C- or better in one GE Area B1 course is required to fulfill GE Area B. Prerequisite: Appropriate Math Placement Level or MATH 118.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let stat252 = Class.init(courseNum: "STAT 252", title: "Statistical Inference for Management II", description: "Confidence intervals and tests of hypotheses for two means and two proportions. Introduction to ANOVA, regression, correlation, multiple regression, time series, and forecasting. Statistical quality control. Enumerative data analysis. Substantial use of statistical software. Course may be offered in classroom-based or online format. 5 lectures. Fulfills GE B1; for students admitted Fall 2016 or later, a grade of C- or better in one GE B1 course is required to fulfill GE Area B. Prerequisite: STAT 251 with a minimum grade of C- or consent of instructor.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 5, offeredFall: true, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    let stat301 = Class.init(courseNum: "STAT 301", title: "Statistics I", description: "Introduction to statistics for mathematically inclined students, focused on process of statistical investigations. Observational studies, controlled experiments, randomization, confounding, randomization tests, hypergeometric distribution, descriptive statistics, sampling, bias, binomial distribution, significance tests, confidence intervals, normal model, t-procedures, two-sample procedures. Substantial use of statistical software. 4 lectures. Corequisite: MATH 141.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: true, offeredWinter: true, offeredSpring: false, offeredSummer: false)
    let stat302 = Class.init(courseNum: "STAT 302", title: "Statistics II", description: "Continued study of the process, concepts, and methods of statistical investigations. Association, chi-square procedures, one-way ANOVA, multiple comparisons, two-way ANOVA with interaction, simple linear regression, correlation, prediction, multiple regression. Substantial use of statistical software. 4 lectures. Prerequisite: STAT 301.", isAccounting: false, isBusiness: true, isEthics: false, numUnits: 4, offeredFall: false, offeredWinter: true, offeredSpring: true, offeredSummer: false)
    // need ability for user to create their own classes
    
    
    var classes: [Class] = []
    
    classes.append(agb214)
    classes.append(agb323)
    classes.append(bus207)
    classes.append(bus212)
    classes.append(bus214)
    classes.append(bus215)
    classes.append(bus301)
    classes.append(bus302)
    classes.append(bus303)
    classes.append(bus319)
    classes.append(bus320)
    classes.append(bus321)
    classes.append(bus322)
    classes.append(bus342)
    classes.append(bus346)
    classes.append(bus387)
    classes.append(bus391)
    classes.append(bus401)
    classes.append(bus412)
    classes.append(bus404)
    classes.append(bus416)
    classes.append(bus417)
    classes.append(bus323)
    classes.append(bus424)
    classes.append(bus425)
    classes.append(bus463)
    classes.append(bus384)
    classes.append(bus410)
    classes.append(econ221)
    classes.append(econ222)
    classes.append(econ303)
    classes.append(econ304)
    classes.append(econ311)
    classes.append(econ312)
    classes.append(econ313)
    classes.append(econ339)
    classes.append(itp371)
    classes.append(math141)
    classes.append(math142)
    classes.append(math221)
    classes.append(phil101)
    classes.append(phil231)
    classes.append(phil331)
    classes.append(phil332)
    classes.append(phil335)
    classes.append(phil336)
    classes.append(phil337)
    classes.append(phil339)
    classes.append(phil340)
    classes.append(phil341)
    classes.append(stat251)
    classes.append(stat252)
    classes.append(stat301)
    classes.append(stat302)
    
    
    return classes
}
