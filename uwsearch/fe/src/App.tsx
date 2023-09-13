import SearchBars from './components/searchBars'
import AlertTime from './components/AlertTime'
import CourseCard from './components/CourseCard'
import './App.css'
import { ChangeEvent, useState } from 'react'

function App() {
  const [AlertVisible, SetAlertVisible]= useState(false)
  const [SearchResults, SetSearchResults] = useState([]);
  const HandleSearchEvent = async (event: ChangeEvent) =>{
    console.log(event.target.value);
    const query = event.target.value;

    try {
      const response = await fetch(`http://localhost:4000/search/${query}`);
      const results = await response.json();

      SetSearchResults(results);
      SetAlertVisible(true);
      console.log(SearchResults)
    } catch (error) {
      console.error('Error fetching search results:', error);
    }
  }

  return (
    <>
      <div style={{textAlign: 'center', marginTop: 40}}>
        <img width={100} height={100} src='../public/University_of_Waterloo_seal.svg.png'/>
      </div>
      <h1 style={{textAlign: 'center'}}>UWSearch</h1>
      <h6 style={{textAlign: 'center'}}> A low-latency in-memory search engine of the university of waterloo course catalog</h6>
      <p style={{textAlign: 'center'}}> by Amire and Marie</p>
      <SearchBars HandleSearch={HandleSearchEvent}/>
      {AlertVisible && <AlertTime delay='0' results='0'/>}
      {SearchResults.map((course, index) => (
        <CourseCard
          key={index}
          subject={course.subjectCode}
          number={course.catalogNumber}
          courseTitle={course.title}
          description={course.description}
          prereq={course.requirementsDescription}
          faculty={course.associatedAcademicGroupCode}
        />
      ))}
    </>
  )
}

export default App
