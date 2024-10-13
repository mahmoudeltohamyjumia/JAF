*** Settings ***
Documentation     test suite
Force Tags       BID-REQ-002
Resource         ../../../../Resources/common.robot
*** Variables ***

*** Test Cases ***
01. get Curriencies
    [Tags]  valid    vcs    smoke    Positive
    Log    ok