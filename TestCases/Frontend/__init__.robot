*** Settings ***
Resource     ../../Resources/common.robot
Suite Setup    log    Setup
Suite Teardown    log    teardown
Test Setup     Record Screen
Test Teardown  Stop Record


*** Keywords ***
generate tokens
    log    tokens