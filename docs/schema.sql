-- RaceDayDB Schema
-- Main database schema for race day event management system

-- Users table
CREATE TABLE IF NOT EXISTS users (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    username VARCHAR(100) NOT NULL UNIQUE,
    email VARCHAR(255) NOT NULL UNIQUE,
    password_hash VARCHAR(255) NOT NULL,
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    updated_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP ON UPDATE CURRENT_TIMESTAMP
);

-- Races table
CREATE TABLE IF NOT EXISTS races (
    race_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT NOT NULL,
    race_name VARCHAR(255) NOT NULL,
    race_date DATETIME NOT NULL,
    location VARCHAR(255) NOT NULL,
    status ENUM('planned', 'ongoing', 'completed', 'cancelled') DEFAULT 'planned',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE
);

-- Participants table
CREATE TABLE IF NOT EXISTS participants (
    participant_id INT PRIMARY KEY AUTO_INCREMENT,
    race_id INT NOT NULL,
    user_id INT NOT NULL,
    bib_number INT NOT NULL,
    finish_time TIME,
    position INT,
    registered_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (race_id) REFERENCES races(race_id) ON DELETE CASCADE,
    FOREIGN KEY (user_id) REFERENCES users(user_id) ON DELETE CASCADE,
    UNIQUE KEY unique_bib_per_race (race_id, bib_number)
);

-- Results table
CREATE TABLE IF NOT EXISTS results (
    result_id INT PRIMARY KEY AUTO_INCREMENT,
    participant_id INT NOT NULL,
    race_id INT NOT NULL,
    time_recorded TIME NOT NULL,
    status ENUM('completed', 'dnf', 'dq') DEFAULT 'completed',
    created_at TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (participant_id) REFERENCES participants(participant_id) ON DELETE CASCADE,
    FOREIGN KEY (race_id) REFERENCES races(race_id) ON DELETE CASCADE
);

-- Create indexes for better query performance
CREATE INDEX idx_races_user_id ON races(user_id);
CREATE INDEX idx_participants_race_id ON participants(race_id);
CREATE INDEX idx_participants_user_id ON participants(user_id);
CREATE INDEX idx_results_participant_id ON results(participant_id);
CREATE INDEX idx_results_race_id ON results(race_id);
