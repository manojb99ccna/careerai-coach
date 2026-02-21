import { Routes, Route, useNavigate } from 'react-router-dom'
import './App.css'
import WelcomePage from './pages/WelcomePage.jsx'
import FaceScanPage from './pages/FaceScanPage.jsx'
import RegisterPage from './pages/RegisterPage.jsx'
import DashboardPage from './pages/DashboardPage.jsx'

function WelcomeRoute() {
  const navigate = useNavigate()

  return <WelcomePage onStart={() => navigate('/scan')} />
}

function App() {
  return (
    <Routes>
      <Route path="/" element={<WelcomeRoute />} />
      <Route path="/scan" element={<FaceScanPage />} />
      <Route path="/register" element={<RegisterPage />} />
      <Route path="/dashboard" element={<DashboardPage />} />
    </Routes>
  )
}

export default App
