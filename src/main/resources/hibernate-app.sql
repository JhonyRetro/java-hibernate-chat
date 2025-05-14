DROP DATABASE IF EXISTS hibernate_chat;
CREATE DATABASE hibernate_chat
DEFAULT CHARACTER SET utf8mb4;
USE hibernate_chat;
DROP TABLE IF EXISTS users;
CREATE TABLE users (
    user_id INT AUTO_INCREMENT NOT NULL,
    user_name VARCHAR(64) NOT NULL CHECK (LENGTH(user_name) > 0),
    user_image TEXT NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    passwd TEXT NOT NULL,
    creation_date DATETIME NOT NULL,
    PRIMARY KEY (user_id)
);

DROP TABLE IF EXISTS chat;

CREATE TABLE chat (
    chat_id INT AUTO_INCREMENT NOT NULL,
    creation_date DATETIME NOT NULL,
    PRIMARY KEY (chat_id)
);

DROP TABLE IF EXISTS messages;
CREATE TABLE messages (
    msg_id INT AUTO_INCREMENT NOT NULL,
    msg_content TEXT NOT NULL,
    user_id INT,
    chat_id INT,
    sent_date DATETIME NOT NULL,
    PRIMARY KEY (msg_id),
    CONSTRAINT fk_user_msg FOREIGN KEY (user_id) REFERENCES users(user_id)
    ON DELETE SET NULL 
    ON UPDATE CASCADE,
    CONSTRAINT fk_chat_msg FOREIGN KEY (chat_id) REFERENCES chat(chat_id)
    ON DELETE SET NULL 
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS file_attachments;
CREATE TABLE file_attachments (
    file_id INT AUTO_INCREMENT NOT NULL,
    msg_id INT NOT NULL,
    file_size TEXT NOT NULL,
    file_path TEXT NOT NULL,
    file_type TEXT NOT NULL,
    PRIMARY KEY (file_id),
    CONSTRAINT
    FOREIGN KEY (msg_id) REFERENCES messages(msg_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS private_chat;
CREATE TABLE private_chat (
    chat_id INT UNIQUE NOT NULL,
    CONSTRAINT
    FOREIGN KEY (chat_id) REFERENCES chat(chat_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS group_chat;
CREATE TABLE group_chat (
    chat_id INT UNIQUE NOT NULL,
    group_name VARCHAR(200),
    group_description TEXT,
    group_image TEXT NOT NULL,
    CONSTRAINT
    FOREIGN KEY (chat_id) REFERENCES chat(chat_id)
    ON DELETE CASCADE
    ON UPDATE CASCADE
);

DROP TABLE IF EXISTS members;

CREATE TABLE members (
    member_id INT AUTO_INCREMENT PRIMARY KEY,
    user_id INT NOT NULL,
    chat_id INT NOT NULL,
    join_date DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    CONSTRAINT fk_member_user FOREIGN KEY (user_id) REFERENCES users(user_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT fk_member_chat FOREIGN KEY (chat_id) REFERENCES group_chat(chat_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE,
    CONSTRAINT uq_user_chat UNIQUE (user_id, chat_id)
);

DROP TABLE IF EXISTS administrators;

CREATE TABLE administrators (
    member_id INT NOT NULL,
    admin_since DATETIME NOT NULL DEFAULT CURRENT_TIMESTAMP,
    PRIMARY KEY (member_id),
    CONSTRAINT fk_admin_member FOREIGN KEY (member_id) REFERENCES members(member_id)
        ON DELETE CASCADE
        ON UPDATE CASCADE
);