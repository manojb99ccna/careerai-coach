import { useCallback, useRef, useState, useEffect } from 'react'
import Webcam from 'react-webcam'
import { useNavigate } from 'react-router-dom'
import * as faceapi from 'face-api.js'
import { apiClient } from '../api/client'
import './FaceScanPage.css'

const videoConstraints = {
  width: 480,
  height: 360,
  facingMode: 'user',
}

function FaceScanPage() {
  const webcamRef = useRef(null)
  const navigate = useNavigate()
  const [isLoading, setIsLoading] = useState(false)
  const [error, setError] = useState('')
  const [modelsLoaded, setModelsLoaded] = useState(false)

  useEffect(() => {
    const loadModels = async () => {
      const MODEL_URL = 'https://justadudewhohacks.github.io/face-api.js/models'
      try {
        await Promise.all([
          faceapi.nets.tinyFaceDetector.loadFromUri(MODEL_URL),
          faceapi.nets.faceLandmark68Net.loadFromUri(MODEL_URL),
          faceapi.nets.faceRecognitionNet.loadFromUri(MODEL_URL),
        ])
        setModelsLoaded(true)
      } catch (err) {
        console.error("Failed to load models", err)
        setError("Failed to load face recognition models. Please refresh.")
      }
    }
    loadModels()
  }, [])

  const handleScan = useCallback(async () => {
    if (!webcamRef.current) return
    if (!modelsLoaded) {
      setError("Models are still loading, please wait...")
      return
    }

    const screenshot = webcamRef.current.getScreenshot()
    if (!screenshot) {
      setError('Unable to capture image from camera. Please try again.')
      return
    }

    setError('')
    setIsLoading(true)
    try {
      // Create an image element to pass to face-api
      const img = document.createElement('img')
      img.src = screenshot
      
      // Wait for image load (though data URL is usually sync, good practice)
      if (!img.complete) {
          await new Promise((resolve) => {
              img.onload = resolve
              img.onerror = resolve
          })
      }

      // Detect face
      const detection = await faceapi.detectSingleFace(img, new faceapi.TinyFaceDetectorOptions())
        .withFaceLandmarks()
        .withFaceDescriptor()
      
      if (!detection) {
        setError("No face detected. Please adjust lighting or position.")
        setIsLoading(false)
        return
      }

      const encoding = Array.from(detection.descriptor)
      
      localStorage.setItem('careerai_face_encoding', JSON.stringify(encoding))
      localStorage.setItem('careerai_face_image', screenshot)

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
    } catch (err) {
      console.error(err)
      setError('There was a problem processing the face scan. Please try again.')
    } finally {
      setIsLoading(false)
    }
  }, [navigate, modelsLoaded])

  return (
    <div className="scan-container">
      <div className="scan-card">
        <h1 className="scan-title">Face Scan Login</h1>
        <p className="scan-subtitle">
          {modelsLoaded ? 'Align your face in the frame and tap scan to continue.' : 'Loading face recognition models...'}
        </p>
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
        <button 
          type="button" 
          className="primary-button full-width" 
          onClick={handleScan} 
          disabled={isLoading || !modelsLoaded}
        >
          {isLoading ? 'Scanning...' : (modelsLoaded ? 'Scan Face' : 'Loading Models...')}
        </button>
       
      </div>
    </div>
  )
}

export default FaceScanPage
