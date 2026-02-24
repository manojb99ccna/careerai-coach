import { useState } from 'react'
import './DashboardPage.css'

function DashboardPage() {
  let initialUserName = ''
  if (typeof window !== 'undefined') {
    const storedUser = localStorage.getItem('careerai_user')
    if (storedUser) {
      try {
        const parsedUser = JSON.parse(storedUser)
        if (parsedUser && typeof parsedUser.name === 'string') {
          initialUserName = parsedUser.name
        }
      } catch {
        initialUserName = ''
      }
    }
  }

  const [userName] = useState(initialUserName)

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
