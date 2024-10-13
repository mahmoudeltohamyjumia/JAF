import json
from selenium import webdriver
from axe_selenium_python import Axe
from robot.libraries.BuiltIn import BuiltIn
from robot.api.deco import keyword
from robot.api import logger


class AxeLibrary:
    """Robot Framework library for running Axe accessibility tests."""

    ROBOT_LIBRARY_SCOPE = 'GLOBAL'

    def __init__(self):
        self.axe_instance = None
        self.results = None

    @keyword("Run Accessibility Tests")
    def run_accessibility_tests(self, result_file, axe_script_url=None, context=None, options=None,
                                lib_instance='SeleniumLibrary'):
        """
        Executes accessibility tests in the current page by injecting axe-core javascript and writes results to `result_file` (json).
        Returns result statistics.

        | Attribute                 | Description                                          |
        |---------------------------|-----------------------------------------------------|
        | result_file                | File to store accessibility test results (.json).      |
        | axe_script_url             | axe.js file path.                                     |
        | context                    | Defines the scope of the analysis (DOM element).     |
        | options                    | Set of options that change how axe.run works.          |
        | lib_instance               | Alternate library to use in place of SeleniumLibrary. |
        """

        seleniumlib = BuiltIn().get_library_instance(lib_instance)
        driver = seleniumlib.driver

        self.axe_instance = Axe(driver, axe_script_url) if axe_script_url else Axe(driver)
        self.axe_instance.inject()
        self.results = self.axe_instance.run(context, options)
        self.write_results(result_file)

        # Generate result dictionary and log info
        result_dict = self.get_accessibility_stats()
        logger.info(result_dict)
        return result_dict

    def write_results(self, result_file):
        """Writes accessibility test results to a JSON file."""
        with open(result_file, 'w') as f:
            json.dump(self.results, f, indent=3)

    def get_accessibility_stats(self):
        """Calculates and returns accessibility statistics."""
        return {
            "inapplicable": len(self.results["inapplicable"]),
            "incomplete": len(self.results["incomplete"]),
            "passes": len(self.results["passes"]),
            "violations": len(self.results["violations"])
        }

    @keyword("Get Json Accessibility Result")
    def get_json_accessibility_result(self):
        """
        Returns accessibility test result in JSON format. Needs to be used after `Run Accessibility Tests` keyword.
        """
        axe_result = json.dumps(self.results, indent=3)
        logger.info(axe_result)
        return axe_result

    @keyword("Log Readable Accessibility Result")
    def log_readable_accessibility_result(self):
        """
        Inserts readable accessibility result into `log.html`. Needs to be used after `Run Accessibility Tests` keyword.
        """

        violation_results = self.axe_instance.report(self.results["violations"])
        incomplete_results = self.axe_instance.report(self.results["incomplete"])


        results = violation_results.split("Rule Violated:")

        for result in results:
            if "Impact Level" in result:
                final_result = result.strip()
                chunks = final_result.split("\n")

                # Simplified HTML logging (optional styling can be added)
                html_text = f"""
                <table style="width:100%">
                <tr>
                <th>Issue</th>
                <th>URL</th>
                <th>Impact</th>
                <th>Tags</th>
                </tr>
                <tr>
                <td>{chunks[0]}</td>
                <td><a href="{chunks[1].split('URL: ')[-1]}">Link</a></td>
                <td style="color:{self.get_impact_color(chunks[2].split('Impact Level: ')[-1])}">{chunks[2].split('Impact Level: ')[-1]}</td>
                <td>{chunks[3].split('Tags: ')[-1]}</td>
                </tr>
                </table>
                """

                logger.info(html_text, html=True)

        results = incomplete_results.split("Rule Violated:")

        for result in results:
            if "Impact Level" in result:
                final_result = result.strip()
                chunks = final_result.split("\n")
                print(chunks)

                # Simplified HTML logging (optional styling can be added)
                html_text = f"""
                <table style="width:100%">
                <tr>
                <th>Issue</th>
                <th>URL</th>
                <th>Impact</th>
                <th>Tags</th>
                </tr>
                <tr>
                <td>{chunks[0]}</td>
                <td><a href="{chunks[1].split('URL: ')[-1]}">Link</a></td>
                <td style="color:{self.get_impact_color(chunks[2].split('Impact Level: ')[-1])}">{chunks[2].split('Impact Level: ')[-1]}</td>
                <td>{chunks[3].split('Tags: ')[-1]}</td>
                </tr>
                </table>
                """

                logger.info(html_text, html=True)

    def get_impact_color(self, impact):
        """Returns HTML color code based on impact level."""
        if impact == "critical" or impact == "serious":
            return "red"
        elif impact == "moderate":
            return "orange"
        elif impact == "minor":
            return "blue"
        else:
            return "green"