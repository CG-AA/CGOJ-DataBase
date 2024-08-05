CREATE DATABASE CG_DB;
USE CG_DB;

CREATE TABLE permission_flags (
    name VARCHAR(50) PRIMARY KEY NOT NULL,
    offset INT NOT NULL,
    description TEXT,
    INDEX (offset)
);

CREATE TABLE users (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL,
    tag SMALLINT NOT NULL,
    INDEX (name, tag),
    email VARCHAR(100) NOT NULL UNIQUE,
    password VARCHAR(100) NOT NULL
);

CREATE TABLE roles (
    name VARCHAR(50) PRIMARY KEY NOT NULL,
    color VARCHAR(6) NOT NULL DEFAULT 'FFFFFF',
    permission_flags INT NOT NULL DEFAULT 0
);

CREATE TABLE user_roles (
    user_id INT NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    PRIMARY KEY (user_id, role_name),
    FOREIGN KEY (user_id) REFERENCES users(id),
    FOREIGN KEY (role_name) REFERENCES roles(name),
    INDEX (role_name)
);

-- problems
CREATE TABLE problems (
    id INT PRIMARY KEY AUTO_INCREMENT,
    owner_id INT NOT NULL,
    title VARCHAR(100) NOT NULL,
    description TEXT NOT NULL,
    input_format TEXT NOT NULL,
    output_format TEXT NOT NULL,
    difficulty ENUM('Easy', 'Medium', 'Hard') NOT NULL,
    INDEX (difficulty),
    FOREIGN KEY (owner_id) REFERENCES users(id),
    INDEX (owner_id)
);

CREATE TABLE problem_sample_IO (
    id INT PRIMARY KEY AUTO_INCREMENT,
    problem_id INT NOT NULL,
    sample_input TEXT,
    sample_output TEXT,
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    INDEX (problem_id)
);

CREATE TABLE tags (
    id INT PRIMARY KEY AUTO_INCREMENT,
    name VARCHAR(50) NOT NULL UNIQUE
);

CREATE TABLE problem_tags (
    problem_id INT NOT NULL,
    tag_id INT NOT NULL,
    PRIMARY KEY (problem_id, tag_id),
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    FOREIGN KEY (tag_id) REFERENCES tags(id),
    INDEX (tag_id),
    INDEX (problem_id)
);

CREATE TABLE problem_test_cases (
    id INT PRIMARY KEY AUTO_INCREMENT,
    problem_id INT NOT NULL,
    input TEXT,
    output TEXT,
    time_limit INT NOT NULL,
    memory_limit INT NOT NULL,
    score SMALLINT NOT NULL,    -- 0 >= score <= 10,000
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    INDEX (problem_id)
);

CREATE TABLE problem_solutions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    problem_id INT NOT NULL,
    title TEXT NOT NULL,
    solution TEXT NOT NULL,
    owner_id INT NOT NULL,
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    INDEX (problem_id)
);

CREATE TABLE problem_hints (
    id INT PRIMARY KEY AUTO_INCREMENT,
    problem_id INT NOT NULL,
    title TEXT NOT NULL,
    hint TEXT NOT NULL,
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    INDEX (problem_id)
);

CREATE TABLE problem_submissions (
    id INT PRIMARY KEY AUTO_INCREMENT,
    problem_id INT NOT NULL,
    user_id INT NOT NULL,
    submission_time TIMESTAMP NOT NULL,
    code TEXT NOT NULL,
    status ENUM('Pending', 'Rejected', 'TLE', 'MLE', 'AC', 'WA', 'CE', 'RE', 'OLE', 'RF', 'SE') NOT NULL,
    time_taken SMALLINT,
    memory_taken INT,
    language ENUM('Python', 'Java', 'C++') NOT NULL,
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    FOREIGN KEY (user_id) REFERENCES users(id),
    INDEX (problem_id),
    INDEX (user_id)
);

CREATE TABLE problem_submissions_subtasks (
    submission_id INT NOT NULL,
    id INT NOT NULL,
    PRIMARY KEY (submission_id, id),
    status ENUM('Pending', 'Rejected', 'TLE', 'MLE', 'AC', 'WA', 'CE', 'RE', 'OLE', 'RF', 'SE') NOT NULL,
    time_taken SMALLINT,
    memory_taken INT,
    FOREIGN KEY (submission_id) REFERENCES submissions(id)
);

CREATE TABLE problem_role (
    problem_id INT NOT NULL,
    role_name VARCHAR(50) NOT NULL,
    permission_flags INT NOT NULL DEFAULT 0,
    PRIMARY KEY (problem_id, role_name),
    FOREIGN KEY (problem_id) REFERENCES problems(id),
    FOREIGN KEY (role_name) REFERENCES roles(name),
    INDEX (role_name)
);
-- problems end

INSERT INTO roles (name, color) VALUES ('everyone', 'FFFFFF');