# Jumia VCS Testing Documentation

The objective of this section is to present the architecture and Installation Guidelines of automated tests as it was deployed for the Jumia VCS project.

--------------------
## Test Automation Architecture
the overall test architecture is explained in the conf page.


## Repository details

a) Directory structure of our current Templates



## Continuous Testing

the CI/CD pipeline structure, it broken down into the following stages:

1. **Commit & push**: When tests are finished/ready it is committed to this shared repository (gitlab), with integration with the central code base of the whole alias number project.

2. **Automated Testing**: Once any trigger mechanism is applied (push/branch merge/schedule/upstream trigger), the robot tests are automatically triggered. There are various testing methodologies that can be used to ensure an application looks and behaves as expected and ensure maximum coverage. 

3. **Deployment**: In the final stage, robot test report is rolled out into gitlab pages. the report is shared to the concerned stackholders.


## Process Flow and Git Branching Strategy

### local development
The process of using git in a project depends mainly on the following process:
1. clone the Git repository as a working copy if not exists, for each feature/cards create a new branch
2. You modify the working copy by adding/editing files.
3. If necessary, update the working copy by taking other tester's changes from their branched using cherry picking or merge commit.
4. You review the changes before commit. If everything is fine, then push the changes to the repository.
5. After committing, the tests will trigger and report will be generated, fix the errors on the branch if exists, and so on.


### branching
we follow the **Gitlab Flow** Branching as it is more suitable for the testing needs as it is more friendly for the Continuous Delivery and Continuous Integration of testing against the development code.

1. Anything in the **master**, **develop** is deployable (ready tests for the production/pre-production).
2. both branched are with infinite life time and highest stability
3. deployment from pre-production to production the branches develop -> master are merged to keep it most stable and updated.
4. any branch can be taken from develop and will be merged into develop, no direct commits on master (feature branches).
5. Test all commits, not only ones on master Run all the tests on all commits.

