import { useCallback, useRef, useState } from 'react'
import Webcam from 'react-webcam'
import { useNavigate } from 'react-router-dom'
import { apiClient } from '../api/client'
import './FaceScanPage.css'

const videoConstraints = {
  width: 480,
  height: 360,
  facingMode: 'user',
}

function computeFaceEncoding(imageDataUrl) {
  const values = []
  const normalized = imageDataUrl || ''
  const length = Math.min(normalized.length, 256)

  for (let i = 0; i < length; i += 1) {
    const code = normalized.charCodeAt(i)
    values.push((code % 256) / 255)
  }

  while (values.length < 128) {
    values.push(0)
  }

  return values.slice(0, 128)
}

function FaceScanPage() {
  const webcamRef = useRef(null)
  const navigate = useNavigate()
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState('')

  const handleScan = useCallback(async () => {
    if (!webcamRef.current) return

    const screenshot = webcamRef.current.getScreenshot()
    if (!screenshot) {
      setError('Unable to capture image from camera. Please try again.')
      return
    }

    setError('')
    setIsLoading(true)
    try {
      const encoding = computeFaceEncoding(screenshot)
      localStorage.setItem('careerai_face_encoding', JSON.stringify(encoding))

      const response = await apiClient.post('/auth/face/login', {
        encoding,
      })

      if (response.data.status === 'login_success') {
        if (response.data.token) {
          localStorage.setItem('careerai_token', response.data.token)
        }
        if (response.data.user) {
          localStorage.setItem('careerai_user', JSON.stringify(response.data.user))
        }

        const userId = response.data.user && response.data.user.id
        if (userId) {
          try {
            await apiClient.get(`/users/${userId}/onboarding`)
            localStorage.setItem('careerai_onboarding_complete', 'true')
            navigate('/dashboard')
            return
          } catch (error) {
            if (error.response && error.response.status === 404) {
              localStorage.setItem('careerai_onboarding_complete', 'false')
              navigate('/onboarding')
              return
            }
          }
        }

        navigate('/dashboard')
      } else if (response.data.status === 'register_required') {
        navigate('/register')
      } else {
        setError('Unexpected response from server.')
      }
    } catch (e) {
      setError('There was a problem contacting the server. Please try again.')
    } finally {
      setIsLoading(false)
    }
  }, [navigate])

  return (
    <div className="scan-container">
      <div className="scan-card">
        <h1 className="scan-title">Face Scan Login</h1>
        <p className="scan-subtitle">Align your face in the frame and tap scan to continue.</p>
        <div className="scan-webcam-wrapper">
          <Webcam
            ref={webcamRef}
            audio={false}
            screenshotFormat="image/jpeg"
            videoConstraints={videoConstraints}
            className="scan-webcam"
          />
        </div>
        {error && <div className="scan-error">{error}</div>}
        <button type="button" className="primary-button full-width" onClick={handleScan} disabled={isLoading}>
          {isLoading ? 'Scanning...' : 'Scan Face'}
        </button>
       
      </div>
    </div>
  )
}

export default FaceScanPage
