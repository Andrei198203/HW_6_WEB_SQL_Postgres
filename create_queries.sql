--Знайти 5 студентів із найбільшим середнім балом з усіх предметів.

SELECT s.fullname AS student_name, ROUND(AVG(g.grade), 2) AS avg_grade
FROM students s
JOIN grades g ON s.id = g.student_id
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 5;

-- Знайти студента із найвищим середнім балом з певного предмета
SELECT s.fullname AS student_name, AVG(g.grade) AS avg_grade
FROM students s
JOIN grades g ON s.id = g.student_id
WHERE g.id = :subject_id
GROUP BY s.id
ORDER BY avg_grade DESC
LIMIT 1;

-- Знайти середній бал у групах з певного предмета
SELECT g.id, ROUND(AVG(gr.grade), 2) AS avg_grade
FROM groups g
JOIN students s ON g.id = s.group_id
JOIN grades gr ON s.id = gr.student_id
WHERE gr.subject_id = :subject_id
GROUP BY g.id;

--Знайти середній бал на потоці (по всій таблиці оцінок)
SELECT AVG(grade) AS overall_avg_grade
FROM grades;

--Знайти які курси читає певний викладач

SELECT t.fullname, s.name
FROM teachers t
JOIN subjects s ON t.id = s.teacher_id
WHERE t.id = :teacher_id;

--Знайти список студентів у певній групі

SELECT s.fullname AS student_name, g.name
FROM students s
JOIN groups g ON s.group_id = g.id
WHERE g.id = :group_id;


--Знайти оцінки студентів у окремій групі з певного предмета
SELECT s.fullname AS student_name, g.grade, sb.name
FROM students s
JOIN grades g ON s.id = g.student_id
JOIN subjects sb ON g.subject_id = sb.id
WHERE s.group_id = :group_id AND sb.id = :subject_id;

--Знайти середній бал, який ставить певний викладач зі своїх предметів

SELECT t.fullname, AVG(g.grade) AS avg_grade
FROM teachers t
JOIN subjects s ON t.id = s.teacher_id
JOIN grades g ON s.id = g.subject_id
WHERE t.id = :teacher_id
GROUP BY t.id;

--Знайти список курсів, які відвідує студент

SELECT s.fullname AS student_name, sb.name
FROM students s
JOIN grades g ON s.id = g.student_id
JOIN subjects sb ON g.subject_id = sb.id
WHERE s.id = :student_id;

--Список курсів, які певному студенту читає певний викладач

SELECT s.fullname AS student_name, t.fullname, sb.name
FROM students s
JOIN grades g ON s.id = g.student_id
JOIN subjects sb ON g.subject_id = sb.id
JOIN teachers t ON sb.teacher_id = t.id
WHERE s.id = :student_id AND t.id = :teacher_id;

-- Оцінки студентів у певній групі з певного предмета на останньому занятті
--
--WITH LastClass AS (
--    SELECT MAX(date_received) AS last_class_date, subject_id
--    FROM grades
--    GROUP BY subject_id
--)
--
--SELECT s.fullname AS student_name, g.grade, sb.name
--FROM students s
--JOIN grades g ON s.id = g.student_id
--JOIN subjects sb ON g.subject_id = sb.id
--JOIN LastClass lc ON g.subject_id = lc.subject_id AND g.date_received = lc.last_class_date
--WHERE s.group_id = :group_id AND sb.id = :subject_id;