CREATE DATABASE MusicMood;
USE MusicMood;
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    country VARCHAR(50)
);
CREATE TABLE Songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    tempo DECIMAL(5,2) NOT NULL,
    energy DECIMAL(3,2) NOT NULL,
    valence DECIMAL(3,2) NOT NULL
);
CREATE TABLE UserSongInteraction (
    interaction_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    song_id INT,
    liked BOOLEAN,
    skipped BOOLEAN,
    play_count INT DEFAULT 0,
    FOREIGN KEY (user_id) REFERENCES Users(user_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);
CREATE TABLE LyricsSentiment (
    song_id INT PRIMARY KEY,
    sentiment_score DECIMAL(4,2),
    sentiment_label VARCHAR(50),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);
CREATE VIEW PredictedSongMood AS
SELECT 
    s.song_id,
    s.title,
    s.artist,
    s.tempo,
    s.energy,
    s.valence,
    CASE 
        WHEN valence >= 0.7 AND energy >= 0.6 AND tempo > 100 THEN 'Happy & Energetic'
        WHEN valence >= 0.7 AND energy < 0.6 THEN 'Peaceful & Uplifting'
        WHEN valence < 0.4 AND energy >= 0.6 THEN 'Angsty / Intense'
        WHEN valence < 0.4 AND energy < 0.4 AND tempo < 90 THEN 'Sad & Slow'
        WHEN energy >= 0.8 AND tempo > 120 THEN 'Hype / Workout'
        WHEN energy < 0.3 AND tempo < 80 THEN 'Calm / Mellow'
        ELSE 'Chill / Neutral'
    END AS predicted_mood
FROM Songs s;


