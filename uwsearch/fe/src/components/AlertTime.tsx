import React from 'react'

interface AlertTimeProps {
    delay: string
    results: string
}
const AlertTime = ({delay, results}: AlertTimeProps) => {
  return (
    <div style={{marginLeft:120, marginRight: 120}} className="alert alert-primary" role="alert">
       found {results} results in {delay} ms
    </div>
  )
}

export default AlertTime