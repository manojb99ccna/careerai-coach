import { useNavigate } from 'react-router-dom'
import { useEffect, useState } from 'react'

const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

function TopNavbar() {
  const navigate = useNavigate()
  const [profileImageName, setProfileImageName] = useState(null)
  const [userName, setUserName] = useState('User')

  useEffect(() => {
    const stored = localStorage.getItem('careerai_user')
    if (!stored) {
      return
    }
    try {
      const user = JSON.parse(stored)
      if (user) {
        setUserName(user.name || 'User')
        setProfileImageName(user.profile_image || null)
      }
    } catch {
      setUserName('User')
      setProfileImageName(null)
    }
  }, [])

  const handleLogout = () => {
    localStorage.removeItem('careerai_token')
    localStorage.removeItem('careerai_user')
    localStorage.removeItem('careerai_onboarding_complete')
    localStorage.removeItem('careerai_onboarding_answers')
    navigate('/')
  }

  const goProfile = () => navigate('/profile')

  const goOnboarding = () => navigate('/onboarding')

  const profileImageUrl = profileImageName ? `${apiBaseUrl}/media/profile/${profileImageName}` : null

  return (
    <nav className="navbar navbar-expand bg-light border-bottom top-navbar">
      <div className="container-fluid justify-content-end">

        <div className="dropdown">

          <button
            className="btn btn-light dropdown-toggle d-flex align-items-center gap-2"
            type="button"
            data-bs-toggle="dropdown"
          >
            {profileImageUrl ? (
              <img
                src={profileImageUrl}
                alt="Profile"
                width="32"
                height="32"
                className="rounded-circle"
                style={{ objectFit: 'cover' }}
              />
            ) : (
              <div
                className="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center"
                style={{ width: "32px", height: "32px", fontSize: "14px" }}
              >
                {userName.charAt(0).toUpperCase()}
              </div>
            )}

            <span>{userName}</span>
          </button>

          <ul className="dropdown-menu dropdown-menu-end shadow">

            <li>
              <button className="dropdown-item" onClick={goProfile}>
                Profile
              </button>
            </li>

            <li>
              <button className="dropdown-item" onClick={goOnboarding}>
                Onboarding
              </button>
            </li>

            <li><hr className="dropdown-divider" /></li>

            <li>
              <button className="dropdown-item text-danger" onClick={handleLogout}>
                Logout
              </button>
            </li>

          </ul>

        </div>

      </div>
    </nav>
  )
}

export default TopNavbar
