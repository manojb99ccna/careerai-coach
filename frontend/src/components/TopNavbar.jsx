import { useNavigate } from 'react-router-dom'

function TopNavbar() {
  const navigate = useNavigate()

  const handleProfile = () => {
    navigate('/profile')
  }

  const handleLogout = () => {
    localStorage.removeItem('careerai_token')
    localStorage.removeItem('careerai_user')
    localStorage.removeItem('careerai_onboarding_complete')
    localStorage.removeItem('careerai_onboarding_answers')
    navigate('/')
  }

  return (
    <nav className="navbar navbar-expand bg-light border-bottom top-navbar">
      <div className="container-fluid justify-content-end">
        <div className="d-flex gap-2">
          <button type="button" className="btn btn-outline-secondary btn-sm" onClick={handleProfile}>
            Profile
          </button>
          <button type="button" className="btn btn-primary btn-sm" onClick={handleLogout}>
            Logout
          </button>
        </div>
      </div>
    </nav>
  )
}

export default TopNavbar

