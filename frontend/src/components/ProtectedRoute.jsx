import { Navigate, Outlet, useLocation } from 'react-router-dom'

function ProtectedRoute({ requireOnboardingComplete }) {
  const location = useLocation()
  const token = localStorage.getItem('careerai_token')
  const onboardingComplete = localStorage.getItem('careerai_onboarding_complete') === 'true'

  if (!token) {
    if (location.pathname !== '/' && location.pathname !== '/scan' && location.pathname !== '/register') {
      return <Navigate to="/" replace />
    }
    return <Outlet />
  }

  if (requireOnboardingComplete && !onboardingComplete) {
    if (location.pathname !== '/onboarding') {
      return <Navigate to="/onboarding" replace />
    }
  }

  return <Outlet />
}

export default ProtectedRoute

