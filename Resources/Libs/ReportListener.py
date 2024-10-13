from robot.api import ResultVisitor
from robot.utils.markuputils import html_format
from robot.api import logger


class SuiteResults(ResultVisitor):

    def __init__(self):
        self.suite_list = []
        self.test_list = []
    
    def visit_test(self, test):
        test_json = {
            "Suite Name" : test.parent.name,
            "Test Name" : test.name,
            "Test Id" : test.id,
            "Status" : test.status,
            "Documentation" : html_format(test.doc),
            "Time" : test.elapsedtime,
            "Message" : html_format(test.message),
            "Tags" : test.tags
        }
        self.test_list.append(test_json)

    def start_suite(self, suite):
        if suite.tests:
            try:
                stats = suite.statistics.all
            except:
                stats = suite.statistics
            
            try:
                skipped = stats.skipped
            except:
                skipped = 0

            suite_json = {
                "Name" : suite.longname,
                "Id" : suite.id,
                "Status" : suite.status,
                "Documentation" : html_format(suite.doc),
                "Total" : stats.total,
                "Pass" : stats.passed,
                "Fail" : stats.failed,
                "Skip" : skipped,
                "Time" : suite.elapsedtime,
            }
            self.suite_list.append(suite_json)
