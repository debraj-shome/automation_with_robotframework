*** Settings ***
Library             SeleniumLibrary

Resource             ../Resources/Variables.robot
Resource             ../Resources/CommonKeywords.robot
Resource             ../Resources/LoginKeywords.robot


Suite Setup       Open Browser To OrangeHRM
Suite Teardown    Close Application


Test Setup        Go To    ${URL}
Test Teardown     Capture Screenshot On Failure


*** Test Cases ***
TC_ORANGEHRM_001 - Login With Valid Username And Valid Password
    [Documentation]    Verify that a registered user can log in successfully.
    [Tags]    Smoke    Regression    Positive

    Login With Credentials
    ...    ${VALID_USERNAME}
    ...    ${VALID_PASSWORD}

    Verify Dashboard

    Logout From OrangeHRM

TC_ORANGEHRM_002 - Login With Invalid Username And Valid Password
    [Documentation]    Verify login is rejected for an unregistered username.
    [Tags]    Regression    Negative

    Login With Credentials
    ...    ${INVALID_USERNAME}
    ...    ${VALID_PASSWORD}

    Verify Invalid Credentials Message

TC_ORANGEHRM_003 - Login With Valid Username And Invalid Password
    [Documentation]    Verify login is rejected for an invalid password.
    [Tags]    Regression    Negative

    Login With Credentials
    ...    ${VALID_USERNAME}
    ...    ${INVALID_PASSWORD}

    Verify Invalid Credentials Message

TC_ORANGEHRM_004 - Login With Uppercase Password
    [Documentation]    Verify login fails when the valid password is entered in uppercase.
    [Tags]    Regression    Negative    Boundary

    Login With Credentials
    ...    ${VALID_USERNAME}
    ...    ${UPPERCASE_PASSWORD}

    Verify Invalid Credentials Message

TC_ORANGEHRM_005 - Login Without Username And Password
    [Documentation]    Verify required validation messages when both fields are empty.
    [Tags]    Regression    Negative    Validation

    Click Login Button

    Verify Username Required Message
    Verify Password Required Message

TC_ORANGEHRM_006 - Login With Password Only
    [Documentation]    Verify username required validation when only password is entered.
    [Tags]    Regression    Negative    Validation

    Enter Password
    ...    ${VALID_PASSWORD}

    Click Login Button

    Verify Username Required Message

TC_ORANGEHRM_007 - Login With Username Only
    [Documentation]    Verify password required validation when only username is entered.
    [Tags]    Regression    Negative    Validation

    Enter Username
    ...    ${VALID_USERNAME}

    Click Login Button

    Verify Password Required Message

TC_ORANGEHRM_008 - Login With SQL Injection Payload
    [Documentation]    Verify SQL injection payload does not bypass authentication.
    [Tags]    Security    Negative    SQLInjection

    Login With Credentials
    ...    ${SQL_INJECTION}
    ...    ${SQL_INJECTION}

    Verify Invalid Credentials Message

TC_ORANGEHRM_009 - Login With XSS Payload
    [Documentation]    Verify XSS payload does not bypass authentication or execute script.
    [Tags]    Security    Negative    XSS

    Login With Credentials
    ...    ${XSS_PAYLOAD}
    ...    ${XSS_PAYLOAD}

    Verify Login Page Is Displayed