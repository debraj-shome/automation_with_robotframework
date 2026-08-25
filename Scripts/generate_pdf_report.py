from pathlib import Path
import xml.etree.ElementTree as ET

from reportlab.lib import colors
from reportlab.lib.enums import TA_CENTER
from reportlab.lib.pagesizes import A4
from reportlab.lib.styles import getSampleStyleSheet, ParagraphStyle
from reportlab.lib.units import mm
from reportlab.platypus import Paragraph, SimpleDocTemplate, Spacer, Table, TableStyle


PROJECT_ROOT = Path(__file__).resolve().parent.parent
OUTPUT_XML = PROJECT_ROOT / "Results" / "output.xml"
OUTPUT_PDF = PROJECT_ROOT / "Results" / "Test-Execution-Report.pdf"


def read_results(path):
	root = ET.parse(path).getroot()
	tests = []
	for test in root.findall(".//test"):
		status = test.find("status")
		documentation = test.findtext("doc", default="").strip()
		tests.append(
			{
				"name": test.get("name", "Unnamed test"),
				"status": status.get("status", "UNKNOWN") if status is not None else "UNKNOWN",
				"elapsed": status.get("elapsed", "") if status is not None else "",
				"details": documentation or "No test documentation provided.",
			}
		)
	return tests


def build_pdf(tests, path):
	passed = sum(test["status"] == "PASS" for test in tests)
	failed = sum(test["status"] == "FAIL" for test in tests)
	skipped = sum(test["status"] == "SKIP" for test in tests)

	styles = getSampleStyleSheet()
	title_style = ParagraphStyle(
		"ReportTitle", parent=styles["Title"], alignment=TA_CENTER, spaceAfter=8
	)
	cell_style = ParagraphStyle("Cell", parent=styles["BodyText"], fontSize=8, leading=10)
	story = [
		Paragraph("Robot Framework Test Execution Report", title_style),
		Paragraph(f"Source: {OUTPUT_XML.name}", styles["Normal"]),
		Spacer(1, 8),
	]

	summary = Table(
		[["Total", "Passed", "Failed", "Skipped"], [len(tests), passed, failed, skipped]],
		colWidths=[35 * mm] * 4,
	)
	summary.setStyle(
		TableStyle(
			[
				("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#1f4e79")),
				("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
				("ALIGN", (0, 0), (-1, -1), "CENTER"),
				("GRID", (0, 0), (-1, -1), 0.5, colors.grey),
				("BOTTOMPADDING", (0, 0), (-1, 0), 6),
				("TOPPADDING", (0, 0), (-1, 0), 6),
			]
		)
	)
	story.extend([summary, Spacer(1, 14)])

	rows = [["Test case", "Status", "Details"]]
	for test in tests:
		duration = f"Elapsed: {test['elapsed']}" if test["elapsed"] else ""
		details = f"{test['details']} {duration}".strip()
		rows.append(
			[
				Paragraph(test["name"], cell_style),
				test["status"],
				Paragraph(details, cell_style),
			]
		)
	details = Table(rows, colWidths=[85 * mm, 22 * mm, 73 * mm], repeatRows=1)
	details.setStyle(
		TableStyle(
			[
				("BACKGROUND", (0, 0), (-1, 0), colors.HexColor("#1f4e79")),
				("TEXTCOLOR", (0, 0), (-1, 0), colors.white),
				("GRID", (0, 0), (-1, -1), 0.5, colors.grey),
				("VALIGN", (0, 0), (-1, -1), "TOP"),
				("ALIGN", (1, 1), (1, -1), "CENTER"),
				("ROWBACKGROUNDS", (0, 1), (-1, -1), [colors.white, colors.HexColor("#eef3f8")]),
			]
		)
	)
	story.append(details)

	document = SimpleDocTemplate(
		str(path), pagesize=A4, rightMargin=15 * mm, leftMargin=15 * mm,
		topMargin=15 * mm, bottomMargin=15 * mm,
	)
	document.build(story)


if __name__ == "__main__":
	if not OUTPUT_XML.exists():
		raise SystemExit(f"Robot output file not found: {OUTPUT_XML}")
	build_pdf(read_results(OUTPUT_XML), OUTPUT_PDF)
	print(f"PDF report generated: {OUTPUT_PDF}")
