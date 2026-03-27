# NASA Exoplanet Analysis: ESI Optimization 🌌

> **Note:** Before attempting to run the `Planets_LargeData.R` file, you must first unzip the `PS_2022.11.09_09.55.33.csv.zip` file. This archive contains the essential raw exoplanet data required for the analysis.

## 📖 Overview
This project focuses on evaluating planetary habitability by comparing four distinct variants of the **Earth Similarity Index (ESI)**. Using NASA's exoplanet database, the project processes raw stellar and planetary parameters to rank exoplanets based on their physical similarity to Earth.

## 📁 Repository Structure

### Documentation
* **`FinalPresentation.pdf`**: A visual summary of the research, methodology, and key findings.
* **`FinalReport.pdf`**: A comprehensive technical paper explaining the four ESI formulas compared in this project: **Standard**, **Weighted**, **Custom**, and **Revised**.

### Data Files
* **`PS_2022.11.09_09.55.33.csv.zip`**: The raw, comprehensive NASA exoplanet dataset.
* **`Planets_Filtered.csv`**: A streamlined version of the dataset containing only essential planetary parameters (e.g., radius, flux, temperature).
* **`Planets_Organized.csv`**: The refined dataset with null values removed, cross-referenced with the planets listed in `Habitable_Planets.csv`.
* **`Habitable_Planets.csv`**: A reference list of planets identified as potentially habitable.

### Analysis & Outputs
* **`Planets_LargeData.R`**: The main driver of the project. This R script filters the raw data, handles database joins, and executes the four ESI mathematical models.
* **`Top_Standard.csv`**: Output containing the top 10 planets ranked by the Standard ESI formula.
* **`Top_Weighted.csv`**: Output containing the top 10 planets ranked by the Weighted ESI formula.
* **`Top_Custom.csv`**: Output containing the top 10 planets ranked by the Custom ESI formula.
* **`Top_Revised.csv`**: Output containing the top 10 planets ranked by the Revised ESI formula.

## 🛠️ Tech Stack
* **Language:** R
* **Data Source:** NASA Exoplanet Archive
* **Methodology:** Comparative Numerical Analysis (ESI Optimization)

## 👤 Author
**Christopher J. Figueroa**
* **Education:** MS in Computer Science | SUNY Polytechnic Institute
* **Specialization:** Agentic AI, Machine Learning, and Multi-Agent Systems
* **Technical Profile:** Specialist in developing multi-agent systems using `PydanticAI` and `LangGraph`.
* **Contact:** [LinkedIn](https://www.linkedin.com/in/christopher-figueroa-812aa1186/) | [GitHub](https://github.com/cfig0219?tab=repositories)
