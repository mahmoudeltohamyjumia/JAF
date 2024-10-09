from io import StringIO
# ToDo: enhance the report, use jinja and extract test data
class ReportListener:
    ROBOT_LISTENER_API_VERSION = 3

    def __init__(self):
        # Use StringIO to capture output in memory
        self.output = StringIO()
        self.output.write("<!DOCTYPE html><html><head><title>VCs Automation Report</title></head><body><table>")
        self.output.write("<tr><th>Test</th><th>Status</th></tr>")

    def close(self):
        self.output.write("</table></body></html>")
        # Access the HTML content as a string
        html_content = self.output.getvalue()
        # Now you can write it to a file or return it directly
        with open('compliance-report.html', 'w') as f:
            f.write(html_content)

    def end_test(self, data, result):
        self.output.write(f"<tr><td>{result.name}</td><td>{result.status}</td></tr>")

