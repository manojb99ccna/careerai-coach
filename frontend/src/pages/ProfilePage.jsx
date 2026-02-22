import { useEffect, useState } from 'react'

function ProfilePage() {
  const [name, setName] = useState('')
  const [email, setEmail] = useState('')
  const [phone, setPhone] = useState('')
  const [onboardingComplete, setOnboardingComplete] = useState(false)
  const [isSaving, setIsSaving] = useState(false)

  useEffect(() => {
    const storedUser = localStorage.getItem('careerai_user')
    if (storedUser) {
      try {
        const parsed = JSON.parse(storedUser)
        setName(parsed.name || '')
        setEmail(parsed.email || '')
        setPhone(parsed.phone || '')
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

    const updatedUser = {
      name,
      email,
      phone,
    }

    localStorage.setItem('careerai_user', JSON.stringify(updatedUser))
    setTimeout(() => {
      setIsSaving(false)
    }, 400)
  }

  return (
    <div className="container py-4">
      <div className="row justify-content-center">
        <div className="col-lg-6">
          <div className="card shadow-sm">
            <div className="card-body">
              <h1 className="h5 mb-3">Profile</h1>
              <p className="text-muted mb-4">Manage the personal information used by CareerAI Coach.</p>
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

