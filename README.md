# OrangeHRM Automation with Robot Framework

## Project Overview

This project contains automated UI test cases for the **OrangeHRM web application** using **Robot Framework** and **SeleniumLibrary**.

The project demonstrates web automation testing, reusable keywords, test execution, failure screenshots, and automated test reporting in HTML and PDF formats.

## Technologies Used

* Python
* Robot Framework
* SeleniumLibrary
* Selenium WebDriver
* ReportLab
* Google Chrome
* Visual Studio Code

## Application Under Test

OrangeHRM Demo Application:

https://opensource-demo.orangehrmlive.com/

## Project Structure

```text
automation_with_robotframework/
│
├── Test Cases/
│   └── LoginTests.robot
│
├── Resources/
│   ├── Variables.robot
│   ├── CommonKeywords.robot
│   └── LoginKeywords.robot
│
├── Scripts/
│   └── generate_pdf_report.py
│
├── Results/
│   ├── output.xml
│   ├── log.html
│   ├── report.html
│   └── Test-Execution-Report.pdf
│
├── Screenshots/
│   └── .gitkeep
│
├── requirements.txt
├── .gitignore
└── README.md
```

## Automated Test Scenarios

### Login Module

* Verify login with valid username and valid password.
* Verify login with valid username and invalid password.
* Verify login with invalid username and valid password.
* Verify that the OrangeHRM dashboard is displayed after successful login.
* Verify invalid credentials error message.

## Prerequisites

Before running the project, make sure the following software is installed:

* Python
* Google Chrome
* Visual Studio Code

## Installation

Clone this repository:

```bash
git clone <your-repository-url>
```

Navigate to the project folder:

```bash
cd automation_with_robotframework
```

Install the required dependencies:

```bash
pip install -r requirements.txt
```

## Run the Automated Tests

Run the OrangeHRM test cases using:

```bash
robot -d Results "Test Cases/LoginTests.robot"
```

After execution, Robot Framework generates the following files:

```text
Results/
├── output.xml
├── log.html
└── report.html
```

## Test Reports

### HTML Report

Robot Framework automatically generates:

* `report.html` – Test execution summary.
* `log.html` – Detailed test execution logs.
* `output.xml` – Raw test execution result data.

## Generate PDF Report

After executing the Robot Framework tests, generate the PDF report using:

```bash
python Scripts/generate_pdf_report.py
```

The PDF report will be generated at:

```text
Results/Test-Execution-Report.pdf
```

The PDF report includes:

* Total number of test cases
* Passed test cases
* Failed test cases
* Test case names
* Test execution status
* Failure messages

## Failure Screenshots

When a test fails, a screenshot can be captured to help identify the issue.

Screenshots are stored in:

```text
Screenshots/
```

## Requirements

The required Python packages are listed in `requirements.txt`:

```text
robotframework
robotframework-seleniumlibrary
reportlab
```

Install all dependencies using:

```bash
pip install -r requirements.txt
```

## Author

**Debraj Shome**

QA Engineer | Software Testing | Test Automation

## Future Improvements

* Add PIM module automation.
* Automate Add Employee functionality.
* Add Leave module test cases.
* Implement data-driven testing.
* Add screenshot capture for failed test cases.
* Add Excel test reporting.
* Integrate GitHub Actions for CI/CD.
