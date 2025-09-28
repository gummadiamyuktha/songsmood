-- Drop and recreate the database
DROP DATABASE IF EXISTS MusicMood;
CREATE DATABASE MusicMood;
USE MusicMood;

-- Create Users table
CREATE TABLE Users (
    user_id INT AUTO_INCREMENT PRIMARY KEY,
    username VARCHAR(50) NOT NULL,
    country VARCHAR(50)
);

-- Create Songs table
CREATE TABLE Songs (
    song_id INT AUTO_INCREMENT PRIMARY KEY,
    title VARCHAR(100) NOT NULL,
    artist VARCHAR(100) NOT NULL,
    genre VARCHAR(50) NOT NULL,
    tempo DECIMAL(5,2) NOT NULL,
    energy DECIMAL(3,2) NOT NULL,
    valence DECIMAL(3,2) NOT NULL
);

-- Create UserSongInteraction table
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

-- Create Playlists table
CREATE TABLE Playlists (
    playlist_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT,
    playlist_name VARCHAR(100),
    FOREIGN KEY (user_id) REFERENCES Users(user_id)
);

-- Create PlaylistSongs table
CREATE TABLE PlaylistSongs (
    playlist_id INT,
    song_id INT,
    order_index INT,
    PRIMARY KEY (playlist_id, song_id),
    FOREIGN KEY (playlist_id) REFERENCES Playlists(playlist_id),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);

-- Create LyricsSentiment table
CREATE TABLE LyricsSentiment (
    song_id INT PRIMARY KEY,
    sentiment_score DECIMAL(4,2),
    sentiment_label VARCHAR(50),
    FOREIGN KEY (song_id) REFERENCES Songs(song_id)
);

-- Create the PredictedSongMood view
CREATE VIEW PredictedSongMood AS
SELECT 
    s.song_id,
    s.title,
    s.artist,
    s.tempo,
    s.energy,
    s.valence,
    CASE 
        WHEN s.valence >= 0.7 AND s.energy >= 0.6 AND s.tempo > 100 THEN 'Happy & Energetic'
        WHEN s.valence >= 0.7 AND s.energy < 0.6 THEN 'Peaceful & Uplifting'
        WHEN s.valence < 0.4 AND s.energy >= 0.6 THEN 'Angsty / Intense'
        WHEN s.valence < 0.4 AND s.energy < 0.4 AND s.tempo < 90 THEN 'Sad & Slow'
        WHEN s.energy >= 0.8 AND s.tempo > 120 THEN 'Hype / Workout'
        WHEN s.energy < 0.3 AND s.tempo < 80 THEN 'Calm / Mellow'
        ELSE 'Chill / Neutral'
    END AS predicted_mood
FROM Songs s;

-- Insert Users
INSERT INTO Users (username, country) VALUES
('VIJAY_music', 'India'),
('CHINNU_vibes', 'India'),
('MODHINI_melody', 'India'),
('KAJAL_beats', 'India'),
('SOWMYA', 'India'),
('TEJU', 'India'),
('KAVYA91', 'India'),
('HARIKA_sings', 'India'),
('NIHARIKA_bass', 'India'),
('DURGA_fm', 'India'),
('GRESHUU_dj', 'India'),
('SETHU_chill', 'India'),
('JAGATHI_hits', 'India'),
('RAMYA_wave', 'India');

-- Insert Songs
INSERT INTO Songs (title, artist, genre, tempo, energy, valence) VALUES
('New York Nagaram', 'A.R. Rahman', 'Romantic', 80, 0.4, 0.3),
('Nuvvante Nakistamani', 'Usha', 'Melody', 75, 0.3, 0.5),
('Botany', 'S. P. Balasubrahmanyam', 'Fusion', 110, 0.7, 0.6),
('Chiru Chiru', 'Yuvan Shankar Raja', 'Romantic Pop', 95, 0.6, 0.7),
('Monna Kanipinchavu', 'Harris Jayaraj', 'Melody', 78, 0.5, 0.4),
('Naaloney Pongaynu', 'Harris Jayaraj', 'Love', 115, 0.5, 0.6),
('Chutamalle', 'Anirudh Ravichander', 'Romantic', 115, 0.8, 0.75);

-- Insert UserSongInteractions
INSERT INTO UserSongInteraction (user_id, song_id, liked, skipped, play_count) VALUES
(1, 1, TRUE, FALSE, 10),
(2, 1, TRUE, FALSE, 6),
(3, 2, TRUE, FALSE, 7),
(4, 2, FALSE, TRUE, 3),
(5, 3, TRUE, FALSE, 12),
(6, 3, TRUE, FALSE, 9),
(7, 4, FALSE, TRUE, 2),
(8, 4, TRUE, FALSE, 5),
(9, 5, TRUE, FALSE, 8),
(10, 5, FALSE, TRUE, 4),
(11, 6, TRUE, FALSE, 13),
(12, 6, FALSE, TRUE, 1),
(13, 7, TRUE, FALSE, 14);

-- Insert Playlists
INSERT INTO Playlists (user_id, playlist_name) 
VALUES
(1, 'Telugu Go-To Songs');

-- Link Songs to the Playlist
INSERT INTO PlaylistSongs (playlist_id, song_id, order_index) VALUES
(1, 1, 1),
(1, 2, 2), 
(1, 3, 3),
(1, 7, 4);

-- Insert Lyrics Sentiment Data
INSERT INTO LyricsSentiment (song_id, sentiment_score, sentiment_label) VALUES
(1, 0.25, 'Negative'),
(2, 0.45, 'Neutral'),
(3, 0.65, 'Positive'),
(4, 0.55, 'Neutral'),
(5, 0.35, 'Negative'),
(6, 0.50, 'Neutral'),
(7, 0.70, 'Positive');
SELECT * FROM Playlists WHERE user_id = 1;
SELECT ps.playlist_id, ps.song_id, s.title 
FROM PlaylistSongs ps 
JOIN Songs s ON ps.song_id = s.song_id
WHERE ps.playlist_id = 1;
SELECT * FROM PredictedSongMood;
SELECT s.title, SUM(usi.play_count) AS total_plays
FROM UserSongInteraction usi
JOIN Songs s ON usi.song_id = s.song_id
GROUP BY s.song_id
ORDER BY total_plays DESC;
SELECT s.title, COUNT(usi.liked) AS total_likes
FROM UserSongInteraction usi
JOIN Songs s ON usi.song_id = s.song_id
WHERE usi.liked = 1
GROUP BY s.song_id
ORDER BY total_likes DESC;
SELECT s.title, COUNT(usi.skipped) AS total_skips
FROM UserSongInteraction usi
JOIN Songs s ON usi.song_id = s.song_id
WHERE usi.skipped = 1
GROUP BY s.song_id
ORDER BY total_skips DESC;

