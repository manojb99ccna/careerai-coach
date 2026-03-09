import { useEffect, useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { adminApiClient } from '../../api/adminClient'

function AdminLoginPage() {
  const navigate = useNavigate()
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState('')
  const [email, setEmail] = useState('')
  const [password, setPassword] = useState('')

  useEffect(() => {
    const existingToken = localStorage.getItem('careerai_admin_token')
    if (existingToken) {
      navigate('/admin/dashboard', { replace: true })
    }
  }, [navigate])

  const handleLogin = async (e) => {
    e.preventDefault()
    setError('')
    setIsLoading(true)
    try {
      const response = await adminApiClient.post('/admin/auth/login', {
        email: email.trim(),
        password,
      })
      if (!response.data || !response.data.token) {
        setError('Invalid response from server.')
        return
      }

      localStorage.setItem('careerai_admin_token', response.data.token)
      if (response.data.user) {
        localStorage.setItem('careerai_admin_user', JSON.stringify(response.data.user))
      }

      navigate('/admin/dashboard')
    } catch {
      setError('Invalid email or password.')
    } finally {
      setIsLoading(false)
    }
  }

  return (
    <div className="scan-container">
      <div className="scan-card">
        <h1 className="scan-title">Admin Login</h1>
        <p className="scan-subtitle">Login with admin email and password.</p>

        <form onSubmit={handleLogin}>
          <div className="mb-3">
            <label className="form-label">Email</label>
            <input
              type="email"
              className="form-control"
              value={email}
              onChange={(e) => setEmail(e.target.value)}
              placeholder="admin@example.com"
              required
            />
          </div>
          <div className="mb-3">
            <label className="form-label">Password</label>
            <input
              type="password"
              className="form-control"
              value={password}
              onChange={(e) => setPassword(e.target.value)}
              placeholder="******"
              required
            />
          </div>

          {error && <div className="scan-error">{error}</div>}

          <button type="submit" className="primary-button full-width" disabled={isLoading}>
            {isLoading ? 'Logging in...' : 'Login'}
          </button>
        </form>
      </div>
    </div>
  )
}

export default AdminLoginPage
