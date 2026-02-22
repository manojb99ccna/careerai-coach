import { useState } from 'react'
import { useNavigate } from 'react-router-dom'
import { apiClient } from '../api/client'
import './RegisterPage.css'

function RegisterPage() {
  const navigate = useNavigate()
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [phone, setPhone] = useState('')
  const [isSubmitting, setIsSubmitting] = useState(false)
  const [error, setError] = useState('')

  const handleSubmit = async (event) => {
    event.preventDefault()

    const storedEncoding = localStorage.getItem('careerai_face_encoding')
    const storedImage = localStorage.getItem('careerai_face_image')
    if (!storedEncoding || !storedImage) {
      setError('No face scan found. Please go back and scan your face again.')
      return
    }

    let encoding = []
    try {
      encoding = JSON.parse(storedEncoding)
    } catch {
      setError('Stored face scan is invalid. Please rescan your face.')
      return
    }

    setError('')
    setIsSubmitting(true)
    try {
      const response = await apiClient.post('/auth/face/register', {
        name,
        email,
        phone,
        encoding,
        profile_image: storedImage,
      })

      if (response.data.token) {
        localStorage.setItem('careerai_token', response.data.token)
      }
      if (response.data.user) {
        localStorage.setItem('careerai_user', JSON.stringify(response.data.user))
      }
      localStorage.setItem('careerai_onboarding_complete', 'false')
      localStorage.removeItem('careerai_face_encoding')
      localStorage.removeItem('careerai_face_image')

      navigate('/onboarding')
    } catch {
      setError('Registration failed. Please check your details and try again.')
    } finally {
      setIsSubmitting(false)
    }
  }

  return (
    <div className="register-container">
      <div className="register-card">
        <h1 className="register-title">Complete Your Profile</h1>
        <p className="register-subtitle">We could not find a match. Create your secure account to continue.</p>
        <form className="register-form" onSubmit={handleSubmit}>
          <label className="register-field">
            <span>Name</span>
            <input value={name} onChange={(event) => setName(event.target.value)} required />
          </label>
          <label className="register-field">
            <span>Email</span>
            <input type="email" value={email} onChange={(event) => setEmail(event.target.value)} required />
          </label>
          <label className="register-field">
            <span>Phone</span>
            <input value={phone} onChange={(event) => setPhone(event.target.value)} required />
          </label>
          {error && <div className="register-error">{error}</div>}
          <button type="submit" className="primary-button full-width" disabled={isSubmitting}>
            {isSubmitting ? 'Creating account...' : 'Register and Continue'}
          </button>
        </form>
      </div>
    </div>
  )
}

export default RegisterPage
