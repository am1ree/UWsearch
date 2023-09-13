import React from 'react'

interface CourseCardProps {
    subject: string
    number: string
    courseTitle: string
    description: string
    prereq: string
    faculty: string

}

const CourseCard = ({subject, number, courseTitle, description, prereq, faculty}: CourseCardProps) => {
  return (
    <div style={{marginLeft:120, marginRight: 120, marginTop: 30}} className="card">
        <h5 className="card-header">{subject} {number}: {courseTitle}</h5>
        <div className="card-body">
            <h6 className="card-title">{faculty} | {prereq}</h6>
            <p className="card-text">{description}</p>
        </div>
    </div>
  )
}

export default CourseCard