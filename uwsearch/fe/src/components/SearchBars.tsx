import {React,  ChangeEvent } from 'react'

interface SearchBarsProps {
  HandleSearch: (event: ChangeEvent) => void
}

const SearchBars = ({HandleSearch}: SearchBarsProps) => {
  return (
    <form>
        <div style={{paddingTop: 30, paddingLeft: 80, paddingRight:80} } className="input-group mb-3">
          <span className="input-group-text" id="basic-addon1">🔎</span>
          <input onChange={HandleSearch} type="text" className="form-control" placeholder="Search for any courses" aria-label="Username" aria-describedby="basic-addon1"/>
        </div>
    </form>
  )
}

export default SearchBars