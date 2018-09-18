-- Get all sections, which also provides all students, teachers, and courses.

SELECT 
st.student_number, st.lastfirst, st.grade_level, st.dcid AS student_dcid,
sec.SECTION_NUMBER, sec.termid, sec.dcid AS section_dcid, sec.expression, sec.room, sec.grade_level AS "section_grade_level",
te.lastfirst, te.teachernumber, te.dcid AS teacher_dcid, te.email_addr,
cor.course_number, cor.course_name, cor.dcid AS course_dcid
FROM CC
JOIN sections sec ON cc.sectionid = sec.id
JOIN students st on st.id = CC.STUDENTID
JOIN teachers te ON te.id = cc.teacherid
JOIN courses cor ON cor.course_number = cc.course_number
WHERE sec.NO_OF_STUDENTS > 0
;

-- export this file as JSON to te data folder, name it: all-sections.json


--  Get all final standard grades
SELECT 
st.dcid AS student_dcid,
sgs.STANDARDGRADE, sgs.storecode,
sec.dcid AS section_dcid, sec.termid,
sta.name, sta.identifier, sta.standardid AS standard_dcid,
c.dcid AS course_dcid
FROM students st
JOIN standardgradesection sgs on st.DCID = sgs.studentsdcid
Join sections sec ON sgs.sectionsdcid = sec.DCID
JOIN standard sta ON sta.STANDARDID = sgs.STANDARDID
JOIN COURSES c ON c.COURSE_NUMBER = sec.COURSE_NUMBER
WHERE sec.schoolid = 102
AND sgs.yearid >= 27
AND sgs.STANDARDGRADE IS NOT NULL
AND st.ENROLL_STATUS = 0
AND sec.no_of_students > 0
;

-- again, export as JSON into the data directory, name it: all-final-standards.json



-- Get all semester comments
SELECT 
sgsc.COMMENTVALUE, sgsc.STUDENTSDCID AS "student_dcid",
sgs.storecode,
sec.dcid AS "section_dcid",
te.dcid AS "teacher_dcid"
FROM standardgradesectioncomment sgsc
JOIN standardgradesection sgs on sgs.STANDARDGRADESECTIONID = sgsc.STANDARDGRADESECTIONID
JOIN sections sec ON sgs.sectionsdcid = sec.dcid
JOIN students st on sgsc.STUDENTSDCID = st.dcid
JOIN teachers te on te.id = sec.TEACHER
where sgsc.yearid >= 27
and st.ENROLL_STATUS = 0
and sec.no_of_students > 0
and sec.schoolid = 102
;

-- name it: all-semester-comments.json