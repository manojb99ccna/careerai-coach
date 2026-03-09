import { useNavigate } from 'react-router-dom'
import { useMemo } from 'react'

const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

function AdminTopNavbar() {
  const navigate = useNavigate()

  const adminUser = useMemo(() => {
    const stored = localStorage.getItem('careerai_admin_user')
    if (!stored) return null
    try {
      return JSON.parse(stored)
    } catch {
      return null
    }
  }, [])

  const profileImageUrl =
    adminUser && adminUser.profile_image ? `${apiBaseUrl}/media/profile/${adminUser.profile_image}` : null

  const name = adminUser && adminUser.name ? adminUser.name : 'Admin'

  const handleLogout = () => {
    localStorage.removeItem('careerai_admin_token')
    localStorage.removeItem('careerai_admin_user')
    localStorage.removeItem('careerai_admin_face_encoding')
    localStorage.removeItem('careerai_admin_face_image')
    navigate('/admin')
  }

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
                style={{ width: '32px', height: '32px', fontSize: '14px' }}
              >
                {name.charAt(0).toUpperCase()}
              </div>
            )}
            <span>{name}</span>
          </button>

          <ul className="dropdown-menu dropdown-menu-end shadow">
            <li>
              <button className="dropdown-item" onClick={handleLogout}>
                Logout
              </button>
            </li>
          </ul>
        </div>
      </div>
    </nav>
  )
}

export default AdminTopNavbar

