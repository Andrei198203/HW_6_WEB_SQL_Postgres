DROP TABLE IF EXISTS groups;

CREATE TABLE groups(
  id SERIAL PRIMARY KEY,
  name VARCHAR(50) NOT NULL
  );
 
 DROP TABLE IF EXISTS teachers;
 CREATE TABLE teachers (
  id SERIAL PRIMARY key,
  fullname VARCHAR(150) NOT NULL 
  );
 
 DROP TABLE IF EXISTS students;
 CREATE TABLE students (
  id SERIAL PRIMARY KEY,
  fullname VARCHAR(150) NOT null,
  group_id INTEGER REFERENCES groups(id)
  	on delete cascade
  );
  
 DROP TABLE IF EXISTS subjects; 
 CREATE TABLE subjects (
  id SERIAL PRIMARY KEY,
  name VARCHAR(175) NOT NULL,
  teacher_id INTEGER REFERENCES teachers(id)
  	on delete cascade
  );
 
  DROP TABLE IF EXISTS grades;
  CREATE TABLE grades (
  id SERIAL PRIMARY key,
  subject_id INTEGER REFERENCES subjects(id)
  on delete cascade,
  student_id INTEGER REFERENCES students(id)
  on delete cascade,
  grade INTEGER check (grade >= 0 and grade <=100),
  grade_date DATE NOT NULL
  );