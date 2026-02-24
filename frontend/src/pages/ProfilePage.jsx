import { useEffect, useState, useRef } from 'react'
import Webcam from 'react-webcam'
import { apiClient } from '../api/client'

const apiBaseUrl = import.meta.env.VITE_API_BASE_URL || 'http://localhost:8000'

function ProfilePage() {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [phone, setPhone] = useState('')
  const [onboardingComplete, setOnboardingComplete] = useState(false)
  const [isSaving, setIsSaving] = useState(false)
  const [profileImageName, setProfileImageName] = useState(null)
  const [isUpdatingImage, setIsUpdatingImage] = useState(false)
  const [showCamera, setShowCamera] = useState(false)

  useEffect(() => {
    const storedUser = localStorage.getItem('careerai_user')
    if (storedUser) {
      try {
        const parsed = JSON.parse(storedUser)
        setName(parsed.name || '')
        setEmail(parsed.email || '')
        setPhone(parsed.phone || '')
        setProfileImageName(parsed.profile_image || null)
      } catch {
        setName('')
        setEmail('')
        setPhone('')
      }
    }

    const onboardingFlag = localStorage.getItem('careerai_onboarding_complete')
    setOnboardingComplete(onboardingFlag === 'true')
  }, [])

  const handleSubmit = (event) => {
    event.preventDefault()
    setIsSaving(true)

    const storedUser = localStorage.getItem('careerai_user')
    let existing = {}
    if (storedUser) {
      try {
        existing = JSON.parse(storedUser)
      } catch {
        existing = {}
      }
    }

    const updatedUser = {
      ...existing,
      name,
      email,
      phone,
      profile_image: profileImageName || existing.profile_image || null,
    }

    localStorage.setItem('careerai_user', JSON.stringify(updatedUser))
    setTimeout(() => {
      setIsSaving(false)
    }, 400)
  }

  const saveProfileImageFile = async (file) => {
    const storedUser = localStorage.getItem('careerai_user')
    if (!storedUser) {
      return
    }

    let userId = null
    try {
      const parsed = JSON.parse(storedUser)
      userId = parsed && parsed.id
    } catch {
      userId = null
    }

    if (!userId) {
      return
    }

    setIsUpdatingImage(true)
    try {
      const formData = new FormData()
      formData.append('file', file)
      const response = await apiClient.put(`/users/${userId}/profile-image`, formData, {
        headers: { 'Content-Type': 'multipart/form-data' },
      })

      if (response.data) {
        const updatedUser = {
          ...response.data,
        }
        localStorage.setItem('careerai_user', JSON.stringify(updatedUser))
        setProfileImageName(response.data.profile_image || null)
      }
    } catch {
      setIsUpdatingImage(false)
      setShowCamera(false)
      return
    } finally {
      setIsUpdatingImage(false)
      setShowCamera(false)
    }
  }

  const handleFileChange = (event) => {
    const file = event.target.files && event.target.files[0]
    if (!file) {
      return
    }
    saveProfileImageFile(file)
  }

  const handleCaptureFromCamera = (webcamRef) => {
    if (!webcamRef.current) {
      return
    }
    const screenshot = webcamRef.current.getScreenshot()
    if (!screenshot) {
      return
    }

    const [header, data] = screenshot.split(',')
    if (!data) {
      return
    }
    const mimeMatch = header.match(/data:(.*?);/)
    const mime = mimeMatch ? mimeMatch[1] : 'image/jpeg'
    const binary = atob(data)
    const len = binary.length
    const bytes = new Uint8Array(len)
    for (let i = 0; i < len; i += 1) {
      bytes[i] = binary.charCodeAt(i)
    }
    const file = new File([bytes], 'profile-camera.jpg', { type: mime })
    saveProfileImageFile(file)
  }

  const webcamRef = useRef(null)

  return (
    <div className="container py-4">
      <div className="row justify-content-center">
        <div className="col-lg-6">
          <div className="card shadow-sm">
            <div className="card-body">
              <h1 className="h5 mb-3">Profile</h1>
              <p className="text-muted mb-4">Manage the personal information used by CareerAI Coach.</p>
              <div className="mb-4 d-flex align-items-center gap-3">
                {profileImageName ? (
                  <img
                    src={`${apiBaseUrl}/media/profile/${profileImageName}`}
                    alt="Profile"
                    width="72"
                    height="72"
                    className="rounded-circle"
                    style={{ objectFit: 'cover' }}
                  />
                ) : (
                  <div
                    className="rounded-circle bg-secondary text-white d-flex align-items-center justify-content-center"
                    style={{ width: '72px', height: '72px', fontSize: '24px' }}
                  >
                    {name ? name.charAt(0).toUpperCase() : 'U'}
                  </div>
                )}
                <div>
                  <div className="mb-2">
                    <label className="form-label mb-1">Profile image</label>
                    <input type="file" className="form-control" accept="image/*" onChange={handleFileChange} />
                  </div>
                  <button
                    type="button"
                    className="btn btn-outline-secondary btn-sm"
                    onClick={() => setShowCamera((prev) => !prev)}
                    disabled={isUpdatingImage}
                  >
                    {showCamera ? 'Close camera' : 'Use camera'}
                  </button>
                </div>
              </div>
              {showCamera && (
                <div className="mb-4">
                  <Webcam
                    audio={false}
                    screenshotFormat="image/jpeg"
                    className="w-100 rounded border"
                    ref={(ref) => {
                      webcamRef.current = ref
                    }}
                  />
                  <button
                    type="button"
                    className="btn btn-primary btn-sm mt-2"
                    onClick={() => handleCaptureFromCamera(webcamRef)}
                    disabled={isUpdatingImage}
                  >
                    {isUpdatingImage ? 'Saving...' : 'Capture and save'}
                  </button>
                </div>
              )}
              <div className="mb-3">
                <span className="badge bg-light text-dark me-2">Onboarding</span>
                <span className={onboardingComplete ? 'text-success' : 'text-warning'}>
                  {onboardingComplete ? 'Complete' : 'Pending'}
                </span>
              </div>
              <form onSubmit={handleSubmit}>
                <div className="mb-3">
                  <label className="form-label">Name</label>
                  <input
                    type="text"
                    className="form-control"
                    value={name}
                    onChange={(event) => setName(event.target.value)}
                    required
                  />
                </div>
                <div className="mb-3">
                  <label className="form-label">Email</label>
                  <input
                    type="email"
                    className="form-control"
                    value={email}
                    onChange={(event) => setEmail(event.target.value)}
                    required
                  />
                </div>
                <div className="mb-4">
                  <label className="form-label">Phone</label>
                  <input
                    type="text"
                    className="form-control"
                    value={phone}
                    onChange={(event) => setPhone(event.target.value)}
                    required
                  />
                </div>
                <button type="submit" className="btn btn-primary" disabled={isSaving}>
                  {isSaving ? 'Saving...' : 'Save changes'}
                </button>
              </form>
            </div>
          </div>
        </div>
      </div>
    </div>
  )
}

export default ProfilePage
