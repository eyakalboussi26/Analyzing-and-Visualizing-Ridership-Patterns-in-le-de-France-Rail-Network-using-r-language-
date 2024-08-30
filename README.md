---

---

# Analyzing-and-Visualizing-Ridership-Patterns-in-le-de-France-Rail-Network-using-r-language-

## The main idea of our project

In this project, we commence with the data collection phase, where the primary focus is on gathering Île-de-France's railway station ridership from 2017 to the frist semester of 2023. The initial steps encompass the crucial tasks of cleaning the data, detecting and rectifying missing values, and eliminating outliers to ensure the dataset's integrity. Subsequently, we delve into the Exploratory Data Analysis (EDA), unraveling the intricate tapestry of ridership patterns. This phase involves identifying overarching trends, scrutinizing seasonality and monthly variations, and meticulously assessing potential outliers that may influence the data. Following the EDA, the focus shifts to comparing ridership against established norms. This involves defining a baseline for a "normal" week and delving into deviations observed during holiday and non-holiday periods, (Christmas, Easter, National Day), vacations, the start of the school year, the impact of the coronavirus pandemic, and the Olympic Games including an assessment of the influence of vacations and school breaks on ridership patterns. Our goal is to understand the impact of these events on the number of validations, the types of transport tickets purchased, and the locations visited, comparing them with the number of validations on regular days. Finally, the journey culminates in the development of an interactive dashboard using the Shiny framework in R. This dashboard will serve as a dynamic interface, incorporating key visualizations that showcase overall ridership trends, weekly variations, and comprehensive comparisons with the established norms, providing stakeholders with an intuitive tool to monitor and comprehend ridership dynamics.

1.  collection data

Collecting data from Open Data Île-de-France . [The first dataset](https://data.iledefrance-mobilites.fr/explore/dataset/histo-validations-reseau-ferre/information/) is the historical validation data on the rail network spanning from 2017 to 2022. For each year, there are four files : 
--- Rail network validations : Number of validations per day for the frist semester (NbValidS1) 
---Rail network validations: Hourly profiles per day type for the frist semester(ProfilFerS1) 
---Surface network validations: Number of validations per day NbValidS2 
--- Surface network validations: Hourly profiles per day type ProfilFerS2.

2.  Cleaning data:

    The data cleaning process involves addressing missing values, outliers, and inconsistencies. Handling missing values and removing outliers are crucial steps for effective data preparation and visualization.

3.  Handling missing values:

    This stage focused on addressing various data-related challenges, including different data types and formatting issues. Strategies for detecting and managing specific symbols within the dataset were explored. Code snippets in R Markdown offered a structured approach for identifying, visualizing, and potentially handling rows and columns containing these symbols.

4.  Detecting and removing outliers:

    Outliers can distort data visualizations, impacting the interpretation of trends. They can exaggerate data spread, affecting visualization accuracy.

5.  Exploratory Data Analysis (EDA) and comparison with norms:

6.  Data visualization aims to understand data distribution using different plots. Focus was placed on comparing ticket validations during specific periods like school holidays, Christmas, the pandemic, World Cup, and PSG matches in the Île-de-France region. Analysis included zones and validation stations to understand buyer behavior and ticket types associated with each event or destination.

7.  Analysis of temporal trends: Graphical representation of validation evolution over time helps identify peak validation days or months. Analyzing validations by stop locates areas with concentrated activity, providing insights into significant activity zones."

## Some data explanations: The type of transport tickets includes:

JOHV: Weekday outside of school holidays. SAHV: Saturday outside of school holidays. JOVS: Weekday during school holidays. SAVS: Saturday during school holidays. DIJFP: Sunday and public holidays, including bridge days. The validation data is classified by the category of transport passes:

'IMAGINE R': includes the annual Imagine R Scolaire and Imagine R Etudiant passes, reserved for students and apprentices, allowing unlimited travel throughout the Île-de-France region for the entire year. 'NAVIGO': includes the Navigo Annuel, Navigo Mois, and Navigo Semaine passes. 'AMETHYSTE': tallies the Améthyste passes, reserved for elderly or disabled individuals meeting certain income or status conditions and residing in Île-de-France. This annual pass allows unlimited travel on all modes of transport within the valid zones. 'TST': groups weekly and monthly reduced-rate passes granted to beneficiaries of the Réduction Solidarité Transport, enabling travel within selected zones across all modes of transport in Île-de-France. 'FGT': tallies the Forfaits Navigo Gratuité Transport, a pass that allows certain social aid beneficiaries to travel for free throughout Île-de-France. 'AUTRE TITRE': counts special passes. 'NON DEFINI': counts validations with undefined pass types (anomalies)."
