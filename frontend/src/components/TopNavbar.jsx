import { useNavigate } from 'react-router-dom'
import { useState } from 'react'

const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

function TopNavbar() {
  const navigate = useNavigate()
  let initialUserName = 'User'
  let initialProfileImage = null
  if (typeof window !== 'undefined') {
    const stored = localStorage.getItem('careerai_user')
    if (stored) {
      try {
        const parsedUser = JSON.parse(stored)
        if (parsedUser && typeof parsedUser === 'object') {
          if (typeof parsedUser.name === 'string' && parsedUser.name.trim()) {
            initialUserName = parsedUser.name
          }
          if (typeof parsedUser.profile_image === 'string' && parsedUser.profile_image.trim()) {
            initialProfileImage = parsedUser.profile_image
          }
        }
      } catch {
        initialUserName = 'User'
        initialProfileImage = null
      }
    }
  }

  const [profileImageName] = useState(initialProfileImage)
  const [userName] = useState(initialUserName)

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
