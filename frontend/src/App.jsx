import { Routes, Route, useNavigate } from 'react-router-dom'
import './App.css'
import Sidebar from './components/Sidebar.jsx'
import TopNavbar from './components/TopNavbar.jsx'
import ProtectedRoute from './components/ProtectedRoute.jsx'
import WelcomePage from './pages/WelcomePage.jsx'
import FaceScanPage from './pages/FaceScanPage.jsx'
import RegisterPage from './pages/RegisterPage.jsx'
import CareerQAPage from './pages/CareerQAPage.jsx'
import DashboardPage from './pages/DashboardPage.jsx'
import TrainingPage from './pages/TrainingPage.jsx'
import MilestoneDetailPage from './pages/MilestoneDetailPage.jsx'
import AIFeedbackPage from './pages/AIFeedbackPage.jsx'
import ResumeSuggestionsPage from './pages/ResumeSuggestionsPage.jsx'
import ProfilePage from './pages/ProfilePage.jsx'

function WelcomeRoute() {
  const navigate = useNavigate()

  return <WelcomePage onStart={() => navigate('/scan')} />
}

function AppLayout() {
  return (
    <div className="app-layout">
      <Sidebar />
      <div className="app-main">
        <TopNavbar />
        <main className="app-content">
          <Routes>
            <Route element={<ProtectedRoute requireOnboardingComplete />}>
              <Route path="/dashboard" element={<DashboardPage />} />
              <Route path="/training" element={<TrainingPage />} />
              <Route path="/training/milestones/:id" element={<MilestoneDetailPage />} />
              <Route path="/ai-feedback" element={<AIFeedbackPage />} />
              <Route path="/resume-suggestions" element={<ResumeSuggestionsPage />} />
            </Route>
            <Route element={<ProtectedRoute requireOnboardingComplete={false} />}>
              <Route path="/profile" element={<ProfilePage />} />
            </Route>
          </Routes>
        </main>
      </div>
    </div>
  )
}

function App() {
  return (
    <Routes>
      <Route path="/" element={<WelcomeRoute />} />
      <Route path="/scan" element={<FaceScanPage />} />
      <Route path="/register" element={<RegisterPage />} />
      <Route path="/onboarding" element={<CareerQAPage />} />
      <Route path="/*" element={<AppLayout />} />
    </Routes>
  )
}

export default App
