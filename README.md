# 🎵 Mood Song Predictor – SQL Project

This project is an **SQL-based data analysis and schema design** project for predicting or categorizing songs based on their **mood**. It demonstrates database design, querying, and integration with BI tools for visualization.

---

## 📂 Project Structure
- `SONGSMOOD.sql` → Database schema and queries
- (Optional) Power BI / Tableau files for visualization

---

## 📊 Features
- Designed relational schema for storing **songs, artists, genres, and mood labels**.
- Implemented **SQL queries** for:
  - Categorizing songs into moods
  - Retrieving song details by mood/genre
  - Aggregating insights for reports and dashboards
- Prepared data for integration with **Power BI** to create **interactive dashboards**.

---

## 🛠️ Tech Stack
- **Database:** MySQL / PostgreSQL (compatible)
- **Languages:** SQL
- **Tools:** Power BI (for visualization), GitHub (for version control)

---

## 🚀 How to Run
1. Clone this repo:
   ```bash
   git clone https://github.com/gummadiamyuktha/songsmood.git
   cd songsmood
Import the SQL file:
bash
mysql -u <username> -p < database_name> < SONGSMOOD.sql

or in PostgreSQL:
bash
psql -U <username> -d <database_name> -f SONGSMOOD.sql
Run the provided queries inside your SQL IDE or CLI.

📈 Sample Use Cases
Identify the most popular moods in a given playlist.

Generate song recommendations by mood category.

Build a BI dashboard to visualize mood distribution.

📌 Future Improvements
Add a machine learning layer to auto-predict mood from lyrics/audio features.

Extend schema to handle user playlists and ratings.

Build a small web UI for interactive queries.

👩‍💻 Author
Amyuktha Gummadi

LinkedIn

GitHub
