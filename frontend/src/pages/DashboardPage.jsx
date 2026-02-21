import { useEffect, useState } from 'react'
import './DashboardPage.css'

function DashboardPage() {
  const [userName, setUserName] = useState('')

  useEffect(() => {
    const storedUser = localStorage.getItem('careerai_user')
    if (storedUser) {
      try {
        const parsed = JSON.parse(storedUser)
        if (parsed && parsed.name) {
          setUserName(parsed.name)
        }
      } catch {
        setUserName('')
      }
    }
  }, [])

  return (
    <div className="dashboard-container">
      <div className="dashboard-card">
        <h1 className="dashboard-title">Welcome back{userName ? `, ${userName}` : ''}</h1>
        <p className="dashboard-subtitle">
          Your face login was successful. This is your starting point for CareerAI coaching experiences.
        </p>
      </div>
    </div>
  )
}

export default DashboardPage

